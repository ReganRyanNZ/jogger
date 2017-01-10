class CreateJogs < ActiveRecord::Migration[5.0]
  def change
    create_table :jogs do |t|
      t.references :user, foreign_key: true
      t.integer :time # milliseconds
      t.integer :distance # meters
      t.datetime :date
      t.timestamps
    end
  end
end
