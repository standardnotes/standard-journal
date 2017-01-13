// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require turbolinks
//= require_tree .


document.addEventListener("turbolinks:load", function(event) {
  var buttons = document.getElementsByClassName("like-button");

  for (var i=0; i < buttons.length; i++) {
    buttons[i].onclick = function(event){
      var button = event.target;
      var uuid = button.dataset.uuid;
      var xmlhttp = new XMLHttpRequest();

      xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
          var response = JSON.parse(xmlhttp.responseText);
          if(response.liked == true) {
            button.getElementsByClassName("liked")[0].classList.remove("hidden");
            button.getElementsByClassName("unliked")[0].classList.add("hidden");
          } else {
            button.getElementsByClassName("liked")[0].classList.add("hidden");
            button.getElementsByClassName("unliked")[0].classList.remove("hidden");
          }

          var likeCount = button.parentNode.getElementsByClassName("like-count")[0];
          if(likeCount) {
            likeCount.innerHTML = response.like_count;
          }
        }
      }

      xmlhttp.open("post", "/posts/toggle_like", true);
      xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
      xmlhttp.send("uuid=" + uuid);
    }

  }

});
