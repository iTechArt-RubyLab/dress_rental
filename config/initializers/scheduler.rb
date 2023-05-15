require 'sidekiq/scheduler'

Sidekiq::Scheduler.enabled = false
Sidekiq::Scheduler.dynamic = true
Sidekiq::Scheduler.listened_queues_only = true

Sidekiq.configure_server do |config|
  config.on(:startup) do
    YAML.load_file(Rails.root.join('config/schedule.yml')).each do |job_name, job_config|
      Sidekiq.set_schedule(job_name, job_config)
    end
    Sidekiq::Scheduler.instance.enabled = true
    Sidekiq::Scheduler.instance.dynamic_every = 10
    Sidekiq::Scheduler.instance.load_schedule!
  end
end