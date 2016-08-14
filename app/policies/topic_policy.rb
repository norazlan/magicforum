class TopicPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def create?
    new?
  end

  def edit?
    user.present? && power_user?
  end

  def update?
    user.present? && power_user?
  end

  def destroy?
    user.present? && record.user == user || power_user?
  end

  private
  def power_user?
    user.admin? || user.moderator?
  end

end
