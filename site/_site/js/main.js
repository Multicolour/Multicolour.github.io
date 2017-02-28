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
})(window)
