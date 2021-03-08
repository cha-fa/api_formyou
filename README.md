# Rails boilerplate

##### Can be used with the [associated React frontend](https://github.com/cha-fa/react_boilerplate)

## Description
* Ruby '2.7.1'  
* Rails '6.1.3'  
* PostgreSQL '12.6'  
* Devise-jwt '0.7.0' (Allowlist Revocation Strategy)  
* Rspec-rails '4.0.2'  
* Factory_bot_rails '6.1'  


## Usage

Clone this repository  
Generate a secret key `rails secret`  
Create a .env with `DEVISE_JWT_SECRET_KEY="yoursecretkey"`    
`bundle install`  
`rails db:create db:migrate`  
`rails server`  
Your app will be running on `http://localhost:8080`  

