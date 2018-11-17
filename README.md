# Members-Only

Part of the Odin Project [curriculum](https://www.theodinproject.com/courses/ruby-on-rails). Build an exclusive clubhouse where members can write embarrassing posts about non-members. Inside the clubhouse, members can see who the author of a post is but, outside, they can only see the story and wonder who wrote it.

Summary of creation steps:
  1. Map out database models needed (data, validations, associations).
  ```
  User
    name:string [required, unique, max 64 chars]
    email:string [required, unique, max 64 chars]
    admin:boolean [default false]
    num_posts:integer
    has_secure_password
    password_digest:string [required, min 6 chars]
    remember_digest:string
    has many posts
  Post
    title:string [required, max 64 chars]
    body:text [required, max 1k chars]
    belongs to a user
  ```
  2. Create the Rails app
  ```
  $ rails new Members-Only
  ```
  3. Copy the Gemfile from Sample-App project.
  bcrypt gem is needed for secure passwords.
  bootstrap-sass is needed for view formatting.
  faker gem needed for sample users.
  will_paginate and bootstrap-will-paginate for paging the users index.
  4. Install Gemfile gems
  ```
  $ bundle install
  $ bundle update
  ```
  5. Create a User model.
  ```
  $ rails generate model User name:string email:string admin:boolean password_digest:string remember_digest:string
  ```
  Edit the resulting migration file to contain this line:
  t.boolean :admin, default: false
  Populate the resulting files:
    app/helpers/application_helper.rb
    app/models/user.rb
    test/fixtures/users.yml
    test/models/user_test.rb
  6. Use an index for the email column.
  ```
  $ rails generate migration add_index_to_users_email
  ```
  Add the following line to the migration **change** method:
  ```
  add_index :users, :email, unique: true
  ```
  7. Create the database from generated migration files.
  ```
  $ rails db:migrate
  ```
  8. Add validations and associations to User model app/models/user.rb
  9. Create a Post model.
  ```
  $ rails generate model Post title:string body:text user:references
  ```
  10. Migrate changes to database.
  ```
  $ rails db:migrate
  ```
  11. Add validations and associations to Post model app/models/post.rb
  12. Create StaticPages controller and views
  ```
  $ rails generate controller StaticPages home help about contact
  ```
  13. Create Users controller and views
  ```
  $ rails generate controller Users new show edit index
  ```
  14. Generate integration tests
  ```
  $ rails generate integration_test site_layout
  $ rails generate integration_test users_signup
  ```
  15. Create a Session controller
  ```
  $ rails generate controller Sessions new
  $ rails generate integration_test users_login
  $ rails generate integration_test users_edit
  $ rails generate integration_test users_index
  ```
  16. Create a post controller
  ```
  $ rails generate controller Posts new
  ```
