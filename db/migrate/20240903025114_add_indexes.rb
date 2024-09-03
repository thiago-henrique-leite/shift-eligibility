class AddIndexes < ActiveRecord::Migration[7.1]
  def change
    # Tabela Shift
    add_index :Shift, :facility_id
    add_index :Shift, :worker_id
    add_index :Shift, [:facility_id, :start, :ends_at]
    add_index :Shift, [:profession, :facility_id]

    # Tabela Facility
    add_index :Facility, :is_active

    # Tabela Document
    add_index :Document, :is_active

    # Tabela DocumentWorker
    add_index :DocumentWorker, :document_id
    add_index :DocumentWorker, :worker_id
    add_index :DocumentWorker, [:document_id, :worker_id]

    # Tabela FacilityRequirement
    add_index :FacilityRequirement, :facility_id
    add_index :FacilityRequirement, :document_id
    add_index :FacilityRequirement, [:facility_id, :document_id]
  end
end
