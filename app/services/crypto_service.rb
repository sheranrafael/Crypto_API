require 'httparty'

class CryptoService
  BASE_URL = "https://api.coingecko.com/api/v3"

  def self.get_price(crypto_id, currency = 'usd')
    response = HTTParty.get(
      "#{BASE_URL}/simple/price?ids=#{crypto_id}&vs_currencies=#{currency}",
      headers: { 'Accept' => 'application/json' }
    )
    
    if response.success?
      response.parsed_response
    else
      { error: "Falha ao buscar dados: #{response.code}" }
    end
  rescue => e
    { error: "Erro na requisição: #{e.message}" }
  end
end
HTTParty.get(url, timeout: 10) # Aumente o timeout
