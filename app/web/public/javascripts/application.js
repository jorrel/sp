
Object.extend(Function.prototype, {
  /**
   * The function will be ran on document load
   *
   * ex:
   *   greeting = function() { alert('hi!'); };
   *   greeting.runOnLoad();
   * or: (parenthesis required)
   *   (function() { alert('hey'); }).runOnLoad();
   * or:
   *   Function("alert('yo');").runOnLoad();
   */
  runOnLoad: function() {
    Event.observe(document, 'dom:loaded', this);
  }
});


