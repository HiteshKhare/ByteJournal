class PostPolicy < ApplicationPolicy
  def show?
    true # Everyone can view posts
  end

  def create?
    user.author? # Only authors can create posts
  end

  def update?
    user.author? && record.user == user # Only the post's author can update it
  end

  def destroy?
    user.author? && record.user == user # Only the post's author can delete it
  end

  # class Scope < ApplicationPolicy::Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end
end
