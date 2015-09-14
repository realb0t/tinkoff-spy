Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/5', namespace: "latera" }

  schedule_file = Rails.root.join('config', 'schedule.yml')
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/5', namespace: "latera" }
end

