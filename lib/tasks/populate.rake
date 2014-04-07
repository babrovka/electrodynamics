# coding: utf-8
require 'csv'
require 'faker'

namespace :create do
  desc "Create DB data"
  task users: :environment do
    User.destroy_all
    User.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :firstname => 'admin', :lastname => 'admin')
    User.create!(:email => 'babrovka@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Вячеслав', :lastname => 'Бобров')
    User.create!(:email => 'artemyan@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Артем', :lastname => 'Санжаревский')
    User.create!(:email => 'voffkaa@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Владимир', :lastname => 'Кривенко')
    puts "Users created!"
  end
  
  task :tags => :environment do
    Tag.destroy_all
    Tag.populate 30 do |tag|
      tag.title = Faker::Lorem.words(1)[0].capitalize
    end
    puts "Tags created!"
  end
  
  task :articles => :environment do
    Comment.destroy_all
    Article.destroy_all
    users = User.where('firstname != ?', 'admin')
    Article.populate 40 do |article|
      article.title = Populator.sentences(1)
      article.text = Populator.sentences(30..50)
      article.author_id = users.sample
      Comment.populate(3..7) do |comment|
        comment.article_id = article.id
        comment.author_id = users.sample
        comment.comment = Populator.sentences(1..3)
      end
    end
    
    Article.all.each do |article| 
      article.tags << Tag.all.sample
      Comment.populate(3..7) do |comment|
        comment.article_id = article.id
        comment.author_id = users.sample
        comment.comment = Populator.sentences(1..3)
      end
      article.save!
    end
    
    
    # Article.all.each { |article| article.tags << Tag.all.sample; article.save! }
    puts "Articles created!"
  end
  
end

