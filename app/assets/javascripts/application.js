// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
// ターボリンク削除（Ajax不発原因のため）
//= require_tree .

// jscroll 無限スクロール
$(function() {
  $('.jscroll').jscroll({
    contentSelector: '.post-list',
    nextSelector: 'span.next a'
  });
});


// 画像プレビュー
$(function(){
  $('#file').change(function(){
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.*')){
      return;
    }
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
      // $('#result').html('<img src="' + fileReader.result + '" width="100%" height="100%">');
      $('#result').html('<img src="' + fileReader.result + '" >');
    }
    fileReader.readAsDataURL(file);
  });
});

$(function(){
  $(".comment-submit-button").click(function(){
    $('.comment-preview').remove();
  });
});


// サイドバー カテゴリー一覧
$(function () {
  var duration = 300;
  var $list = $('.side-bar-contents-genre-list');
  $('#aside_button').on('click', function() {
    $list.toggleClass('open');
  });
});

// サイドバー ページ上部へ移動
$(function () {
  $('.fa-arrow-circle-up').mouseover(function() {
    $('#tips span').addClass('open-balloon')
    $('.fa-arrow-circle-up').mouseout(function() {
      // ページトップへ移動
      // $(function() {
        //   $('html,body').animate({ scrollTop: 0 }, '1');
        // });
        $('#tips span').removeClass('open-balloon')
      });
    });
  });

  // ページトップへ移動
  $(function() {
    $('#pagetop').click(function() {
      $('html, body').animate({scrollTop: 0}, "200");
    });
  });


// 画像クリックで投稿画像プレビュー
$(function(){
  $(document).on('click', '.posts-img img', function(){
      $(".graydisplay").html($(this).prop('outerHTML'));
      $(".graydisplay").fadeIn(200);
    });

    $(".graydisplay, .graydisplay img").click(function() {
      $(".graydisplay").fadeOut(200);
  });
});


// 画像クリックでコメント画像プレビュー
$(function(){
  $(document).on('click', '.comment-image img', function(){
      $(".graydisplay").html($(this).prop('outerHTML'));
      $(".graydisplay").fadeIn(200);
    });

    $(".graydisplay, .graydisplay img").click(function() {
      $(".graydisplay").fadeOut(200);
  });
});


// 画像クリックで問い合わせ画像プレビュー
$(function(){
  $(document).on('click', '.user-contact-show-image img', function(){
      $(".graydisplay").html($(this).prop('outerHTML'));
      $(".graydisplay").fadeIn(200);
    });

    $(".graydisplay, .graydisplay img").click(function() {
      $(".graydisplay").fadeOut(200);
  });
});


// 画像クリックでユーザーアイコン画像プレビュー(users/shownのみ)
$(function(){
  $(document).on('click', '.users-show-wrapper img', function(){
      $(".graydisplay-icon").html($(this).prop('outerHTML'));
      $(".graydisplay-icon").fadeIn(200);
    });

    $(".graydisplay-icon, .graydisplay-icon img").click(function() {
      $(".graydisplay-icon").fadeOut(200);
  });
});
