class SitemapsController < ApplicationController
  def index
    @configuration = ::Configuration.instance
    @static_pages = [
      { priority: 1.0, frequency: 'daily',  url: front_home_url },
      { priority: 0.9, frequency: 'daily',  url: front_jobs_url },
      { priority: 0.7, frequency: 'daily',  url: front_projects_url },
      { priority: 0.4, frequency: 'weekly', url: front_contacts_url },
    ]
    if @configuration.blog_active?
      @static_pages << { priority: 0.7, frequence: 'daily', url: front_blog_topics_url }
    end
    @projects = Project.active.ordered
    respond_to do |format|
      format.xml
    end
  end
end
