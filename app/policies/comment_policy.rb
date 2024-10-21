class CommentPolicy < ApplicationPolicy
  def create?
    user.guest? || user.author?
  end

  def update?
    user.author? && record.user_id == user.id
  end

  def destroy?
    record.user == user # Ensure comment's user matches the current user (author).
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
