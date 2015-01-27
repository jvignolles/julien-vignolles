class Front::JobsController < Front::BaseController
  def index
    @jobs = Job.active.ordered.includes(:company)
    @educations = Education.active.ordered
    @front_kind = "jobs"
    @active_menus << :jobs
    @page_heading = "CV"
    key = "jobs"
    @breadcrumbs << { key: key, name: @page_heading, url: front_jobs_path }
  end
end
