class DisallowNullValuesInJogs < ActiveRecord::Migration[5.0]
  def change
    change_column_null :jogs, :time, false
    change_column_null :jogs, :distance, false
    change_column_null :jogs, :date, false
  end
end
