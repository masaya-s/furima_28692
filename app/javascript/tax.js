window.addEventListener('DOMContentLoaded', () => {
  const path = location.pathname;

  // アクセスエラー防止の為、指定外のリンクでitemPrice.addEventListenerを発火させない
  if (path === '/items/new' || '/items') {
    const itemPrice = document.getElementById('item-price');
    const addTaxPrice = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    const tax = 0.1;

    itemPrice.addEventListener('input', () => {
      const price = itemPrice.value;

      // Math.floorによる端数の切り捨て計算をfeeに代入
      const fee = Math.floor(price * tax);

      addTaxPrice.innerHTML = fee;
      profit.innerHTML = price - fee;
    });
  }
});