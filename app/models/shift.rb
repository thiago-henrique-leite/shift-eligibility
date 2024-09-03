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
  scope :for_facilities, ->(facility_ids) { where(facility_id: facility_ids) }
  scope :for_date_range, ->(start_date, end_date) { where('start >= ? AND ends_at <= ?', start_date, end_date) }
  scope :for_profession, ->(profession) { where(profession: profession) }
  scope :for_available_worker, ->(worker, start_date, end_date) {
    where.not(id: worker.shifts.active.where('start < ? AND ends_at > ?', end_date, start_date).select(:id))
  }
end
