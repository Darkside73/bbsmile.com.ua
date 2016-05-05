module PermanentRecord
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :deleted_records, -> { unscoped.where.not(deleted_at: nil) }
  end
end
