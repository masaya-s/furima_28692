window.addEventListener('DOMContentLoaded', () => {
  const itemPrice = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');
  const tax = 0.1;
  if (itemPrice) {
    itemPrice.addEventListener('input', () => {
      const price = itemPrice.value;

      // Math.floorによる端数の切り捨て計算をfeeに代入
      const fee = Math.floor(price * tax);

      addTaxPrice.innerHTML = fee;
      profit.innerHTML = price - fee;
    });
  }
});