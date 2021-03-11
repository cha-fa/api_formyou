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

AllowlistedJwt.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(AllowlistedJwt.table_name)

#Generate users

#Admin

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'admin@yopmail.com',
  password: 'fakeradmin',
  is_approved: true,
  is_reviewed: true,
  role: 'admin',
)

#Teacher

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'teacher@yopmail.com',
  password: 'fakerteacher',
  is_approved: true,
  is_reviewed: true,
  role: 'teacher',
)

#Student

User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'student@yopmail.com',
  password: 'fakerstudent',
  is_approved: true,
  is_reviewed: true,
  role: 'student',
)

# ------- One user of each role approved -------

5.times do |student|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'fakerstudent',
    is_approved: true,
    is_reviewed: true,
    role: 'student',
  )
end

5.times do |student|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'fakerstudent',
    role: 'student',
  )
end

10.times do |teacher|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'fakerteacher',
    is_approved: true,
    is_reviewed: true,
    role: 'teacher',
  )
end

puts '-------------------- Users table --------------------'
tp User.all

#Generate courses

Course.create(
  title: 'Build Your First Web Pages With HTML and CSS',
  content:
    "Are you interested in making web pages? Look no further! In this course, you will learn how to use HTML5 and CSS3, the two types of code upon which all websites are based.

    You don't need to have any programming skills yet in order to take this course! HTML and CSS are great entry points to the world of code and are necessary languages for any developer or web designer to know. Create your page's content with HTML, and make it look great with CSS. You'll learn all about these two languages and how they work together to render all your favorite websites.",
  teacher: User.find_by(email: 'teacher@yopmail.com'),
)

Course.create(
  title: 'Learn Programming With JavaScript',
  content:
    "To create computer programs or build the app of your dreams, you need to know how to code in a programming language. Apps rely on data and logic to make their magic happen, and that requires a programmer - you - to tell the computer what to do and how. But how do you actually write apps? Where do you start?

  This course is designed to teach you the fundamentals of the JavaScript programming language and to give you lots of practice along the way! We'll look at:",
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Learn How to Learn',
  content:
    'This programme is about the activity of learning as a skill.

    To be successful in the modern world, you need to be good at learning. Whether success, for you, means being successful in your career, your studies, or your hobbies – at work, at home or in your community – you need to want to learn - commit to learning - and know how to learn.',
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Learn About Agile Project Management and SCRUM',
  content:
    'We live in an era where businesses operate in an environment of incredible technological innovation and where customers have more choice than ever before.

  Businesses want to deliver benefits to customers better and faster than their competitors, but they will face many challenges in the process: global competition, an evolving business ecosystem, and rapidly-changing market conditions.',
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Speak in public',
  content:
    'If you want to improve the impact of your public speaking and presenting, overcome your shyness, and become more at ease when addressing people, then you’ve come to the right place!',
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Manage Your Code Project With Git & Github',
  content:
    ' GitHub houses the largest collection of source code from open source to private enterprise projects all over the world.  It is used extensively by teams within software development companies and by individuals working on their own projects.  If you want to manage a large code project, share your work, or collaborate with other developers, knowing how to use Git and Github is essential.  ',
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Learn about Lean Startup',
  content:
    'Lean Startup is an innovative approach to maximizing learning, and works by validating hypotheses in the shortest possible time horizon. Creating new products or changing an existing business model, often in conditions of high uncertainty, requires an approach that lets you turn your assumptions into data that can validate (or refute) those assumptions. Lean Startup provides a structure for this approach.',
  teacher: User.teachers.sample,
)

Course.create(
  title: 'Organize your data in a spreadsheet',
  content:
    "Whether you plan to use Excel, LibreOffice Calc, Numbers on Mac, or Google Sheets on Drive, follow this course to master the basics of spreadsheets. I'll take you through all the main features they have to offer and teach you how to enter, format, analyze, and visualize basic data.",
  teacher: User.teachers.sample,
)

puts '-------------------- Course table --------------------'
tp Course.all

#Generate classroom
5.times { |classroom| Classroom.create(title: Faker::Space.planet) }

puts '-------------------- Classroom table --------------------'
tp Classroom.all

#Generate promotions

Promotion.create(
  start_date: Date.today - 60.days,
  course: Course.find_by(title: 'Build Your First Web Pages With HTML and CSS'),
  classroom: Classroom.all.sample,
)

Course.all.each do |course|
  10.times do |promotion|
    Promotion.create(
      start_date:
        Faker::Date.between(from: Date.today, to: Date.today + 60.days),
      course: course,
      classroom: Classroom.all.sample,
    )
  end
end

Course.all.each do |course|
  10.times do |promotion|
    Promotion.create(
      start_date:
        Faker::Date.between(from: Date.today - 60.days, to: Date.today),
      course: course,
      classroom: Classroom.all.sample,
    )
  end
end

puts '-------------------- Promotion table --------------------'
tp Promotion.all

#Generate subscriptions

4.times do |subscription|
  Subscription.create(
    promotion: Promotion.past.sample,
    student: User.find_by(email: 'student@yopmail.com'),
    note: [5, 9, 7, 2, 10].sample,
  )
end

Subscription.create(
  promotion: Promotion.first,
  student: User.find_by(email: 'student@yopmail.com'),
)

4.times do |subscription|
  Subscription.create(
    promotion: Promotion.future.sample,
    student: User.find_by(email: 'student@yopmail.com'),
  )
end

20.times do |subscription|
  Subscription.create(
    promotion: Promotion.all.sample,
    student: User.approved.sample,
  )
end

puts '-------------------- Subscription table --------------------'
tp Subscription.all

#Generate categories
categories = [
  'Javascript',
  'Web development',
  'Start-up',
  'Language',
  'Digital',
  'Job',
  'Marketing',
  'Ruby',
  'PHP',
  'API',
  'Project',
  'Learning',
  'SEO',
  'Framework',
]

categories.each { |category| Category.create(title: category) }

puts '-------------------- Categories table --------------------'
tp Category.all

#Link categories to courses

Category.all.each { |category| Course.all.sample.categories << category }

10.times do |categoryCourse|
  Course.all.sample.categories << Category.all.sample
end
