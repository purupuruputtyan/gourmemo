/*global $*/
//3と25行目はドキュメントが読み込まれたら2〜24行目までの処理を走らせるために待ち構えている。
//逆にドキュメントが読み込まれなければ何も処理を走らせない。
document.addEventListener('DOMContentLoaded', () => {
  //39行目に値が入った時のための準備。この時点では何も処理はされない
  const createImageHTML = (blob) => {
    //imageElement = <div id="edit-image"></div> <=divにidをつけている
    const imageElement = document.getElementById('edit-image');
    //blobImage = <img /> <=imgタグを生成している
    const blobImage = document.createElement('img');
    //blobImage = <img class="edit-img" /> <=10行目で生成したimgタグにclassをつけている
    blobImage.setAttribute('class', 'edit-img')
    //blobImage = <img class-"edit-img" src="bolb..." /> <=12行目でclassをつけたimgタグにさらにsrcをつけている
    blobImage.setAttribute('src', blob);
    //8行目で準備していたdivタグの中に14行目までに準備したimgタグを追加している
    //<div class="edit-image"><img class="edit-img src="blob..." /></div>
    imageElement.appendChild(blobImage);
  };

  //21行目は「（画像を）選択してください」のフォームそのものを定義している
  const user_profile_image = document.getElementById('user_profile_image')
  //23行目はフォームが正しく取得できているか確認している。正しく取得できなければこれ以降処理を行わない
  if (user_profile_image) {
    //addEventListenerがフォームに'change'event（新しく画像を挿入されること）が発生するのを待ち構えている。
    //イベントが発生しなければ処理は行われない
    user_profile_image.addEventListener('change', (e) => {
      //'change'eventが発生したら<div class="edit-image"></div>を定義している
      const imageContent = document.getElementById('edit-image');
      //imageContent（<div class="edit-image"></div>）に元の画像があるかを確認している
      if (imageContent){
        //元の画像が存在している場合は、innerHTML = ""によって中身を消されている
        imageContent.innerHTML = ""
      }
      //e.target.files[0];はフォームのこと。26でチェンジが起きた時にフォームに挿入された画像を定義している
      const file = e.target.files[0];
      //srcに画像を表示させるためのURLを持たせるためにcreateObjectURL(file);でさっきの画像のURLを生成している
      const blob = window.URL.createObjectURL(file);
      //6行目のcreateImageHTMに37行目に作成したURLを渡している
      createImageHTML(blob);
    });
  }
});
