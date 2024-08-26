class DocumentWorker < ApplicationRecord
  self.table_name = 'DocumentWorker'

  belongs_to :document
  belongs_to :worker
end
