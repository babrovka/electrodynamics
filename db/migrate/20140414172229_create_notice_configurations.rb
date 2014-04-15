class CreateNoticeConfigurations < ActiveRecord::Migration
  def change
    create_table :notice_configurations do |t|
      t.integer :user_id
      t.boolean :to_mailbox, :boolean, :default => false
      t.boolean :to_personal_messages, :boolean, :default => false
      t.boolean :about_new_messages, :boolean, :default => false
      t.boolean :about_my_comment_reply, :boolean, :default => false
      t.boolean :about_my_reply_comments, :boolean, :default => false
      t.boolean :about_mention_me, :boolean, :default => false
      t.boolean :about_new_subscriber, :boolean, :default => false
      
      

      t.timestamps
    end
  end
end
