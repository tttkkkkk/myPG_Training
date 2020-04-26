require_relative 'boot'

require 'rails/all'
# Pick the frameworks you want:
# require "active_model"
# require "active_job/railtie"
# require "active_record/railtie"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyPG
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # Don't generate system test files.
    config.generators.system_tests = nil
    #バリデーション時のレイアウト崩れを防ぐ
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end
    # lib配下のパスを読み込む
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
