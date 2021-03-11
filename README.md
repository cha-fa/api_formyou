# Rails Api to the Form You app.

##### Can be used with the [associated React frontend](https://github.com/cha-fa/react_boilerplate)

## Description
* Ruby '2.7.1'  
* Rails '6.1.3'  
* PostgreSQL '12.6'  
* Devise-jwt '0.7.0' (Allowlist Revocation Strategy)  
* Rspec-rails '4.0.2'  
* Factory_bot_rails '6.1'  
* Mailjet (in production)
* letter opener (in development)

## Usage

Clone this repository  
Generate a secret key `rails secret`  
Create a .env with `DEVISE_JWT_SECRET_KEY="yoursecretkey"`    
`bundle install`  
`rails db:create db:migrate`  
`rails server`  
Your app will be running on `http://localhost:8080`  

## Production 
 visit the app (https://formyou.herokuapp.com/)

## Routes

after cloning this repository, if you when to use specific routes for this api, please use 
`rails routes`
Remember that you will need an authentication token to fetch your data.

### Enjoy!