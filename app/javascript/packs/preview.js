/*global $*/

document.addEventListener('DOMContentLoaded', () => {
  const createImageHTML = (blob) => {
    const imageElement = document.getElementById('edit-image');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('class', 'edit-img')
    blobImage.setAttribute('src', blob);

    imageElement.appendChild(blobImage);
  };

  const user_profile_image = document.getElementById('user_profile_image')
  if (user_profile_image) {
    user_profile_image.addEventListener('change', (e) => {
      const imageContent = document.getElementById('edit-image');
      if (imageContent){
        imageContent.innerHTML = ""
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  }
});
