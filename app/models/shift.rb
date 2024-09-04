class Shift < ApplicationRecord
  self.table_name = 'Shift'

  belongs_to :facility
  belongs_to :worker, optional: true

  validates :ends_at, :profession, :start, presence: true

  enum :profession, {
    CNA: 'CNA',
    LVN: 'LVN',
    RN: 'RN'
  }

  scope :active, -> { where(is_deleted: false) }
  scope :unclaimed, -> { where(worker_id: nil) }
  scope :with_facility, ->(facility_id) { where(facility_id: facility_id) }
  scope :with_date_range, ->(start_date, end_date) { where('start >= ? AND ends_at <= ?', start_date, end_date) }
  scope :with_profession, ->(profession) { where(profession: profession) }
end
