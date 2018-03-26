(function() {
  // sample data
  const html = `
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    \n\n
    <a href="#" class="btn-reply-tweet">Reply</a>
  `

  // modal loading animation
  const htmlLoading = `<div class="modal-loading"></div>`

  /**
   * Get the reply form
   *
   * #feedStream use for main feeds/tweets/replies
   */
  $(document).on("click", "#feedStream .js-btn-reply-tweet", function(event) {
    event.preventDefault()

    const url = $(this).attr('href')
    getForm(url)
  })

  /**
   * It get the conversation-id from .conversation-stream and bind it to modal
   *  Usage of conversation-id, see 'tweet-compose'.
   *  Then get the reply form
   *
   * #replyStream use for tweet's root replies container
   */
  $(document).on("click", "#replyStream .js-btn-reply-tweet", function(event) {
    event.preventDefault()

    const $this = $(this)
    const $modal = $(".modal-reply-tweet")
    const url = $this.attr('href')

    const conversationId = $this.closest('.conversation-stream').data('conversation-id')
    $modal.data('conversation-id', conversationId)

    getForm(url)
  })

  /**
   * Add "opening" attribute to modal to mark it as opening
   */
  $(document).on("show.bs.modal", ".js-modal", function(event) {
    const $modal = $(this)
    $modal.attr('opening', true)
  })

  /**
   * Remove "opening" attribute to mark it as closed,
   * then replace content by loading animation
   */
  $(document).on("hidden.bs.modal", ".js-modal", function(event) {
    const $modal = $(this)
    const $modalContent = $modal.find(".modal-content")
    $modal.removeAttr('opening')
    $modal.removeData('conversation-id')
    $modalContent.html(htmlLoading)
  })


  /**
   * Open the modal, get reply form from server, and show it
   */
  function getForm(url, callback) {
    const $modal = $(".modal-reply-tweet")
    const $modalContent = $modal.find(".modal-content")

    $modal.modal("show")
    setTimeout(function () {
      axios
        .get(url)
        .then((response) => {
          console.log(response)

          if (isOpening($modal)) {
            $modalContent.html(response.data)
          }
          callback && callback(response.data, $modal)
        })
        .catch(error => console.log(error))
        .finally(() => {
          lazyloadImages()
        })
    }, 3000)
  }
})()
