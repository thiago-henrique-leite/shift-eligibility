class CreateTables < ActiveRecord::Migration[7.1]
  def up
    return unless Rails.env.test?

    create_table 'Worker' do |t|
      t.text :name, null: false
      t.boolean :is_active, null: false, default: false
      t.string :profession, null: false

      t.timestamps
    end

    create_table 'Facility' do |t|
      t.text :name, null: false
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end

    create_table 'Document' do |t|
      t.text :name, null: false
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end

    create_table 'FacilityRequirement' do |t|
      t.references :facility, null: false, foreign_key: { to_table: :facilities, on_delete: :restrict, on_update: :cascade }
      t.references :document, null: false, foreign_key: { to_table: :documents, on_delete: :restrict, on_update: :cascade }

      t.timestamps
    end

    create_table 'DocumentWorker' do |t|
      t.references :worker, null: false, foreign_key: { to_table: :workers, on_delete: :restrict, on_update: :cascade }
      t.references :document, null: false, foreign_key: { to_table: :documents, on_delete: :restrict, on_update: :cascade }

      t.timestamps
    end

    create_table 'Shift' do |t|
      t.datetime :start, null: false, precision: 3
      t.datetime :end, null: false, precision: 3
      t.string :profession, null: false
      t.boolean :is_deleted, null: false, default: false
      t.references :facility, null: false, foreign_key: { to_table: :facilities, on_delete: :restrict, on_update: :cascade }
      t.references :worker, foreign_key: { to_table: :workers, on_delete: :nullify, on_update: :cascade }

      t.timestamps
    end
  end

  def down
    drop_table :shifts
    drop_table :document_workers
    drop_table :facility_requirements
    drop_table :documents
    drop_table :facilities
    drop_table :workers
    execute <<-SQL
      DROP TYPE "Profession";
    SQL
  end
end
