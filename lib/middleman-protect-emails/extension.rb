module Middleman
  class ProtectEmailsExtension < Extension

    def initialize
      super
    end

    def after_configuration
      app.use Middleware, middleman_app: app
    end

    class Middleware
      def initialize(app, options = {})
        @rack_app = app

      end
    end


  end
end
