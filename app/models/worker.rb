class Worker < ApplicationRecord
  self.table_name = 'Worker'

  has_many :document_workers, dependent: :destroy
  has_many :documents, through: :document_workers
  has_many :shifts, dependent: :destroy
  has_many :facilities, through: :documents

  validates :name, :profession, presence: true

  enum :profession, {
    CNA: 'CNA',
    LVN: 'LVN',
    RN: 'RN'
  }

  scope :active, -> { where(is_active: true) }
end
