class Front::ProjectsController < Front::BaseController
  def index
    @front_kind = "projects"
    scope = Project.active.ordered.includes(:images, :skills)
    @projects = scope.reverse
    @page_heading = "Portfolio"
    @page_title = "#{@page_heading} | #{app_name}"
    @page_description = "Consultez ma sélection de projets."
    key = "projects"
    @breadcrumbs << { key: key, name: @page_heading, url: front_projects_path }
  end

  def show
    @project = Project.find_by_id(params[:id])
    if !@project || !@project.active
      if @project && current_admin
        flash[:warning] = "Attention, cette page est actuellement inactive : elle n’est pas affichée aux internautes"
      else
        flash[:alert] = "Cette page n’existe plus"
        return redirect_to(front_home_path)
      end
    end
    # TODO: this redirection skips params (but they aren't currently used). CARE!
    correct_url = front_project_path(id: @project)
    if request.original_fullpath != correct_url
      # DEV NOTE: SEO safe, avoid duplicate URLs if project is renamed.
      return redirect_to(correct_url, status: 301)
    end
    @page_heading = @project.name
    @front_kind = "project"
    @geocoding_assets = true
    @page_title = "#{@page_heading} | #{app_name}"
    @breadcrumbs << { key: "projects-#{@project.id}", name: @page_heading, url: front_project_path(id: @project) }
    add_seo_fields @project
  end
end
