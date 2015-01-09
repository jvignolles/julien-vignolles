class Admin::CompaniesController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

private
  def strong_params
    %w(active name location website_url)
  end
end
