class AutomateActivities
  include Sidekiq::Worker

  def perform()
    p " do some !"
    p " name #{name} "
    p " count #{count} "
  end
end
