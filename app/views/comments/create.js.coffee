<% if @comment.persisted? %>

$('#comment-flash').text('Comment added!')
$('#comment_body').val('')
newComment = $('<%= raw j(render(@comment)) %>').css({ opacity: 0 })

if $('.comment').length > 0
  scores = for comment in $('.comment')
    parseInt($(comment).data('score'))
  minScore = Math.min((score for score in scores when score >= 0)...)
  $("#comments [data-score=#{minScore}]").last().after(newComment)
else
  $('#comments').append(newComment)

$('html, body').scrollTop(newComment.offset().top)
newComment.animate({ opacity: 1 }, 'slow')

<% else %>

$('#comment-flash').text("<%= raw j(@comment.errors.full_messages.join(', ')) %>")

<% end %>
