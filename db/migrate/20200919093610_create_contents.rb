class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.references :post, null: false, foreign_key: true
      t.string :format
      t.text :data

      t.timestamps
    end
  end
end
