# frozen_string_literal: true

#
# This is would normally be part of authentication process (e.g. devise current_user)
# but we don't have authentication in this app. So we set the first user as the current user.
#
module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action :set_current_attributes
  end

  private

  def set_current_attributes
    Current.user = User.where(logged_in: true).first
  end
end
