class Document < ApplicationRecord
  self.table_name = 'Document'

  validates :name, presence: true
end
