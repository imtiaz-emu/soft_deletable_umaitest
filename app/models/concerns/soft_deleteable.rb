module SoftDeleteable
  extend ActiveSupport::Concern

  included do
    default_scope { where(is_deleted: false) }
    scope :only_deleted, -> { unscoped.where.not(is_deleted: false) }

    def hard_delete
      delete_or_restore(false, true)
      destroy
    end

    def soft_delete
      update_attribute(:is_deleted, true)
      delete_or_restore(true, false)
    end

    def restore
      update_attribute(:is_deleted, false)
      delete_or_restore(false, true)
    end

    private

    def dependent_associations
      self.class.reflect_on_all_associations.select do |association|
        association.options[:dependent] == :destroy
      end
    end

    def delete_or_restore(should_delete, should_restore)
      dependent_associations.each do |association|
        association_data = should_restore ? send(association.name).only_deleted : send(association.name)
        association_data.update_all(is_deleted: should_delete)
      end
    end
  end
end