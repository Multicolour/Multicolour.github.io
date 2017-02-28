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
  var filterable = Array.from(document.querySelectorAll("li[data-keywords]"))

  if (search) {
    search.addEventListener("keyup", function(event) {
      var value = event.target.value.toLowerCase()
      var visibility = value.length === 0 ? "" : "none"

      filterable.forEach(function(element) {
        var search = (element.dataset.keywords + " " + element.innerText).toLowerCase()
        if (search.search(value) <= 0)
          element.style.display = visibility
        else
          element.style.display = ""
      })
    })
  }
})(window)
