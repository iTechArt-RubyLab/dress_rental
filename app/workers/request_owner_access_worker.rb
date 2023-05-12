class RequestOwnerAccessWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    if user.present?
      UserMailer.request_owner_access(user).deliver_now
    end
  end
end