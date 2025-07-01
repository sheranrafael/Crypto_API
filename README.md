# Crypto API

A simple API for real-time cryptocurrency price queries, developed with Ruby on Rails.

## Features

- Bitcoin and Ethereum price lookup
- Currency conversion
- API health check
- Integrated frontend with HTML/JS/CSS

## Technologies
### Backend

- Ruby 3.3.7
- Rails 8.0.2
- PostgreSQL 17.5 (replacing SQLite 3.50.2)
- HTTParty (for external API integration)
- CoinGecko API

### Frontend

- HTML5
- CSS3
- JavaScript ES6

Infrastructure/DevOps

- Docker
- Shell Script (for automation)
- Render (for deployment)

Development Tools

-Bundler (Ruby dependency management)
-RSpec/Minitest

## Screenshot
![A](https://github.com/user-attachments/assets/28180dc2-f538-4684-99ae-7baec5a03955)

## Installation
```bash
git clone https://github.com/sheranrafael/Crypto_API.git
cd crypto_api  
bundle install  
rails db:create db:migrate  
