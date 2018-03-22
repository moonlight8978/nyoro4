(function() {
  $(document).on("click", ".btn-show-tweet", function(event) {
    event.preventDefault()

    const $modal = $(".modal-show-tweet")
    const $modalContent = $modal.find(".modal-content")
    $modal.attr("loading", true)
    $modal.modal("show")

    const path = $(this).data('path')

    setTimeout(function () {
      axios.get(path)
        .then((response) => {
          console.log(response)
          if ($modal.attr("loading")) {
            $modalContent.html(response.data)
            $modal.removeAttr("loading")
          }
        })
        .catch(error => console.log(error))
    }, 3000)
  })

  $(document).on("click", ".btn-show-tweet a, .btn-show-tweet button", function(event) {
    event.stopPropagation()
  })

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
        .catch(error => console.log(error))
    }, 3000)
  })

  $(document).on("click", ".js-btn-react", function(event) {
    event.preventDefault()

    const $this = $(this)
    const path = $this.attr('href')
    axios
      .post(path)
      .then(() => {
        $this.removeClass('js-btn-react')
        $this.addClass('btn-undo')
      })
      .catch(error => console.log(error))
  })

  $(document).on("click", ".btn-undo", function(event) {
    event.preventDefault()

    const $this = $(this)
    const path = $this.attr('href')
    axios
      .delete(path)
      .then(() => {
        $this.removeClass('btn-undo')
        $this.addClass('js-btn-react')
      })
      .catch(error => console.log(error))
  })
})()
