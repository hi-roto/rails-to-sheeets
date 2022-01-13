class CreateSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :sheets do |t|
      t.string :sheet_id

      t.timestamps
    end
  end
end
