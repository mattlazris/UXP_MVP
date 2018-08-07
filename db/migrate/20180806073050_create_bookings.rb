class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :finished, :default => false

      t.references :experience, :user, foreign_key: true

      t.timestamps
    end
  end
end
