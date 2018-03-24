(function() {
  /**
   * Attach event on tweet container. It will open the modal, fetch data
   * from server then set the data to client.
   * It wont set the data if modal is already closed.
   */
  $(document).on("click", ".btn-show-tweet", function(event) {
    event.preventDefault()

    const $modal = $(".modal-show-tweet")
    const $modalContent = $modal.find(".modal-content")
    const path = $(this).data('path')

    $modal.modal('show')

    setTimeout(function () {
      axios.get(path)
        .then((response) => {
          console.log(response) //debug
          console.log(isOpening($modal))
          if (isOpening($modal)) {
            $modalContent.html(response.data)
            $('.lazy').lazyload().removeClass('lazy')
          }
        })
        .catch(error => console.log(error)) //debug
    }, 3000)
  })

  // Prevent links and buttons from triggering tweet modal
  $(document).on("click", ".btn-show-tweet a, .btn-show-tweet button", function(event) {
    event.stopPropagation()
  })

  /**
   * Button to delete tweet.
   * It will close the modal if tweet is showed in modal.
   * If in newfeeds stream, it will remove the item from client.
   */
  $(document).on("click", ".btn-delete-tweet", function(event) {
    event.preventDefault()

    const $this = $(this)
    const $modal = $(".modal-show-tweet")
    const $modalContent = $this.closest(".modal-content")
    const $container = $this.closest(".tweet-wrapper")

    const path = $this.attr('href')

    setTimeout(function () {
      axios.delete(path)
        .then((response) => {
          if ($modalContent.length > 0) {
            $modal.modal('hide')
          } else {
            $container.remove()
          }
        })
        .catch(error => console.log(error)) //debug
    }, 3000)
  })

  /**
   * React button. Use ".btn-undo" to mark reacted tweet
   */
  $(document).on("click", ".js-btn-react", function(event) {
    event.preventDefault()

    const $this = $(this)
    const path = $this.attr('href')

    if ($this.is('.btn-undo')) {
      axios
        .delete(path)
        .then((response) => {
          $this.trigger("react:untouched")
        })
        .catch(error => console.log(error)) //debug
    } else {
      axios
        .post(path)
        .then((response) => {
          $this.trigger("react:touched")
        })
        .catch(error => console.log(error)) //debug
    }
  })

  // Unreacted (Ready to react) state
  $(document).on('react:untouched', '.js-btn-react', function(event) {
    $(this).removeClass('btn-undo')
  })

  // Reacted state
  $(document).on('react:touched', '.js-btn-react', function(event) {
    $(this).addClass('btn-undo')
  })
})()
