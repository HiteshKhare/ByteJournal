module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      attributes :id, :title, :content, :created_at, :updated_at
    end
  end
end