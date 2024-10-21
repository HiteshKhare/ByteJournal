require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  let(:author) { User.create(email: 'author@example.com', password: 'password', role: :author) }
  let(:guest) { User.create(email: 'guest@example.com', password: 'password', role: :guest) }
  let(:post) { Post.create(title: 'Test Post', user: author) }
  
  subject { described_class }

  describe '#show?' do
    it 'allows everyone to view the post' do
      expect(subject.new(guest, post).show?).to be true
      expect(subject.new(author, post).show?).to be true
    end
  end

  describe '#create?' do
    it 'allows only authors to create posts' do
      expect(subject.new(author, Post.new).create?).to be true
      expect(subject.new(guest, Post.new).create?).to be false
    end
  end

  describe '#update?' do
    it 'allows the post author to update the post' do
      expect(subject.new(author, post).update?).to be true
    end

    it 'prevents a guest from updating the post' do
      expect(subject.new(guest, post).update?).to be false
    end
  end

  describe '#destroy?' do
    it 'allows the post author to delete the post' do
      expect(subject.new(author, post).destroy?).to be true
    end

    it 'prevents a guest from deleting the post' do
      expect(subject.new(guest, post).destroy?).to be false
    end
  end
end
