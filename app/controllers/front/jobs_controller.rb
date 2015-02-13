class Front::JobsController < Front::BaseController
  def index
    @jobs = Job.active.ordered.includes(:company)
    @educations = Education.active.ordered
    @front_kind = "jobs"
    @active_menus << :jobs
    @page_heading = "CV"
    key = "jobs"
    @breadcrumbs << { key: key, name: @page_heading, url: front_jobs_path }

    # SEO
    @page_title = "CV de #{app_name}"
    @page_description = "Mon parcours : lead developer et chef de projet en agence web, freelance Ruby on Rails, consultant CTO…"
    @page_keywords = "CV, CTO, lead developer, ruby on rails, freelance, consultant, indépendant"
  end
end
