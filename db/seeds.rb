require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def fetch_lorem_ipsum(paragraphs = 10)
  doc = Nokogiri::HTML(open("https://loripsum.net/api/#{paragraphs}/headers"))

  title = doc.at_css("h1").remove.content
  body = doc.at_css("body").inner_html

  return title, body
end

def create_posts_for(user)
  return if user.posts.present?

  rand(1..5).times do |num|
    puts "."
    title, body = fetch_lorem_ipsum
    user.posts.create(title: title, body: body)
  end
end

puts "== Creating Steven Hays =="
user1 = User.find_or_initialize_by(username: "steven").tap do |u|
  u.first_name = "Steven"
  u.last_name = "Hays"
  u.password = "Password123"
  u.save
end

puts "== Publishing for Steven Hays =="
create_posts_for(user1)

puts "== Creating Kimberly Green =="
user2 = User.find_or_initialize_by(username: "kim").tap do |u|
  u.first_name = "Kimberly"
  u.last_name = "Green"
  u.password = "Password123"
  u.save
end

puts "== Publishing for Kimberly Green =="
create_posts_for(user2)
