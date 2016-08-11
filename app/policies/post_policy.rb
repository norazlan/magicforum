class PostPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user.present? && record.user_id == user.id || user_has_power?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  private

  def user_has_power?
    user.admin? || user.moderator?
  end
  
end
