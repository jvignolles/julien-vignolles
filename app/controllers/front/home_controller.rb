class Front::HomeController < Front::BaseController
  def index
    @editorial = Editorial.find_by_kind(:homepage)
    #@banners = Banner.active.ordered.limit(3).includes(:images)
    if @configuration.highlighted_projects_active?
      @highlighted_projects = Project.active.highlighted.ordered.limit(6).includes(:images)
    end
    if @configuration.entertainments_active?
      @entertainments = Entertainment.active.ordered.limit(6).includes(:images)
    end
    @front_kind = :homepage
    @active_menus << :homepage
    if @editorial.present?
      add_seo_fields @editorial
      @page_heading = @editorial.name
    end
    @page_heading = @configuration.baseline if @page_heading.blank?
  end
end
