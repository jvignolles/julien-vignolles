class Project < ActiveRecord::Base
  IMAGE_KINDS = {
    :preview => "Photo",
    :logo =>    "Logo",
  }
  IMAGE_LEGENDABLE = true

  acts_as_clean_html :description
  #acts_as_seo_keywords :seo_keywords
  reorderable
  slug :name
  strip_fields :name, :description, :year, :website_url
  strip_fields :seo_title, :seo_h1, :seo_description, :seo_keywords

  #=== Validations
  validates :name, presence: true, maxlength_auto: true

  #=== Triggers
  # …

  #=== Associations
  belongs_to :job
  has_many   :images, -> { order "position" }, as: :imageable, dependent: :destroy
  has_and_belongs_to_many :skills, -> { order "position" }

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("projects.name, projects.id") }
  scope :chronological, -> { order("projects.created_at, projects.id") }
  scope :highlighted,  -> { where(highlight: true) }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (projects.id = ?"
      conditions << word.to_i
      ["name", "description"].each do |field|
        conditions[0] << " or projects.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }

  #=== Methods
  # …
end
