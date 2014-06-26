# coding: utf-8
require 'csv'
require 'faker'

namespace :create do
  desc "Create DB data"
  
  task :organizations => :environment do
    Organization.destroy_all
    Organization.populate 10 do |organization|
      country = Country.with_cities.sample
      city = country.cities.sample
      organization.title = Populator.words(1.2)
      organization.index = (100..1000)
      organization.establish_date = Date.today - rand(2000)
      organization.site = Faker::Internet.domain_name
      organization.country_id = country.id
      organization.city_id = city.id
      organization.employees
      organization.about = Populator.sentences(20..40)
    end
    puts "Organizations created!"
  end
  
  task users: :environment do
    User.destroy_all
    User.new(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :firstname => 'admin', :lastname => 'admin', :organization_id => Organization.pluck(:id).sample, :role => 'admin', :nickname => 'admin').save(:validate => false)
    User.new(:email => 'babrovka@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Вячеслав', :lastname => 'Бобров', :organization_id => Organization.pluck(:id).sample, :role => 'user', :nickname => 'babrovka').save(:validate => false)
    User.new(:email => 'artemyan@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Артем', :lastname => 'Санжаревский', :organization_id => Organization.pluck(:id).sample, :role => 'user', :nickname => 'artemyan').save(:validate => false)
    User.new(:email => 'voffkaa@gmail.com', :password => 'password', :password_confirmation => 'password', :firstname => 'Владимир', :lastname => 'Кривенко', :organization_id => Organization.pluck(:id).sample, :role => 'user', :nickname => 'voffkaa').save(:validate => false)
    
    User.new(:email => Faker::Internet.email, :firstname => 'Виталий', :lastname => 'Коваль', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Кевин', :lastname => 'Лаланд', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Андрей', :lastname => 'Мезин', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Кирилл', :lastname => 'Готовец', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Роман', :lastname => 'Граборенко', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Николай', :lastname => 'Стасенко', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Олег', :lastname => 'Евенко', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Иван', :lastname => 'Усенко', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Владимир', :lastname => 'Денисов', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Дмитрий', :lastname => 'Коробов', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Андрей', :lastname => 'Карев', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Алексей', :lastname => 'Угаров', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Андрей', :lastname => 'Степанов', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Андрей', :lastname => 'Карев', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Артём', :lastname => 'Волков', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Константин', :lastname => 'Кольцов', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Евгений', :lastname => 'Ковыршин', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Джэфф', :lastname => 'Платт', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    User.new(:email => Faker::Internet.email, :firstname => 'Михаил', :lastname => 'Грабовский', :organization_id => Organization.pluck(:id).sample, :role => 'user').save(:validate => false)
    
    puts "Users created!"
  end
  
  task :tags => :environment do
    Tag.destroy_all
    Tag.populate 30 do |tag|
      tag.title = Faker::Lorem.words(1)[0].capitalize
    end
    puts "Tags created!"
  end
  
  task :categories => :environment do
    Category.destroy_all
    Category.populate 10 do |category|
      category.title = Populator.words(1.2)
    end
    puts "Categories created!"
  end
  
  task :articles => :environment do
    Comment.destroy_all
    Article.destroy_all
    users = User.where('firstname != ?', 'admin')
    Article.populate 40 do |article|
      article.title = Populator.sentences(1)
      article.text = Populator.sentences(30..50)
      article.author_id = users.sample
      article.category_id = Category.all
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

    puts "Articles created!"
  end
  
  task :documents => :environment do
    Document.destroy_all
    Document.populate 30 do |document|
      document.title = Populator.words(1.2)
      document.text = Populator.sentences(7..15)
    end
    puts "Documents created!"
    
    Document.all.each do |document|
      users = User.where('firstname != ?', 'admin')
      document.image = File.open(Dir.glob(File.join(Rails.root, 'covers', '*')).sample)
      document.file = File.open(Dir.glob(File.join(Rails.root, 'docs', '*')).sample)
      document.save!
      document.tags << Tag.all.sample
      Comment.populate(3..7) do |comment|
        comment.document_id = document.id
        comment.author_id = users.sample
        comment.comment = Populator.sentences(1..3)
      end
    end
  end
  
  task :themes => :environment do
    Theme.destroy_all
    ['Электростатика', 'Постоянный ток', 'Переменный ток', 'Магнетизм', 'Раздел 5', 'Раздел 6', 'Раздел 7', 'Раздел 8', 'Раздел 9', 'Раздел 10'].each do |title|
      Theme.create(:title => title)
    end
  end
  

  
  task :countries_and_cities => :environment do
    
    Country.destroy_all
    Country.reset_pk_sequence
    City.destroy_all
    City.reset_pk_sequence
    
    
    Country.create([
      { name: "Россия" },
      { name: "Австралия" },
      { name: "Австрия" },
      { name: "Азербайджан" },
      { name: "Ангилья" },
      { name: "Аргентина" },
      { name: "Армения" },
      { name: "Беларусь" },
      { name: "Белиз" },
      { name: "Бельгия" } ])

    City.create([
      { name: "Москва", country_id: 1 },
      { name: "Санкт-Петербург", country_id: 1 },
      { name: "Александровская", country_id: 1 },
      { name: "Бокситогорск", country_id: 1 },
      { name: "Большая Ижора", country_id: 1 },
      { name: "Будогощь", country_id: 1 },
      { name: "Вознесенье", country_id: 1 },
      { name: "Волосово", country_id: 1 },
      { name: "Волхов", country_id: 1 },
      { name: "Всеволожск", country_id: 1 },
      { name: "Выборг", country_id: 1 },
      { name: "Балларат", country_id: 2 },
      { name: "Бендиго", country_id: 2 },
      { name: "Варрнамбул", country_id: 2 },
      { name: "Водонга", country_id: 2 },
      { name: "Гилонг", country_id: 2 },
      { name: "Мелтон", country_id: 2 },
      { name: "Мельбурн", country_id: 2 },
      { name: "Милдура", country_id: 2 },
      { name: "Траралгон", country_id: 2 },
      { name: "Шеппартон", country_id: 2 },
      { name: "Бунбури", country_id: 2 },
      { name: "Гералдтон", country_id: 2 },
      { name: "Калгурли", country_id: 2 },
      { name: "Мандурах", country_id: 2 },
      { name: "Олбани", country_id: 2 },
      { name: "Перт", country_id: 2 },
      { name: "Брисбен", country_id: 2 },
      { name: "Бундаберг", country_id: 2 },
      { name: "Гладстон", country_id: 2 },
      { name: "Каирнс", country_id: 2 },
      { name: "Калундра", country_id: 2 },
      { name: "Маккей", country_id: 2 },
      { name: "Мариборо", country_id: 2 },
      { name: "Маунт-Иса", country_id: 2 },
      { name: "Рокхамптон", country_id: 2 },
      { name: "Таунсвилл", country_id: 2 },
      { name: "Тувумба", country_id: 2 },
      { name: "Албури", country_id: 2 },
      { name: "Армидейл", country_id: 2 },
      { name: "Батурст", country_id: 2 },
      { name: "Брокен-Хилл", country_id: 2 },
      { name: "Вагга-Вагга", country_id: 2 },
      { name: "Воллонгонг", country_id: 2 },
      { name: "Гоулбурн", country_id: 2 },
      { name: "Дуббо-Дуббо", country_id: 2 },
      { name: "Коффс-Харбор", country_id: 2 },
      { name: "Куэнбиан", country_id: 2 },
      { name: "Лисмор", country_id: 2 },
      { name: "Ньюкастл", country_id: 2 },
      { name: "Оранж", country_id: 2 },
      { name: "Сидней", country_id: 2 },
      { name: "Тамворт", country_id: 2 },
      { name: "Алис Спрингс", country_id: 2 },
      { name: "Дарвин", country_id: 2 },
      { name: "Девонпорт", country_id: 2 },
      { name: "Лаункестон", country_id: 2 },
      { name: "Хобарт", country_id: 2 },
      { name: "Канберра", country_id: 2 },
      { name: "Аделаида", country_id: 2 },
      { name: "Маунт-Гамбир", country_id: 2 },
      { name: "Айзенштадт", country_id: 3 },
      { name: "Амштеттен", country_id: 3 },
      { name: "Брегенц", country_id: 3 },
      { name: "Гмунден", country_id: 3 },
      { name: "Дорнбирн", country_id: 3 },
      { name: "Инсбрук", country_id: 3 },
      { name: "Кицбюэль", country_id: 3 },
      { name: "Куфштайн", country_id: 3 },
      { name: "Майрхофен", country_id: 3 },
      { name: "Трибен", country_id: 3 },
      { name: "Фельдкирх", country_id: 3 },
      { name: "Филлах", country_id: 3 },
      { name: "Фрайштадт", country_id: 3 },
      { name: "Вена", country_id: 3 },
      { name: "Велс", country_id: 3 },
      { name: "Линц", country_id: 3 },
      { name: "Стир", country_id: 3 },
      { name: "Зальцбург", country_id: 3 },
      { name: "Виллач", country_id: 3 },
      { name: "Клагенфурт", country_id: 3 },
      { name: "Венер-Нойштадт", country_id: 3 },
      { name: "Мистельбах", country_id: 3 },
      { name: "Грац", country_id: 3 },
      { name: "Иннсбрук", country_id: 3 },
      { name: "Леобен", country_id: 3 },
      { name: "Агдам", country_id: 4 },
      { name: "Агдаш", country_id: 4 },
      { name: "Агджабеди", country_id: 4 },
      { name: "Аджикенд", country_id: 4 },
      { name: "Акстафа", country_id: 4 },
      { name: "Али-Байрамлы", country_id: 4 },
      { name: "Алунитаг", country_id: 4 },
      { name: "Артем-Остров", country_id: 4 },
      { name: "Астара", country_id: 4 },
      { name: "Ахсу", country_id: 4 },
      { name: "Баку", country_id: 4 },
      { name: "Балаханы", country_id: 4 },
      { name: "Банк", country_id: 4 },
      { name: "Барда", country_id: 4 },
      { name: "Белоканы", country_id: 4 },
      { name: "Биласувар", country_id: 4 },
      { name: "Бинагади", country_id: 4 },
      { name: "Бирмай", country_id: 4 },
      { name: "Бузовна", country_id: 4 },
      { name: "Варташен", country_id: 4 },
      { name: "Гадрут", country_id: 4 },
      { name: "Геокчай", country_id: 4 },
      { name: "Гобустан", country_id: 4 },
      { name: "Горадиз", country_id: 4 },
      { name: "Гэтргян", country_id: 4 },
      { name: "Дальмамедли", country_id: 4 },
      { name: "Дашкесан", country_id: 4 },
      { name: "Джалилабад", country_id: 4 },
      { name: "Джебраил", country_id: 4 },
      { name: "Дивичи", country_id: 4 },
      { name: "Евлах", country_id: 4 },
      { name: "Ждановск", country_id: 4 },
      { name: "Закаталы", country_id: 4 },
      { name: "Зангелан", country_id: 4 },
      { name: "Зардоб", country_id: 4 },
      { name: "Имишли", country_id: 4 },
      { name: "Исмаиллы", country_id: 4 },
      { name: "Истису", country_id: 4 },
      { name: "Казанбулак", country_id: 4 },
      { name: "Казах", country_id: 4 },
      { name: "Кази-Магомед", country_id: 4 },
      { name: "Карачала", country_id: 4 },
      { name: "Касум-Исмаилов", country_id: 4 },
      { name: "Кахи", country_id: 4 },
      { name: "Кедабек", country_id: 4 },
      { name: "Кельбаджар", country_id: 4 },
      { name: "Кергез", country_id: 4 },
      { name: "Кировобад", country_id: 4 },
      { name: "Кировск", country_id: 4 },
      { name: "Кировский", country_id: 4 },
      { name: "Куба", country_id: 4 },
      { name: "Кубатлы", country_id: 4 },
      { name: "Куткашен", country_id: 4 },
      { name: "Кюрдамир", country_id: 4 },
      { name: "Ленкорань", country_id: 4 },
      { name: "Лерик", country_id: 4 },
      { name: "Маргуни", country_id: 4 },
      { name: "Мардакерт", country_id: 4 },
      { name: "Масаллы", country_id: 4 },
      { name: "Маштага", country_id: 4 },
      { name: "Мингечаур", country_id: 4 },
      { name: "Мир-Башир", country_id: 4 },
      { name: "Нафталан", country_id: 4 },
      { name: "Нефтечала", country_id: 4 },
      { name: "Пушкино", country_id: 4 },
      { name: "Саатлы", country_id: 4 },
      { name: "Сабирабад", country_id: 4 },
      { name: "Сабуичи", country_id: 4 },
      { name: "Сальяны", country_id: 4 },
      { name: "Сиазань", country_id: 4 },
      { name: "Сумгаит", country_id: 4 },
      { name: "Тауз", country_id: 4 },
      { name: "Уджары", country_id: 4 },
      { name: "Физули", country_id: 4 },
      { name: "Ханлар", country_id: 4 },
      { name: "Хачмас", country_id: 4 },
      { name: "Худат", country_id: 4 },
      { name: "Шамхор", country_id: 4 },
      { name: "Шаумяновск", country_id: 4 },
      { name: "Шеки", country_id: 4 },
      { name: "Шемаха", country_id: 4 },
      { name: "Ярдымлы", country_id: 4 },
      { name: "Степанокерт", country_id: 4 },
      { name: "Шуша", country_id: 4 },
      { name: "Джульфа", country_id: 4 },
      { name: "Ильичевск", country_id: 4 },
      { name: "Нахичевань", country_id: 4 },
      { name: "Ордубад", country_id: 4 },
      { name: "Шахбуз", country_id: 4 },
      { name: "Ангуилья", country_id: 5 },
      { name: "Сомбреро", country_id: 5 },
      { name: "Азул", country_id: 6 },
      { name: "Байя-Бланка", country_id: 6 },
      { name: "Буэнос-Айрес", country_id: 6 },
      { name: "Кампана", country_id: 6 },
      { name: "Ла-Плата", country_id: 6 },
      { name: "Мар-дель-Плата", country_id: 6 },
      { name: "Мерседес", country_id: 6 },
      { name: "Некочеа", country_id: 6 },
      { name: "Олаварриа", country_id: 6 },
      { name: "Пергамино", country_id: 6 },
      { name: "Пунта-Альта", country_id: 6 },
      { name: "Сан-Николас", country_id: 6 },
      { name: "Тандил", country_id: 6 },
      { name: "Трес-Арройос", country_id: 6 },
      { name: "Чивилкой", country_id: 6 },
      { name: "Хухуй", country_id: 6 },
      { name: "Катамарка", country_id: 6 },
      { name: "Альта-Грасия", country_id: 6 },
      { name: "Вилла-Мариа", country_id: 6 },
      { name: "Кордова", country_id: 6 },
      { name: "Рио-Куарто", country_id: 6 },
      { name: "Сан-Франсиско", country_id: 6 },
      { name: "Гойя", country_id: 6 },
      { name: "Корриентес", country_id: 6 },
      { name: "Женераль-Рока", country_id: 6 },
      { name: "Санта-Роза", country_id: 6 },
      { name: "Ла-Риойя", country_id: 6 },
      { name: "Мендоза", country_id: 6 },
      { name: "Сан-Рафаель", country_id: 6 },
      { name: "Посадас", country_id: 6 },
      { name: "Ньюкуэн", country_id: 6 },
      { name: "Салта", country_id: 6 },
      { name: "Сан-Луис", country_id: 6 },
      { name: "Сан-Хуан", country_id: 6 },
      { name: "Рио-Галльегос", country_id: 6 },
      { name: "Росарио", country_id: 6 },
      { name: "Санта-Фе", country_id: 6 },
      { name: "Сантьяго-дел-Эстеро", country_id: 6 },
      { name: "Тукуман", country_id: 6 },
      { name: "Формоза", country_id: 6 },
      { name: "Пресиденсиа-Рокуэ-Сенз", country_id: 6 },
      { name: "Ресистенсиа", country_id: 6 },
      { name: "Комодоро-Ривадавия", country_id: 6 },
      { name: "Конкордиа", country_id: 6 },
      { name: "Консепсион-дель-Уругвай", country_id: 6 },
      { name: "Парана", country_id: 6 },
      { name: "Апаран", country_id: 7 },
      { name: "Ванадзор", country_id: 7 },
      { name: "Гюмри", country_id: 7 },
      { name: "Раздан", country_id: 7 },
      { name: "Севан", country_id: 7 },
      { name: "Ереван", country_id: 7 },
      { name: "Антополь", country_id: 8 },
      { name: "Барановичи", country_id: 8 },
      { name: "Белоозерск", country_id: 8 },
      { name: "Береза", country_id: 8 },
      { name: "Береза Картуска", country_id: 8 },
      { name: "Брест", country_id: 8 },
      { name: "Высокое", country_id: 8 },
      { name: "Ганцевичи", country_id: 8 },
      { name: "Городище", country_id: 8 },
      { name: "Давид-Городок", country_id: 8 },
      { name: "Домачево", country_id: 8 },
      { name: "Дрогичин", country_id: 8 },
      { name: "Жабинка", country_id: 8 },
      { name: "Ивацевичи", country_id: 8 },
      { name: "Каменец", country_id: 8 },
      { name: "Кобрин", country_id: 8 },
      { name: "Лунинец", country_id: 8 },
      { name: "Ляховичи", country_id: 8 },
      { name: "Малорита", country_id: 8 },
      { name: "Минск", country_id: 8 },
      { name: "Пружаны", country_id: 8 },
      { name: "Столин", country_id: 8 },
      { name: "Барань", country_id: 8 },
      { name: "Бегомль", country_id: 8 },
      { name: "Бешенковичи", country_id: 8 },
      { name: "Богушевск", country_id: 8 },
      { name: "Браслав", country_id: 8 },
      { name: "Верхнедвинск", country_id: 8 },
      { name: "Ветрино", country_id: 8 },
      { name: "Видзы", country_id: 8 },
      { name: "Витебск", country_id: 8 },
      { name: "Воропаево", country_id: 8 },
      { name: "Глубокое", country_id: 8 },
      { name: "Городок", country_id: 8 },
      { name: "Дисна", country_id: 8 },
      { name: "Докшицы", country_id: 8 },
      { name: "Друя", country_id: 8 },
      { name: "Дубровно", country_id: 8 },
      { name: "Езерище", country_id: 8 },
      { name: "Лепель", country_id: 8 },
      { name: "Лиозно", country_id: 8 },
      { name: "Миоры", country_id: 8 },
      { name: "Новополоцк", country_id: 8 },
      { name: "Орша", country_id: 8 },
      { name: "Полоцк", country_id: 8 },
      { name: "Поставы", country_id: 8 },
      { name: "Россоны", country_id: 8 },
      { name: "Сенно", country_id: 8 },
      { name: "Толочин", country_id: 8 },
      { name: "Ушачи", country_id: 8 },
      { name: "Чашники", country_id: 8 },
      { name: "Шарковщина", country_id: 8 },
      { name: "Шумилино", country_id: 8 },
      { name: "Белицк", country_id: 8 },
      { name: "Большевик", country_id: 8 },
      { name: "Брагин", country_id: 8 },
      { name: "Буда-Кошелево", country_id: 8 },
      { name: "Василевичи", country_id: 8 },
      { name: "Васильевка", country_id: 8 },
      { name: "Ветка", country_id: 8 },
      { name: "Гомель", country_id: 8 },
      { name: "Добруш", country_id: 8 },
      { name: "Ельск", country_id: 8 },
      { name: "Житковичи", country_id: 8 },
      { name: "Жлобин", country_id: 8 },
      { name: "Калинковичи", country_id: 8 },
      { name: "Корма", country_id: 8 },
      { name: "Лельчицы", country_id: 8 },
      { name: "Лоев", country_id: 8 },
      { name: "Мозырь", country_id: 8 },
      { name: "Наровля", country_id: 8 },
      { name: "Октябрьский", country_id: 8 },
      { name: "Петриков", country_id: 8 },
      { name: "Речица", country_id: 8 },
      { name: "Рогачев", country_id: 8 },
      { name: "Светлогорск", country_id: 8 },
      { name: "Хойники", country_id: 8 },
      { name: "Чечерск", country_id: 8 },
      { name: "Большая Берестовица", country_id: 8 },
      { name: "Волковыск", country_id: 8 },
      { name: "Вороново", country_id: 8 },
      { name: "Гродно", country_id: 8 },
      { name: "Дятлово", country_id: 8 },
      { name: "Желудок", country_id: 8 },
      { name: "Зельва", country_id: 8 },
      { name: "Ивье", country_id: 8 },
      { name: "Козловщина", country_id: 8 },
      { name: "Кореличи", country_id: 8 },
      { name: "Лида", country_id: 8 },
      { name: "Мосты", country_id: 8 },
      { name: "Новогрудок", country_id: 8 },
      { name: "Островец", country_id: 8 },
      { name: "Ошмяны", country_id: 8 },
      { name: "Свислочь", country_id: 8 },
      { name: "Слоним", country_id: 8 },
      { name: "Сморгонь", country_id: 8 },
      { name: "Щучин", country_id: 8 },
      { name: "Березино", country_id: 8 },
      { name: "Бобр", country_id: 8 },
      { name: "Борисов", country_id: 8 },
      { name: "Вилейка", country_id: 8 },
      { name: "Воложин", country_id: 8 },
      { name: "Городея", country_id: 8 },
      { name: "Дзержинск", country_id: 8 },
      { name: "Жодино", country_id: 8 },
      { name: "Заславль", country_id: 8 },
      { name: "Зеленый Бор", country_id: 8 },
      { name: "Ивенец", country_id: 8 },
      { name: "Клецк", country_id: 8 },
      { name: "Копыль", country_id: 8 },
      { name: "Крупки", country_id: 8 },
      { name: "Логойск", country_id: 8 },
      { name: "Марьина Горка", country_id: 8 },
      { name: "Молодечно", country_id: 8 },
      { name: "Мядель", country_id: 8 },
      { name: "Несвиж", country_id: 8 },
      { name: "Пинск", country_id: 8 },
      { name: "Слуцк", country_id: 8 },
      { name: "Смолевичи", country_id: 8 },
      { name: "Солигорск", country_id: 8 },
      { name: "Старые Дороги", country_id: 8 },
      { name: "Столбцы", country_id: 8 },
      { name: "Узда", country_id: 8 },
      { name: "Червень", country_id: 8 },
      { name: "Белыничи", country_id: 8 },
      { name: "Бобруйск", country_id: 8 },
      { name: "Быхов", country_id: 8 },
      { name: "Глуск", country_id: 8 },
      { name: "Глуша", country_id: 8 },
      { name: "Горки", country_id: 8 },
      { name: "Гродзянка", country_id: 8 },
      { name: "Елизово", country_id: 8 },
      { name: "Кировск", country_id: 8 },
      { name: "Климовичи", country_id: 8 },
      { name: "Кличев", country_id: 8 },
      { name: "Костюковичи", country_id: 8 },
      { name: "Краснополье", country_id: 8 },
      { name: "Кричев", country_id: 8 },
      { name: "Круглое", country_id: 8 },
      { name: "Могилев", country_id: 8 },
      { name: "Мстиславль", country_id: 8 },
      { name: "Осиповичи", country_id: 8 },
      { name: "Славгород", country_id: 8 },
      { name: "Хотимск", country_id: 8 },
      { name: "Чаусы", country_id: 8 },
      { name: "Чериков", country_id: 8 },
      { name: "Шклов", country_id: 8 },
      { name: "Белиз-Сити", country_id: 9 },
      { name: "Антверпен", country_id: 10 },
      { name: "Мешлен", country_id: 10 },
      { name: "Арлон", country_id: 10 },
      { name: "Брюгге", country_id: 10 },
      { name: "Гент", country_id: 10 },
      { name: "Монс", country_id: 10 },
      { name: "Намюр", country_id: 10 },
      { name: "Хасселт", country_id: 10 },
      { name: "Брюссель", country_id: 10 },
      { name: "Алост", country_id: 10 },
      { name: "Сант-Никлас", country_id: 10 },
      { name: "Бруже", country_id: 10 },
      { name: "Куртра", country_id: 10 },
      { name: "Роселар", country_id: 10 },
      { name: "Генк", country_id: 10 },
      { name: "Льеж", country_id: 10 },
      { name: "Сераинг", country_id: 10 },
      { name: "Ла-Лювьер", country_id: 10 },
      { name: "Шарлеруа", country_id: 10 },
    ])
  end
  
  
end

