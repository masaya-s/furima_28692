window.addEventListener('DOMContentLoaded', () => {
  const fileName = document.getElementById('file-name');
  const itemImage = document.getElementById('item-image');
  if (itemImage) {
    itemImage.addEventListener('change', () => {
      fileName.innerHTML = itemImage.files[0].name;
    });
  }
});