class Worker < ApplicationRecord
  self.table_name = 'Worker'

  validates :name, :profession, presence: true
end
