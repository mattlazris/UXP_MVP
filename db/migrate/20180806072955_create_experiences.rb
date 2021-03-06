class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.string :name
      t.string :description
      t.string :category
      t.integer :price
      t.integer :capacity
      t.string :location
      t.string :venue
      t.string :language
      t.integer :duration
      t.string :skill_level

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
