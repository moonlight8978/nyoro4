(function() {
  $(document).on('click', '.js-btn-spoil', function(event) {
    event.preventDefault()

    const $this = $(this)
    const url = $this.attr('href')
    const $wrapper = $this.closest('.js-has-more-wrapper')
    const $container = $wrapper.find('.js-has-more-container')
    const btnContainerSelector = $this.data('container')


    getData(url, (data) => {
      if (btnContainerSelector) {
        $this.closest(btnContainerSelector).remove()
      } else {
        $this.remove()
      }
      $container.append(data)
      lazyloadImages()
    })
  })

  function getData(url, callback) {
    axios.get(url)
      .then(response => {
        console.log(response.data)
        callback && callback(response.data)
      })
      .catch(error => console.log(error))
  }
})()
