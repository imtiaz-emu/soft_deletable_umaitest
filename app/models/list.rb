class List < ApplicationRecord

  # == Modules == #
  include SoftDeleteable

  # == Constants == #

  # == File Uploader == #

  # == Associations == #
  has_many :items, dependent: :destroy

  # == Attributes == #

  # == Validations == #
  validates_presence_of :title

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
  private

end
