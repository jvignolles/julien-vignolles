class Front::BlogTopicsController < Front::BaseController
  layout "front_blog"
  before_filter :check_blog_active

  def index
    if params[:blog_tag_id].present?
      @blog_tag = BlogTag.find_by_id(params[:blog_tag_id])
      if !@blog_tag || !@blog_tag.active
        if @blog_tag && current_admin
          flash[:warning] = "Attention, cette page est actuellement inactive : elle n’est pas affichée aux internautes"
        else
          flash[:error] = "Cette page n’existe plus"
          return redirect_to(front_blog_topics_path)
        end
      end
      # TODO: this redirection skips params. CARE!
      correct_url = front_blog_tag_path(blog_tag_id: @blog_tag)
      if request.original_fullpath != correct_url
        # DEV NOTE: SEO safe, avoid duplicate URLs if blog_tag is renamed.
        return redirect_to(correct_url, status: 301)
      end
    end
    @blog_topics = search(@blog_tag)
    if @blog_tag
      @page_heading = @blog_tag.name
      @page_title = "#{@page_heading}, blog de #{app_name}"
    else
      @page_heading = "Blog"
      @page_title = "#{@page_heading} de #{app_name}"
    end
    if 1 < (page = params[:page].to_i)
      @page_title += " (page #{page})"
      @noindex = true
    end
    @front_kind = "blog-topics"
    init_view
  end

  def show
    @blog_topic = BlogTopic.find_by_id(params[:id])
    if !@blog_topic || !@blog_topic.active
      if @blog_topic && current_admin
        flash[:warning] = "Attention, cette page est actuellement inactive : elle n’est pas affichée aux internautes"
      else
        flash[:error] = "Cette page n’existe plus"
        return redirect_to(front_blog_topics_path)
      end
    end
    # TODO: this redirection skips params. CARE!
    correct_url = front_blog_topic_path(id: @blog_topic)
    if request.original_fullpath != correct_url
      # DEV NOTE: SEO safe, avoid duplicate URLs if blog_topic is renamed.
      return redirect_to(correct_url, status: 301)
    end
    @front_kind = "blog-topic"
    init_view
  end

private
  def check_blog_active
    unless @configuration.blog_active? || current_admin
      flash[:error] = "Cette page n’est pas disponible"
      return redirect_to front_home_path
    end
    true
  end

  def search(tag = nil)
    scoped = BlogTopic.active.ordered.before_datetime
    if tag.present?
      scoped = scoped.for_tag(tag)
    end
    scoped = scoped.includes(:blog_tags)
    scoped = scoped.paginate(page: params[:page], per_page: @per_page || 10)
    scoped
  end

  def init_view
    @blog_tags = BlogTag.active.ordered.with_active_blog_topics
    @breadcrumbs << { key: "blog_topics", name: "Blog", url: front_blog_topics_path }
    @active_menus << :blog
    if @blog_topic.present?
      @breadcrumbs << { key: "blog_topic", name: @blog_topic.name, url: front_blog_topic_path(id: @blog_topic) }

      # SEO
      @page_heading = @blog_topic.name
      @page_title = "#{@blog_topic.name} • Blog de #{app_name}"
      @page_description = trunc_html(@blog_topic.introduction, 160)
      add_seo_fields @blog_topic
    elsif @blog_tag
      @breadcrumbs << { key: "blog_tag", name: @blog_tag.name, url: front_blog_tag_path(blog_tag_id: @blog_tag) }

      # SEO
      @page_title = "#{@blog_tag.name} • Blog de #{app_name}"
      @page_description = trunc_html(@blog_tag.description, 160)
      add_seo_fields @blog_tag
    end
  end
end
