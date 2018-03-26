(function() {
  // Focus tweet compose form to expand
  $(document).on("focus", ".js-composer", function(event) {
    changeState(this, ".tweet-compose-container, .reply-compose-container", ".form-control", "inactive", "active")
  })

  // Click minimize button to minimize the form
  $(document).on("click", ".tweet-compose-minimize", function(event) {
    changeState(this, ".tweet-compose-container, .reply-compose-container", ".form-control", "active", "inactive")
  })

  $(document).on("submit", ".new-tweet-composer .js-composer", function(event) {
    event.preventDefault()
    tweet(this, (data) => {
      $("#feedStream").prepend(data)
    })
  })

  $(document).on("submit", ".inline-reply-composer .js-composer", function(event) {
    event.preventDefault()
    tweet(this, (data) => {
      $("#replyStream").prepend(data)
    })
  })

  /**
   * After submiting the data, it check if modal is used for tweet's reply or
   *  reply's reply by checking the conversation-id.
   *  If conversation exists, it will append the data to conversation stream
   */
  $(document).on("submit", ".modal-reply-tweet .js-composer", function(event) {
    event.preventDefault()
    tweet(this, (data) => {
      const $modal = $('.modal-reply-tweet')
      const conversationId = $modal.data('conversation-id')
      if (conversationId) {
        const $conversation = $(`.conversation-stream[data-conversation-id="${conversationId}"]`)
        $conversation.append(data)
      }

      $modal.modal('hide')
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
      .finally(() => {
        $submitButton.removeAttr('disabled')
        lazyloadImages()
      })
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
