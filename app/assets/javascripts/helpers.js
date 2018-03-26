function isOpening(modal) {
  return modal.attr('opening') === 'true'
}

function lazyloadImages() {
  $('.lazy').lazyload().removeClass('lazy')
}
