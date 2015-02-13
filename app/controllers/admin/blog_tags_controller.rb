class Admin::BlogTagsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

  def strong_params
    %w(active name description)
  end
end
