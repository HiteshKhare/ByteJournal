require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  before { ActionMailer::Base.deliveries.clear }
  
  describe 'welcome_email' do
    let(:user) { double('User', email: 'test@example.com') }
    let(:mail) { UserMailer.welcome_email(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Welcome to My App')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'delivers the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an email' do
      user = double('User', email: 'test@example.com')
      mailer = instance_double(ActionMailer::MessageDelivery)

      allow(UserMailer).to receive(:welcome_email).and_return(mailer)
      expect(mailer).to receive(:deliver_now)

      UserMailer.welcome_email(user).deliver_now
    end
  end
end
