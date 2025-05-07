class Rack::Attack
    throttle('api/ip', limit: 10, period: 1.minute) do |req|
      req.ip if req.path.start_with?('/api')
    end
  
    # Configuração adicional para CORS
    Rack::Attack.safelist('allow from localhost') do |req|
      req.ip == '127.0.0.1' || req.ip == '::1'
    end
  end

  # class Rack::Attack
#   throttle('api/ip', limit: 10, period: 1.minute) do |req|
#     req.ip if req.path.start_with?('/api')
#   end
# end