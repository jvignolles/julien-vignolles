class Front::ProjectsController < Front::BaseController
  def index
    @editorial = Editorial.find_by_kind(:projects)
    @projects = Project.active.ordered.includes(:images, :skills)
    @front_kind = "projects"
    @active_menus << :projects
    @page_heading = "Portfolio"
    key = "projects"
    @breadcrumbs << { key: key, name: @page_heading, url: front_projects_path }

    # SEO
    @page_title = "Porfolio de #{app_name}"
    @page_description = "Sélection de projets Ruby on Rails auxquels j’ai contribué : #{@projects.map(&:name)[0..3].join(', ')}…"
    @page_keywords = "#{app_name}, porfolio, projets, web, développement, ruby on rails, lead developper, CTO, chef de projet, freelance, consultant, indépendant, paris"
    add_seo_fields @editorial
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
    @front_kind = "project"
    @active_menus << :projects
    @page_heading = @project.name
    @breadcrumbs << { key: "projects", name: "Portfolio", url: front_projects_path }
    @breadcrumbs << { key: "projects-#{@project.id}", name: @page_heading, url: front_project_path(id: @project) }

    # SEO
    @page_title = "#{@page_heading} • Portfolio de #{app_name}"
    @page_description = trunc_html(@project.description, 160)
    @page_keywords = "#{@project.name}, développement, ruby on rails, lead developer, CTO, chef de projet, freelance, consultant, indépendant"
    @page_keywords += @project.skills.active.map { |x| ", #{x.name}" }.join
    add_seo_fields @project
  end
end
