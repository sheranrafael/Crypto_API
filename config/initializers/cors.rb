Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' 
      resource '*',
        headers: :any,
        methods: [:get, :post, :options],
        expose: ['RateLimit-Limit', 'RateLimit-Remaining']
    end
  end

  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # Em produção, você deve restringir isso a domínios específicos
      resource '*',
        headers: :any,
        methods: [:get, :post, :options],
        expose: ['Authorization']
    end
  end