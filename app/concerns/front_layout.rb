module FrontLayout
  def self.included(base)
    base.class_eval do
      helper Front::BaseHelper
      layout :set_layout
      before_filter :set_current_locale
      before_filter :check_on_hold_status
      #before_filter :authenticate_front!
      before_filter :clean_params
      before_filter :init_front_layout
    end
  end

protected
  def add_seo_fields(item)
    return unless item
    if item.seo_title.present?
      @page_title = item.seo_title
    end
    if item.seo_h1.present?
      @page_heading = item.seo_h1
    end
    if item.seo_description.present?
      @page_description = item.seo_description
    end
    if item.seo_keywords.present?
      @page_keywords = item.seo_keywords
    end
  end

  def clean_params
    [:page, :per_page].each { |attr| params.delete(attr) if params[attr].to_i <= 1 }
    true
  end

  def init_front_layout
    @configuration ||= ::Configuration.instance

    # Content
    @front_kind = :default
    @display_breadcrumbs = true
    @active_menus = []
    @header_menu = {
      homepage: { name: "Accueil",   url: front_home_path },
      projects: { name: "Portfolio", url: front_projects_path },
      jobs:     { name: "CV",        url: front_jobs_path },
      contacts: { name: "Contact",   url: new_front_contact_path },
    }
    @breadcrumbs = [{ key: "homepage", name: "Accueil", url: front_home_path }]

    # SEO
    @page_title = @configuration.seo_title
    @page_title = @configuration.app_name if @page_title.blank?
    @page_description = @configuration.seo_description
    @page_keywords = @configuration.seo_keywords
    true
  end

  def init_view
    # Should be overriden by controllers
    true
  end

  def set_current_locale
    set_locale(false)
  end

  def set_layout
    "front_intern"
  end
end
