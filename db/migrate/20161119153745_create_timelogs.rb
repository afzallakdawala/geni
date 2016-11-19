class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.datetime :login_time
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
