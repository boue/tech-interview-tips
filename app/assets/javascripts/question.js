// This will only be applied on Question.show page

$(document).ready(function(){

  $('#save-link').on("ajax:success", function (e, data, status, xhr) {
    $('#save-count').html(data.fav_count)
    $('#save-link').addClass('grey-out')
    $('#save-link').addClass('inactive')
  });

  $('#thumbs-up-link').on("ajax:success", function (e, data, status, xhr) {
    console.log(data)
    $('#thumbs-up-count').html(data.kudos_count)
    $('#thumbs-up-link').addClass('grey-out')
    $('#thumbs-up-link').addClass('inactive')
  });

  $(".answer-thumbs-up").on("ajax:success", function (e, data, status, xhr) {
    console.log(data)
    $('#'+data.id+' .answer-vote').html(data.kudos_count)
    $('#'+data.id+' .answer-thumbs-up').addClass('grey-out')
    $('#'+data.id+' .answer-thumbs-up').addClass('inactive')
  });

});