require 'middleman-core'
require 'middleman-protect-emails/version'

::Middleman::Extensions.register(:protect_emails) do
  require 'middleman-protect-emails/extension'
  ::Middleman::ProtectEmailsExtension
end
