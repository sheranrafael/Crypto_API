Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rotas da API
      get '/price/:crypto_id', to: 'cryptos#price', constraints: { crypto_id: /bitcoin|ethereum/ }
      get '/convert', to: 'cryptos#convert'
      
      # Health check simplificado
      get '/status', to: 'health#check'
      get '/api/v1/status', to: 'health#check'
    end
  end

  # Rota raiz para o frontend
  root to: redirect('/index.html')

  # Rota de health check alternativa
  get '/status', to: 'health#check'
end