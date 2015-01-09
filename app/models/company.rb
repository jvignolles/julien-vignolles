class Company < ActiveRecord::Base
  IMAGE_KINDS = {
    :logo => "Logo",
  }
  IMAGE_LEGENDABLE = true

  #acts_as_seo_keywords :seo_keywords
  strip_fields :name, :description, :location, :website_url

  #=== Validations
  validates :name, presence: true, maxlength_auto: true

  #=== Triggers
  # …

  #=== Associations
  has_many   :images, -> { order "position" }, as: :imageable, dependent: :destroy
  has_many   :jobs
  has_many   :projects

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("companies.name, companies.id") }
  scope :ordered,      -> { order("companies.name, companies.id") }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (companies.id = ?"
      conditions << word.to_i
      ["name", "description"].each do |field|
        conditions[0] << " or companies.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }

  #=== Methods
  # …
end
