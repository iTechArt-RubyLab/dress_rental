# Dress rental service👰🏻‍♀️🤵🏻
## Welcome to a wedding dress rental service! This service was specifically developed for customers to explore a range of categories and salons offering various products to cater for all wedding needs and suit all tastes!

### Most difficult tasks👻
* Following DRY, KISS and other principles 
* Keeping models and migrations simple and structured 
* Configuring elasticsearch :)

### Most interesting😋
* Controllers, routing and lots of debugging
* Designing views 
* Sidekiq and workers 
* Manual testing

### If I had more time I would🥸
* Create and use policies 
* Create a sales system for salon owners
* More tests 
* Refactor models and controllers to keep them as simple as possible 
* Design emails
* Finish internationalization for all views
* Configure Pagy (I have already but it suddenly crashed when I merged it into development)

### How to run: 
1. git@github.com:iTechArt-RubyLab/dress_rental.git
2. rails db:create
3. rails db:migrate
4. rails db:seed
5. redis-server
6. sidekiq
7. rails s