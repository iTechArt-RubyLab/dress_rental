require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe RequestOwnerAccessWorker, type: :worker do
  it 'sends an email to the user requesting owner access' do
    user = create(:user)

    expect { RequestOwnerAccessWorker.perform_async(user.id) }.to change { Sidekiq::Queues['default'].size }.by(1)

    perform_enqueued_jobs do
      RequestOwnerAccessWorker.new.perform(user.id)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
    end
  end

  it 'does not create job if user does not exist' do
    expect { RequestOwnerAccessWorker.perform_async(0) }.to_not change { Sidekiq::Queues['default'].size }
  end
end
