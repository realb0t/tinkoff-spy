require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Latera
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.stylesheets false
      g.test_framework :rspec
      g.fixture_replacement :factory_girl
    end
  end
end
