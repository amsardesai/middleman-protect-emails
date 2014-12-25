require 'middleman-core/util'

class Middleman::ProtectEmailsExtension < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
  end

  def after_configuration
    app.use Middleware, middleman_app: app
  end

  class Middleware
    def initialize(app, options = {})
      @rack_app = app
      @middleman_app = options[:middleman_app]
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
      # TODO: Don't replace plaintext mailto links
      new_content = body.gsub /mailto:([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})/i do
        replaced_email = true
        email = $1.tr 'A-Za-z','N-ZA-Mn-za-m'
        "#email-protection-#{email}"
      end

      # Don't do anything else if there are no emails on the page
      return body unless replaced_email

      # Reads decoding script
      file = File.join(File.dirname(__FILE__), 'rot13_script.html')
      script_content = File.read file

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
