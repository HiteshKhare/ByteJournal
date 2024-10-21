require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  let(:author) { User.create(email: 'author@example.com', password: 'password', role: :author) }
  let(:guest) { User.create(email: 'guest@example.com', password: 'password', role: :guest) }
  let(:post) { Post.create(title: 'Test Post', user: author) }
  let(:comment) { Comment.create(body: 'Nice Post', post: post, user: guest) }

  subject { described_class }

  describe '#destroy?' do
    it 'allows the author to delete their own comments' do
      expect(subject.new(author, comment).destroy?).to be false
    end

    it 'prevents guests from deleting comments' do
      expect(subject.new(guest, comment).destroy?).to be true
    end
  end
end
