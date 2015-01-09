class Front::JobsController < Front::BaseController
  def index
    scope = Job.active.ordered.includes(:company)
    @jobs = scope.reverse
    scope = Education.active.ordered
    @educations = scope.reverse
    @front_kind = "jobs"
    @page_heading = "Expériences"
    key = "jobs"
    @breadcrumbs << { key: key, name: @page_heading, url: front_jobs_path }
  end
end
