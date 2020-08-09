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

// jscroll 無限スクロール（これが一番正常）
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
      $('#result').html('<img src="' + fileReader.result + '" width="100%" height="100%">');
    }
    fileReader.readAsDataURL(file);
  });
});

