class Admin::ProjectsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

private
  def init_view
    super
    if %w(new create edit update).include?(params[:action])
      scope = Job.ordered
      @jobs = [["", ""]] + scope.map { |e| [e.name, e.id.to_s] }
    end
  end

  def strong_params
    %w(
      active highlight name year website_url description job_id
      seo_title seo_h1 seo_description seo_keywords
    )
  end
end
