class CreateTechnologies < ActiveRecord::Migration[7.1]
  def change
    create_table :technologies do |t|
      t.string :name
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
