class Admin::BlogTopicsController < Admin::BaseController
  include AdminActions # See /app/concerns/admin_actions.rb

  def init_view
    super
    if [:new, :create, :edit, :update].include?(params[:action].to_sym)
      scope = BlogTag.active.ordered
      @blog_tags = [["", ""]] + scope.map { |e| [e.name, e.id.to_s] }
    end
  end

  def strong_params
    array = %w(active name introduction description published_at)
    array << { blog_tag_ids: [] }
    array
  end
end
