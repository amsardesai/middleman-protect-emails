require 'middleman-core/util'

class Middleman::ProtectEmailsExtension < ::Middleman::Extension

  option :prefix, '#email-protection-', 'Prefix to use for encoded links'

  def initialize(app, options_hash={}, &block)
    super
  end

  def after_configuration
    app.use Middleware, middleman_app: app, options: options
  end

  class Middleware
    def initialize(app, options = {})
      @rack_app = app
      @middleman_app = options[:middleman_app]
      @options = options[:options]
    end

    def call(env)
      status, headers, response = @rack_app.call(env)

      # Get path
      path = ::Middleman::Util.full_path(env['PATH_INFO'], @middleman_app)

      # Match only HTML documents
      if path =~ /(^\/$)|(\.(htm|html)$)/
        body = ::Middleman::Util.extract_response_text(response)
        if body
          status, headers, response = Rack::Response.new(rewrite_response(body), status, headers).finish
        end
      end

      [status, headers, response]
    end

    private

    def rewrite_response(body)
      # Keeps track of email replaces
      replaced_email = false

      # Replaces mailto links with ROT13 equivalent
      invalid_character = '\s"\'>'
      email_username = "[^@#{invalid_character}]+"
      email_domain = "[^?#{invalid_character}]+"
      email_param = "[^&#{invalid_character}]+"
      email = "(?<email>(?<email_username>#{email_username})@#{email_domain})(?<email_params>\\?#{email_param}(\\&#{email_param})*)?"
      new_content = body.gsub /<a(?<tag_before>[^>]*)mailto:(?<mailto>#{email})(?<tag_after>[^>]*)>(?<text>.*?)<\/a>/i do
        replaced_email = true
        mailto = Regexp.last_match(:mailto)
        email = Regexp.last_match(:email)
        text = Regexp.last_match(:text)
        email_username = Regexp.last_match(:email_username)
        tag_before = Regexp.last_match(:tag_before)
        tag_after = Regexp.last_match(:tag_after)

        text = text.gsub(email, "#{email_username}@email")
        mailto = mailto.tr 'A-Za-z','N-ZA-Mn-za-m'
        "<a#{tag_before}#{@options.prefix}#{mailto}#{tag_after}>#{text}</a>"
      end

      # Don't do anything else if there are no emails on the page
      return body unless replaced_email

      # Reads decoding script
      file = File.join(File.dirname(__FILE__), 'rot13_script.html')
      script_content = File.read file
      script_content = script_content.gsub("#email-protection-", @options.prefix)

      # Appends decoding script at end of body or end of page
      if new_content =~ /<\/body>/i
        new_content.gsub(/(<\/body>)/i) do
          script_content + $1
        end
      else
        new_content + script_content
      end
    end
  end
end
