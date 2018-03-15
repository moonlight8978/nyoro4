(function() {
  $(document).on('click', '.btn-follow', function(event) {
    event.preventDefault()
    event.stopPropagation();
    changeState(this, ".follow-container-js", "follow", "following")
    console.log("Followed")
  })

  $(document).on('click', '.btn-following', function(event) {
    event.preventDefault()
    changeState(this, ".follow-container-js", "following", "follow")
    console.log("Unfollowed")
  })

  function changeState(el, container, fromState, toState) {
    const $el = $(el)
    const $container = $el.closest(container)

    const method = $el.data("type")
    const path = $el.attr("href")

    let promise

    if (isPost(method)) {
      promise = axios.post(path)
    } else {
      promise = axios.delete(path)
    }

    promise
      .then((response) => {
        console.log(response.data)
        $container.removeClass(fromState)
        $container.addClass(toState)
      })
      .catch(error => console.log(error.response))
  }

  function isPost(method) {
    return method === "post"
  }
})()
