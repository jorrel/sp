
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



var focusOnFirstFormElement = function() {
  var scope = $('content') || document.body;
  var forms = scope.getElementsBySelector('form');
  if(forms.any()) {
    var fieldsWithError = forms[0].getElementsBySelector('span.field-with-errors input[type=text]');
    if(fieldsWithError.length > 0)
      fieldsWithError[0].select();
    else {
      var fields = forms[0].getElementsBySelector('input[type=text]');
      if(fields.any()) fields[0].select();
    }
  }
}
focusOnFirstFormElement.runOnLoad();
