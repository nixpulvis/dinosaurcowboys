module Taggable
  extend ActiveSupport::Concern

  included do
    serialize :permissions, Hash
  end

  def has_access(user, attribute, permission)
    access = false
    self.permissions.each do |k, v|
      if k == :_
        access ||= self.permissions[k].include?(user)
    end
  end

end
