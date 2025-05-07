# Crypto API 🚀

Uma API simples para consulta de cotações de criptomoedas em tempo real, desenvolvida com Ruby on Rails.

## 📌 Recursos

- Consulta de preços de Bitcoin e Ethereum
- Conversão entre moedas
- Health check da API
- Frontend integrado com HTML/JS/CSS

## 🛠 Tecnologias

- Ruby 3.x
- Rails 8.x
- SQLite (dev)
- HTTParty (integração com APIs)
- CoinGecko API (dados reais)

## ⚡ Como Usar

### Requisitos
- Ruby 3.x instalado
- Bundler (`gem install bundler`)

### Instalação
```bash
git clone [seu-repositorio]
cd crypto_api
bundle install
rails db:create db:migrate