/*global $*/
//3と25行目はドキュメントが読み込まれたら2〜24行目までの処理を走らせるために待ち構えている。
//逆にドキュメントが読み込まれなければ何も処理を走らせない。
document.addEventListener('DOMContentLoaded', () => {
  // no-post-imageのsrc属性を事前に取得しておく
  const noPostImgeSrc = document.getElementsByClassName('no-post-image')[0].src;
  //39行目に値が入った時のための準備。この時点では何も処理はされない
  const createImageHTML = (blob) => {
    //imageElement = <div id="post-image"></div> <=divにidをつけている
    const imageElement = document.getElementById('post-image');
    //blobImage = <img /> <=imgタグを生成している
    const blobImage = document.createElement('img');
    //blobImage = <img class="post-img" /> <=10行目で生成したimgタグにclassをつけている
    blobImage.setAttribute('class', 'post-img')
    //blobImage = <img class="post-img" src="bolb..." /> <=12行目でclassをつけたimgタグにさらにsrcをつけている
    blobImage.setAttribute('src', blob);
    //8行目で準備していたdivタグの中に14行目までに準備したimgタグを追加している
    //<div class="post-image"><img class="post-img src="blob..." /></div>
    imageElement.appendChild(blobImage);
  };

  //21行目は「（画像を）選択してください」のフォームそのものを定義している
  const post_image = document.getElementById('post_image')
  //23行目はフォームが正しく取得できているか確認している。正しく取得できなければこれ以降処理を行わない
  if (post_image) {
    //addEventListenerがフォームに'change'event（新しく画像を挿入されること）が発生するのを待ち構えている。
    //イベントが発生しなければ処理は行われない
    post_image.addEventListener('change', (e) => {
      //'change'eventが発生したら<div class="post-image"></div>を定義している
      const imageContent = document.getElementById('post-image');
      //imageContent（<div class="post-image"></div>）に元の画像があるかを確認している
      if (imageContent){
        //元の画像が存在している場合は、innerHTML = ""によって中身を消されている
        imageContent.innerHTML = ""
      }
      //e.target.files[0];はフォームのこと。26でチェンジが起きた時にフォームに挿入された画像を定義している
      const file = e.target.files[0];
      
      if (file) {
        //srcに画像を表示させるためのURLを持たせるためにcreateObjectURL(file);でさっきの画像のURLを生成している
        const blob = window.URL.createObjectURL(file);
        //6行目のcreateImageHTMに37行目に作成したURLを渡している
        createImageHTML(blob); 
      } else {
        createImageHTML(noPostImgeSrc);
      }
    });
  }
});