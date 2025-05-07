document.addEventListener('DOMContentLoaded', () => {
    // Elementos da UI
    const errorAlert = document.getElementById('error');
    const pricesContainer = document.getElementById('prices');
    const convertBtn = document.getElementById('convert-btn');
    const resultDiv = document.getElementById('result');
    const fromSelect = document.getElementById('from');
    const toSelect = document.getElementById('to');
    const amountInput = document.getElementById('amount');
  
    // Dados iniciais
    const CRYPTOS = [
      { id: 'bitcoin', name: 'Bitcoin (BTC)' },
      { id: 'ethereum', name: 'Ethereum (ETH)' }
    ];
    const CURRENCIES = ['usd', 'brl'];
  
    // Inicialização
    initSelects();
    fetchPrices();
    setInterval(fetchPrices, 30000); // Atualiza a cada 30 segundos
  
    // Funções principais
    function initSelects() {
      CRYPTOS.forEach(crypto => {
        fromSelect.add(new Option(crypto.name, crypto.id));
        toSelect.add(new Option(crypto.name, crypto.id));
      });
    }
  
    async function fetchPrices() {
      try {
        pricesContainer.innerHTML = '<div class="loader">Carregando cotações...</div>';
        
        const priceData = {};
        await Promise.all(CRYPTOS.map(async crypto => {
          priceData[crypto.id] = {};
          await Promise.all(CURRENCIES.map(async currency => {
            priceData[crypto.id][currency] = await fetchPrice(crypto.id, currency);
          }));
        }));
  
        displayPrices(priceData);
      } catch (err) {
        console.error("Erro ao buscar preços:", err);
        showError("Dados podem estar desatualizados");
        displayPrices(getFallbackPrices()); // Exibe fallback
      }
    }
  
    async function fetchPrice(crypto, currency) {
      try {
        const response = await fetch(`/api/v1/price/${crypto}?currency=${currency}`);
        if (!response.ok) throw new Error();
        const data = await response.json();
        return data[crypto][currency];
      } catch {
        console.warn(`Falha ao buscar ${crypto} em ${currency}, usando fallback`);
        return getFallbackPrices()[crypto]?.[currency] || null;
      }
    }
  
    function displayPrices(data) {
      pricesContainer.innerHTML = CRYPTOS.map(crypto => `
        <div class="crypto-card">
          <h3>${crypto.name}</h3>
          ${CURRENCIES.map(currency => `
            <div class="price-row">
              <span>${currency.toUpperCase()}:</span>
              <span>${formatCurrency(data[crypto.id]?.[currency], currency)}</span>
            </div>
          `).join('')}
        </div>
      `).join('');
    }
  
    // Conversão
    convertBtn.addEventListener('click', async () => {
      const from = fromSelect.value;
      const to = toSelect.value;
      const amount = parseFloat(amountInput.value);
  
      if (!validateAmount(amount)) {
        showError("Insira um valor válido (maior que 0)");
        return;
      }
  
      try {
        const result = await convertCurrency(from, to, amount);
        showConversionResult(result);
      } catch (err) {
        console.error("Erro na conversão:", err);
        showError(err.message || "Erro ao converter");
      }
    });
  
    async function convertCurrency(from, to, amount) {
      const response = await fetch(`/api/v1/convert?from=${from}&to=${to}&amount=${amount}`);
      if (!response.ok) {
        const error = await response.json().catch(() => ({}));
        throw new Error(error.error || "Erro na API");
      }
      return await response.json();
    }
  
    // Utilitários
    function showConversionResult(result) {
      document.getElementById('converted-amount').textContent = 
        formatCurrency(result.converted_amount, result.to);
      resultDiv.style.display = 'block';
      errorAlert.style.display = 'none';
    }
  
    function formatCurrency(value, currency) {
      if (!value) return '--';
      return value.toLocaleString(currency === 'brl' ? 'pt-BR' : 'en-US', {
        style: 'currency',
        currency: currency === 'brl' ? 'BRL' : 'USD'
      });
    }
  
    function validateAmount(amount) {
      return !isNaN(amount) && amount > 0;
    }
  
    function showError(message) {
      errorAlert.textContent = message;
      errorAlert.style.display = 'block';
      setTimeout(() => errorAlert.style.display = 'none', 5000);
    }
  
    function getFallbackPrices() {
      return {
        bitcoin: { usd: 63452.78, brl: 320000.00 },
        ethereum: { usd: 3456.20, brl: 17500.00 }
      };
    }
  });