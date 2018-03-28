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
   * Delete tweet from feed stream
   *
   * #feedStream use for main feeds/tweets/replies
   */
  $(document).on("click", "#feedStream .btn-delete-tweet", function(event) {
    event.preventDefault()

    const $this = $(this)
    const $container = $this.closest('.tweet-wrapper')
    const url = $this.attr('href')

    deleteReply(url, (data) => {
      $container.remove()
    })
  })

  /**
   * Delete reply
   *
   * #replyStream use for tweet's root replies container
   */
  $(document).on("click", "#replyStream .btn-delete-tweet", function(event) {
    event.preventDefault()

    const $this = $(this)
    const $container = $this.closest('.tweet-container')
    const url = $this.attr('href')

    deleteReply(url, (data) => {
      $container.replaceWith(data)
    })
  })

  /**
   * Delete tweet while it shown in modal
   */
  $(document).on("click", ".modal-show-tweet .tweet-wrapper .btn-delete-tweet", function(event) {
    event.preventDefault()

    const $this = $(this)
    const $modal = $(".modal-show-tweet")
    const url = $this.attr('href')

    deleteReply(url, (data) => {
      $modal.modal('hide')
    })
  })

  /**
   * Send delete request to server
   */
  function deleteReply(url, callback) {
    axios
      .delete(url)
      .then((response) => {
        console.log(response.data)
        callback && callback(response.data)
      })
      .catch(error => console.log(error))
      .finally(() => lazyloadImages())
  }


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
