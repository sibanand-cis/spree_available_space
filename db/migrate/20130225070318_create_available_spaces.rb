class CreateAvailableSpaces < ActiveRecord::Migration
  def change
    create_table :available_spaces do |t|

      t.timestamps
    end
  end
end
