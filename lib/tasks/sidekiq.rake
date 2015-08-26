namespace :sidekiq do
  desc 'Clear sidekiq queue'
  task clear: :environment do
    require 'sidekiq/api'
    Sidekiq::Queue.all.each(&:clear)
  end
end
