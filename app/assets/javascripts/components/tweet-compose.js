(function() {
  // Focus tweet compose form to expand
  $(document).on("focus", ".tweet-compose-form", function(event) {
    changeState(this, ".tweet-compose-container, .reply-compose-container", ".form-control", "inactive", "active")
  })

  // Click minimize button to minimize the form
  $(document).on("click", ".tweet-compose-minimize", function(event) {
    changeState(this, ".tweet-compose-container, .reply-compose-container", ".form-control", "active", "inactive")
  })

  $(document).on("submit", ".tweet-compose-container .tweet-compose-form", function(event) {
    event.preventDefault()
    tweet(this, (data) => {
      $("#newfeeds").prepend(data)
    })
  })

  $(document).on("submit", ".reply-compose-container .tweet-compose-form", function(event) {
    event.preventDefault()
    tweet(this, (data) => {
      const $modal = $('.modal-reply-tweet')

      if ($modal.length > 0) {
        $modal.modal('hide')
      } else {
        $('#tweetComments').prepend(data)
      }
    })
  })

  function tweet(form, callback) {
    const data = new FormData(form)
    const $form = $(form)
    const url = $(form).attr("action")
    const $submitButton = $form.find('[type="submit"]')

    axios.post(url, data)
      .then(response => {
        console.log(response)
        form.reset()
        callback && callback(response.data)
      })
      .catch(error => {
        console.log(error)
        error.response && console.log(error.response)
      })
      .finally(() => $submitButton.removeAttr('disabled'))
  }

  const state = {
    active: {
      class: "active",
      rows: 4,
    },
    inactive: {
      class: null,
      rows: 1,
    }
  }

  function changeState(element, containerSelector, inputSelector, fromState, toState) {
    const $el = $(element)
    let $container = $el.closest(containerSelector)
    let $input = $container.find(inputSelector)

    $input.attr("rows", state[toState].rows)
    state[fromState].class && $container.removeClass(state[fromState].class)
    state[toState].class && $container.addClass(state[toState].class)
  }
})()
