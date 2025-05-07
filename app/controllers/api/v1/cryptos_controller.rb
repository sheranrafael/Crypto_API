module Api
  module V1
    class CryptosController < ApplicationController
      # Moedas e currencies suportadas
      SUPPORTED_CRYPTOS = ['bitcoin', 'ethereum'].freeze
      SUPPORTED_CURRENCIES = ['usd', 'brl'].freeze

      # GET /api/v1/price/:crypto_id
      def price
        crypto_id = params[:crypto_id].downcase
        currency = (params[:currency] || 'usd').downcase

        # Validação
        unless SUPPORTED_CRYPTOS.include?(crypto_id) && SUPPORTED_CURRENCIES.include?(currency)
          return render json: { error: "Moeda ou currency não suportada" }, status: :not_found
        end

        # Implementação REAL (remova o mock em produção)
        price = fetch_live_price(crypto_id, currency) rescue nil
        
        # Fallback mockado se a API falhar (para desenvolvimento)
        price ||= mock_prices.dig(crypto_id, currency)

        render json: { crypto_id => { currency => price } }
      end

      # GET /api/v1/convert?from=btc&to=usd&amount=1
      def convert
        from = params[:from]&.downcase
        to = params[:to]&.downcase
        amount = params[:amount]&.to_f

        # Validação
        unless valid_params?(from, to, amount)
          return render json: { error: "Parâmetros inválidos" }, status: :bad_request
        end

        # Implementação REAL (remova o mock em produção)
        rate = fetch_conversion_rate(from, to) rescue nil
        
        # Fallback mockado se a API falhar
        rate ||= mock_rates.dig(from, to)

        unless rate
          return render json: { error: "Taxa de conversão não disponível" }, status: :service_unavailable
        end

        render json: {
          from: from,
          to: to,
          amount: amount,
          converted_amount: (amount * rate).round(2),
          updated_at: Time.current,
          is_mock: rate == mock_rates.dig(from, to) # Indica se usou mock
        }
      end

      private

      def valid_params?(from, to, amount)
        SUPPORTED_CRYPTOS.include?(from) && 
        SUPPORTED_CURRENCIES.include?(to) && 
        amount&.positive?
      end

      # Mocks para desenvolvimento 
      def mock_prices
        {
          'bitcoin' => { 'usd' => 63452.78, 'brl' => 320000.00 },
          'ethereum' => { 'usd' => 3456.20, 'brl' => 17500.00 }
        }
      end

      def mock_rates
        mock_prices
      end

      # Implementação REAL com CoinGecko
      def fetch_live_price(crypto_id, currency)
        response = HTTParty.get(
          "https://api.coingecko.com/api/v3/simple/price?ids=#{crypto_id}&vs_currencies=#{currency}",
          headers: { "x_cg_demo_api_key" => "SUA_CHAVE_AQUI" } # Obtenha em: https://www.coingecko.com/en/api
        )
        raise "API não respondeu" unless response.success?
        response.parsed_response.dig(crypto_id, currency)
      end

      def fetch_conversion_rate(from, to)
        fetch_live_price(from, to)
      end
    end
  end
end