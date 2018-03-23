(function() {
  $(document).on('click', '.btn-follow', function(event) {
    event.preventDefault()

    const $this = $(this)
    const path = $(this).attr("href")
    axios
      .post(path)
      .then((response) => {
        console.log(response)
        $this.trigger('follow:following')
      })
      .catch(error => console.log(error))

  })

  $(document).on('click', '.btn-following', function(event) {
    event.preventDefault()

    const $this = $(this)
    const path = $(this).attr("href")
    axios
      .delete(path)
      .then((response) => {
        console.log(response)
        $this.trigger('follow:follow')
      })
      .catch(error => console.log(error))
  })

  // Unfollowed/Follow state
  $(document).on('follow:follow', '.btn-follow, .btn-following', function(event) {
    $(this).closest(".js-follow-container")
      .removeClass("following")
      .addClass("follow")
    console.log("Unfollowed")
  })

  // Following/Followed state
  $(document).on('follow:following', '.btn-follow, .btn-following', function(event) {
    $(this).closest(".js-follow-container")
      .removeClass("follow")
      .addClass("following")
    console.log("Followed")
  })
})()
