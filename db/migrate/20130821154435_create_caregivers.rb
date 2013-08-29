class CreateCaregivers < ActiveRecord::Migration
  def change
    create_table :caregivers do |t|

      t.timestamps
    end
  end
end
