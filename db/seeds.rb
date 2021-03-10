# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

Subscription.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Subscription.table_name)

Course.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Course.table_name)

Promotion.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Promotion.table_name)

Category.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Category.table_name)

Classroom.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Classroom.table_name)


#Generate users

  #Admin

  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "admin@yopmail.com",
    password: "fakeradmin",
    is_approved: true,
    role: "admin")

  #Teacher

  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "teacher@yopmail.com",
    password: "fakerteacher",
    is_approved: true,
    role: "teacher")

  #Student

  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "student@yopmail.com",
    password: "fakerstudent",
    is_approved: true,
    role: "student")


  10.times do |student|
    User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "fakerstudent",
      is_approved: true,
      role: "student")
  end

  10.times do |teacher|
    User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "fakerteacher",
      is_approved: true,
      role: "teacher")
  end


  puts "-------------------- Users table --------------------"
  tp User.all

#Generate courses

5.times do |courses|
  Course.create(
    title: Faker::Hacker.noun,
    content: Faker::Lorem.paragraph(sentence_count: 6, supplemental: true),
    teacher: User.teachers.first)
end

puts "-------------------- Course table --------------------"
tp Course.all

#Generate classroom
5.times do |classroom|
  Classroom.create(title: Faker::Space.planet)
end

puts "-------------------- Classroom table --------------------"
tp Classroom.all

#Generate promotions

  10.times do |promotion|
    Promotion.create(
      start_date: Faker::Date.between(from: Date.today, to: Date.today + 600.days),
      course: Course.first,
      classroom: Classroom.all.sample)
  end

  puts "-------------------- Promotion table --------------------"
  tp Promotion.all

#Generate subscriptions

5.times do |subscription|
  Subscription.create(
    promotion: Promotion.all.sample,
    student: User.students.sample)
end

puts "-------------------- Subscription table --------------------"
tp Subscription.all


#Generate categories

10.times do |category|
  Category.create(
   title: Faker::ProgrammingLanguage.name)
end

puts "-------------------- Categories table --------------------"
tp Category.all

#Link categories to courses

20.times do |categoryCourse|
  Course.all.sample.categories << Category.all.sample
end

Course.all.map{ |course|
 10.times do |promotion|
   Promotion.create(
     start_date: Faker::Date.between(from: Date.today, to: Date.today + 600.days),
     course: course,
     classroom: Classroom.all.sample)
 end
}
tp Promotion.all