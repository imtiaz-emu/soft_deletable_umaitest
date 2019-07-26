# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


2.times do
  list = List.create!(
      {
          title: Faker::Lorem.sentence,
          description: Faker::Movie.quote,
          is_deleted: false
      }
  )
  2.times { list.items.create!({
                                   name: Faker::JapaneseMedia::OnePiece.character,
                                   is_deleted: false
                               }) }
end
