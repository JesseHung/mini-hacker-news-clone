window.toggleComment = function(commentId) {
  var commentContentId = 'comment-content-' + commentId;
  var element = document.getElementById(commentContentId);
  var elementToggle = document.getElementById('comment-toggle-' + commentId);
  var elementToggleCollapse = document.getElementById('comment-toggle-collapsed-' + commentId);

  if (element.classList.contains('collapsed-comment')) {
    element.classList.remove("collapsed-comment");
    elementToggle.classList.remove("collapsed-comment");
    elementToggleCollapse.classList.add("collapsed-comment");

  } else {
    element.classList.add("collapsed-comment");
    elementToggle.classList.add("collapsed-comment");
    elementToggleCollapse.classList.remove("collapsed-comment");
  }
}