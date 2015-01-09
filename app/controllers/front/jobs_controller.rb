class Front::JobsController < Front::BaseController
  def index
    @jobs = Job.active.ordered.includes(:company)
    @educations = Education.active.ordered
    @front_kind = "jobs"
    @page_heading = "Expérience"
    key = "jobs"
    @breadcrumbs << { key: key, name: @page_heading, url: front_jobs_path }
  end
end
