require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  let(:author) { User.create(email: 'author@example.com', password: 'password', role: :author) }
  let(:guest) { User.create(email: 'guest@example.com', password: 'password', role: :guest) }
  let(:post) { create(:post, user: author) }
  let(:comment) { create(:comment, post: post, user: author) }

  before { sign_in guest } # Devise helper to log in the guest

  describe 'POST /api/v1/posts/:post_id/comments' do
    it 'allows the guest to create a comment' do
      post api_v1_post_comments_path(post), params: { comment: { body: 'Nice comment' } }
      expect(response).to have_http_status(:created)
    end
  end
end
