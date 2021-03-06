class Item < ApplicationRecord

  # == Modules == #
  include SoftDeleteable

  # == Constants == #

  # == File Uploader == #

  # == Associations == #
  belongs_to :list

  # == Attributes == #

  # == Validations == #
  validates_presence_of :name, :list

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
  private


end
