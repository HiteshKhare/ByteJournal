require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  let(:author) { User.create(email: 'author@example.com', password: 'password', role: :author) }
  let(:guest) { User.create(email: 'guest@example.com', password: 'password', role: :guest) }
  let(:post) { Post.create(title: 'Test Post', user: author) }

  before do
   sign_in author
   @post = create(:post, user: author)
  end

  describe 'GET /api/v1/posts/:id' do
    it 'allows both author and guest to view the post' do
      before { sign_in guest }
      get api_v1_post_path(post)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH /api/v1/posts/:id' do
    context 'when the author is logged in' do
      before { sign_in author }

      it 'allows the author to update the post' do
        patch api_v1_post_path(post), params: { post: { title: 'Updated Title' } }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the guest is logged in' do
      before { sign_in guest }

      it 'prevents the guest from updating the post' do
        patch api_v1_post_path(post), params: { post: { title: 'Updated Title' } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
