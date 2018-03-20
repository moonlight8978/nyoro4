(function() {
  const html = `
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    \n\n
    <a href="#" class="btn-reply-tweet">Reply</a>
  `

  const htmlLoading = `<div class="modal-loading"></div>`

  $(document).on("click", ".btn-reply-tweet", function(event) {
    event.preventDefault()
    event.stopPropagation()
    const $modal = $(".modal-reply-tweet")
    const $modalContent = $modal.find(".modal-content")
    $modal.attr("loading", true)
    $modal.modal("show")

    getData()
      .then((response) => {
        console.log(response)
        if ($modal.attr("loading")) {
          $modalContent.html(html)
          $modal.removeAttr("loading")
        }
      })
      .catch(error => console.log(error))
  })

  $(document).on("hidden.bs.modal", ".modal", function(event) {
    const $modal = $(this)
    const $modalContent = $modal.find(".modal-content")
    $modal.removeAttr("loading")
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
