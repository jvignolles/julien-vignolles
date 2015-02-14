class Entertainment < ActiveRecord::Base
  IMAGE_KINDS = {
    :preview => "Photo",
  }
  IMAGE_LEGENDABLE = true

  reorderable
  strip_fields :name

  #=== Validations
  validates :name, presence: true, maxlength_auto: true

  #=== Triggers
  # …

  #=== Associations
  has_many   :images, -> { order "position" }, as: :imageable, dependent: :destroy

  #=== Scopes
  scope :active,       -> { where(active: true) }
  scope :alphabetical, -> { order("entertainments.name, entertainments.id") }
  scope :adm_for_text, ->(opts) {
    words = opts && opts.scan(/\w+/)
    next where(nil) if words.blank?
    conditions = ["true"]
    words.each do |word|
      conditions[0] << " and (entertainments.id = ?"
      conditions += [word.to_i]
      ["name"].each do |field|
        conditions[0] << " or entertainments.#{field} like ?"
        conditions << "%#{word}%"
      end
      conditions[0] << ")"
    end
    where(conditions)
  }
end
