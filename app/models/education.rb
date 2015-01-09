class Education < ActiveRecord::Base
  acts_as_clean_html :description
  reorderable
  strip_fields :name, :description, :location, :option

  #=== Validations
  validates :name, presence: true, maxlength_auto: true

  #=== Triggers
  # …

  #=== Associations
  # …

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("educations.name, educations.id") }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (educations.id = ?"
      conditions << word.to_i
      ["name", "description"].each do |field|
        conditions[0] << " or educations.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }

  #=== Methods
  # …
end
