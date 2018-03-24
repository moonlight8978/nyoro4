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
   * Attach event on reply button. It will open the modal, fetch data
   * from server then set the data to client.
   * It wont set the data if modal is already closed.
   */
  $(document).on("click", ".js-btn-reply-tweet", function(event) {
    event.preventDefault()

    const $modal = $(".modal-reply-tweet")
    const $modalContent = $modal.find(".modal-content")
    const url = $(this).attr('href')
    $modal.modal("show")

    setTimeout(function () {
      axios
        .get(url)
        .then((response) => {
          console.log(response) //debug

          if (isOpening($modal)) {
            $modalContent.html(response.data)
            $('.lazy').lazyload().removeClass('lazy')
          }
        })
        .catch(error => console.log(error)) //debug
    }, 3000);
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
    $modalContent.html(htmlLoading)
  })

  function getData() {
    return new Promise((resolve, reject) => {
      setTimeout(function () {
        resolve(1)
      }, 3000)
    })
  }
})()
