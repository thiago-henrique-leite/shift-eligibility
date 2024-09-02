class RenameEndToEndsAtInShifts < ActiveRecord::Migration[7.1]
  def change
    rename_column :Shift, :end, :ends_at
  end
end
