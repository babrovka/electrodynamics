class CreateUserInvites < ActiveRecord::Migration
  def change
    create_table :user_invites do |t|
      t.integer :user_id
      t.integer :invite_id

      t.timestamps
    end
  end
end
