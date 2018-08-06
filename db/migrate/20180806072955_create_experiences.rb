class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :capacity

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
