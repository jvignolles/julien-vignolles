class Admin::ProjectsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

private
  def init_view
    super
    if %w(new create edit update).include?(params[:action])
      scope = Job.ordered.includes(:company)
      @jobs = [["", ""]] + scope.map do |e|
        name = e.company ? "#{e.company.name} : #{e.name}" : e.name
        [name, e.id.to_s]
      end
      scope = Skill.ordered
      @skills = [["", ""]] + scope.map { |e| [e.name, e.id.to_s] }
    end
  end

  def search(search = {})
    p = params[:search] || {}
    m = model_name.constantize
    scoped = m.ordered.paginate(page: params[:page], per_page: @per_page)
    if m.respond_to?(:adm_for_text)
      scoped = scoped.adm_for_text(p[:text])
    end
    scoped = scoped.includes(:images)
    scoped
  end

  def strong_params
    a = %w(
      active highlight name year website_url description job_id company_description
      seo_title seo_h1 seo_description seo_keywords
    )
    a << { skill_ids: [] }
    a
  end
end
