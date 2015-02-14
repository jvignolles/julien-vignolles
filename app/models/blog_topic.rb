class BlogTopic < ActiveRecord::Base
  IMAGE_KINDS = {
    :banner => "Bannière",
  }.freeze 
  IMAGE_LEGENDABLE = true

  acts_as_clean_html :introduction, :description
  slug :name
  strip_fields :name, :introduction, :description

  #=== Validations
  validates_presence_of :name

  #=== Triggers
  # …

  #=== Associations
  belongs_to :admin
  has_and_belongs_to_many :blog_tags, -> { order "position" }, join_table: "blog_tags_blog_topics"
  has_many   :images, -> { order "position" }, as: :imageable, dependent: :destroy

  #=== Scopes
  scope :active,          -> { where(active: true) }
  scope :ordered,         -> { order("blog_topics.published_at desc, blog_topics.id desc") }
  scope :before_datetime, -> {
    opts ||= {}
    opts = opts[:datetime] if opts.is_a?(Hash)
    opts = Time.zone.now if opts.blank?
    where(["published_at <= ?", opts])
  }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (blog_topics.id = ?"
      conditions += [word.to_i]
      ["name"].each do |field|
        conditions[0] << " or blog_topics.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }
  scope :for_tag, ->(opts) {
    opts = opts.values if opts.is_a?(Hash)
    opts = [opts].flatten.reject(&:blank?)
    next where(nil) if opts.blank?
    joins = %(inner join blog_tags_blog_topics btft_btbt on (btft_btbt.blog_topic_id = blog_topics.id))
    joins(joins).where(["btft_btbt.blog_tag_id in (?)", opts]).group("blog_topics.id")
  }
end
