class BlogTag < ActiveRecord::Base
  #acts_as_seo_keywords :seo_keywords
  reorderable
  slug :name
  strip_fields :name, :description, :seo_title, :seo_description, :seo_keywords

  #=== Validations
  validates :name, presence: true, maxlength_auto: true
  validates_presence_of :name

  #=== Triggers
  # …

  #=== Associations
  has_and_belongs_to_many :blog_topics, -> { order "blog_topics.published_at desc" }, join_table: "blog_tags_blog_topics"

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("blog_tags.name, blog_tags.id") }
  scope :ordered,      -> { order("blog_tags.position, blog_tags.id") }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (blog_tags.id = ?"
      conditions += [word.to_i]
      ["name", "description"].each do |field|
        conditions[0] << " or blog_tags.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }
  scope :with_active_blog_topics, -> {
    opts = {} if opts.blank?
    now = Time.zone.now
    joins = %(
      INNER JOIN blog_tags_blog_topics btwabt_j ON (btwabt_j.blog_tag_id = blog_tags.id)
      INNER JOIN blog_topics btwabt_bt ON (btwabt_j.blog_topic_id = btwabt_bt.id)
    )
    conditions = ["btwabt_bt.active = ? and btwabt_bt.published_at <= ?", true, now]
    joins(joins).where(conditions).group("blog_tags.id")
  }
end
