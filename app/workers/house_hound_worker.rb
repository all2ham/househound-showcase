class HouseHoundWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5, backtrace: true

  def perform
    raise 'This needs to be implemented by the inherited class'
  end
end