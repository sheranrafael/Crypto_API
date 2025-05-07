## Endpoints da API

### Obter preço
`GET /api/v1/price/:crypto_id`  
Parâmetros:  
- `currency` (opcional): brl, usd, eur (padrão: brl)

### Converter moedas
`GET /api/v1/convert`  
Parâmetros obrigatórios:  
- `from`: bitcoin, ethereum, etc  
- `to`: brl, usd  
- `amount`: valor numérico