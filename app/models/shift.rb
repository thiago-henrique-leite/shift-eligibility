class Shift < ApplicationRecord
  self.table_name = 'Shift'

  belongs_to :facility
  belongs_to :worker

  validates :end, :profession, :start, presence: true
end
