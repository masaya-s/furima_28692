window.addEventListener('DOMContentLoaded', () => {
  const path = location.pathname;

  // '/items/new'以外のページでitemPrice.addEventListenerへのアクセスを制限する
  if (path === '/items/new') {
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