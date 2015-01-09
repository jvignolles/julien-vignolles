class Admin::EducationsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

private
  def strong_params
    %w(
      active name establishment location option started_at ended_at description
    )
  end
end
