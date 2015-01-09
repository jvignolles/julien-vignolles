class Admin::JobsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

private
  def init_view
    super
    if %w(new create edit update).include?(params[:action])
      scope = Company.ordered
      @companies = [["", ""]] + scope.map { |e| [e.name, e.id.to_s] }
      scope = Skill.ordered
      @skills = [["", ""]] + scope.map { |e| [e.name, e.id.to_s] }
    end
  end

  def strong_params
    a = %w(
      active name started_at ended_at description company_id
      seo_title seo_h1 seo_description seo_kerywords
    )
    a << { skill_ids: [] }
    a
  end
end
