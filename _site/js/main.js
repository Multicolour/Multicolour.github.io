;(function(self) {
  "use strict"

  /**
   * Just adjust the scroll when there's
   * a hash present in the location or
   * when it changes.
   * @return {void}
   */
  function adjustScrollTop() {
    self.scrollTo(0, self.scrollY - 150)
  }

  // Initial change.
  if (self.location.hash) adjustScrollTop()

  // Reactive adjustment.
  self.onhashchange = adjustScrollTop

  // Try to find the search box.
  var search = document.querySelector(".search input[type=search]")
  var search_results = document.querySelector(".search-results")
  var filterable = Array.from(search_results.querySelectorAll("li[data-keywords]"))

  if (search) {
    const pos = search.getBoundingClientRect()

    search.addEventListener("focus", function() {
      search_results.classList.add("intent")
      search_results.style.top = pos.bottom + "px"
    })
    search.addEventListener("blur", function() {
      setTimeout(function() {
        search_results.classList.remove("intent")
        search_results.classList.remove("searched")
        search_results.style.top = null
      }, 300)
    })
    search.addEventListener("keyup", function(event) {
      var value = event.target.value.toLowerCase()

      if (value.length > 0)
        search_results.classList.add("searched")
      else
        search_results.classList.remove("searched")

      filterable.forEach(function(element) {
        var search = (element.dataset.keywords + " " + element.innerText).toLowerCase()
        if (value.length === 0)
          element.classList.add("visible")
        else if (value.length > 0 && search.search(value) > -1)
          element.classList.add("visible")
        else
          element.classList.remove("visible")
      })
    })
  }
})(window)
