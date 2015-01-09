class Job < ActiveRecord::Base
  acts_as_clean_html :description
  #acts_as_seo_keywords :seo_keywords
  reorderable
  slug :name
  strip_fields :name, :description
  strip_fields :seo_title, :seo_h1, :seo_description, :seo_keywords

  #=== Validations
  validates :name, presence: true, maxlength_auto: true

  #=== Triggers
  # …

  #=== Associations
  belongs_to :company
  has_and_belongs_to_many :skills, -> { order "position" }

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("jobs.name, jobs.id") }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (jobs.id = ?"
      conditions << word.to_i
      ["name", "description"].each do |field|
        conditions[0] << " or jobs.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }

  #=== Methods
  # …
end
