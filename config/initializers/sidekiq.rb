Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
  schedule_file = "config/schedule.yml"
end