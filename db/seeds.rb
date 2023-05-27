# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: ENV['ADMIN_MAIL'], password: ENV['ADMIN_PASSWORD'])

User.destroy_all
User.create!(
  [
    {email: 'takeda@example.com', name: '武田信玄', password: 'password', introduction: '甘党です', status: 0, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'uesugi@example.com', name: '上杉謙信', password: 'password', introduction: '中華が好き', status: 0, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'oda@example.com', name: '織田信長', password: 'password', introduction: '趣味はケーキ屋さん巡り', status: 0, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {email: 'akechi@example.com', name: '明智光秀', password: 'password', introduction: 'パンに目がない', status: 0, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")},
    {email: 'toyotomi@example.com', name: '豊臣秀吉', password: 'password', introduction: 'イタリアン大好き', status: 0, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")},
    {email: 'ishida@example.com', name: '石田三成', password: 'password', introduction: '日本料理が好き', status: 1, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")},
    {email: 'date@example.com', name: '伊達政宗', password: 'password', introduction: '麺類が好き', status: 2, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"), filename:"sample-user7.jpg")}
  ]
)

users = User.all
Post.create!(
  [
    {shop_name: '和菓子武田本店', address: '代々木駅', price: 230, menu: '豆大福', volume_status: 2, star: '1', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), impression: '美味しいけど量が少なかった。', user_id: users[0].id },
    {shop_name: '中華ウエスギ', address: '御徒町駅', price: 900, menu: 'チャーハン', volume_status: 2, star: '2', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), impression: '美味しかった。', user_id: users[1].id },
    {shop_name: 'パティスリーoda', address: '秋葉原駅', price: 600, menu: 'ショートケーキ', volume_status: 1, star: '3', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), impression: '昔ながらのケーキでした。', user_id: users[2].id },
    {shop_name: 'ベーカリー明智', address: '西日暮里駅', price: 200, menu: 'メロンパン', volume_status: 0, star: '4', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg"), impression: '食べ応え満点！！', user_id: users[3].id },
    {shop_name: '豊臣パスタ', address: '有楽町駅', price: 1200, menu: 'カルボナーラ', volume_status: 2, star: '5', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg"), impression: '美味しすぎて一瞬で食べ終わった。', user_id: users[4].id },
    {shop_name: '鉄板石田', address: '高田馬場', price: 1100, menu: '豚玉', volume_status: 0, star: '3', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg"), impression: 'ソースが美味しい！', user_id: users[5].id },
    {shop_name: '伊達そば', address: '新大久保', price: 1400, menu: '天ぷらそば', volume_status: 1, star: '4', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg"), impression: '天ぷらは揚げたてで美味しい。', user_id: users[6].id },
  ]
)

posts = Post.all
Comment.create!(
  [
    {user_id: users[0].id, post_id: posts[3].id, comment: '美味しそうですね。'},
    {user_id: users[1].id, post_id: posts[2].id, comment: 'お腹が減ってきました。'},
    {user_id: users[2].id, post_id: posts[1].id, comment: '店内は綺麗でしたか？'},
    {user_id: users[3].id, post_id: posts[0].id, comment: '結構混んでました？'},
    {user_id: users[3].id, post_id: posts[2].id, comment: '王道ですね！'}
  ]
  )