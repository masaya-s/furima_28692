const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById('charge-form');
  if (form) {
    form.addEventListener('submit', (e) => {
      // JavaScriptで送信するため、Railsのフォーム送信処理をキャンセル
      e.preventDefault();

      const formResult = document.getElementById('charge-form');
      const formData = new FormData(formResult);

      // カードの情報を変数に代入
      const card = {
        number: formData.get('number'),
        cvc: formData.get('cvc'),
        exp_month: formData.get('exp_month'),
        exp_year: `20${formData.get('exp_year')}`,
      };

      // PAY.JPにアクセスして、トークンを作成
      Payjp.createToken(card, (status, response) => {
        if (status == 200) {
          // 生成されたトークンを変数に代入
          const token = response.id;
          const renderDom = document.getElementById('charge-form');
          // 生成するHTMLを定義
          const tokenObj = `<input value=${token} type="hidden" name='token'>`;
          // formの最後に生成
          renderDom.insertAdjacentHTML('beforeend', tokenObj);
        }
        document.getElementById('card-number').removeAttribute('name');
        document.getElementById('card-cvc').removeAttribute('name');
        document.getElementById('card-exp-month').removeAttribute('name');
        document.getElementById('card-exp-year').removeAttribute('name');

        document.getElementById('charge-form').submit();
        document.getElementById('charge-form').reset();
      });
    });
  }
};

window.addEventListener('load', pay);