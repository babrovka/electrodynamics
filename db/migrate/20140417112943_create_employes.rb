class CreateEmployes < ActiveRecord::Migration
  def change
    create_table :employes do |t|
      t.string :firstname
      t.string :lastname
      t.string :position
      t.string :organization_id

      t.timestamps
    end
  end
end
