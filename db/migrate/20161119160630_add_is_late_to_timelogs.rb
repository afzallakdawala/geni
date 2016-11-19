class AddIsLateToTimelogs < ActiveRecord::Migration
  def change
    add_column :timelogs, :is_late, :boolean
  end
end
