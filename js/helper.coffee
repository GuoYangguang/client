define ["jquery", "text!templates/errors.html"], ($, errorsHtml) ->
  class Helper
    
    errorsTemplate: $(errorsHtml)

    dealErrors: (showSelector, errorsId, response)-> 
      this.errorsTemplate.attr('id', errorsId)
      status = response.status
      switch status
        when 401
          window.Clienting.router.navigate '/login', {trigger: true} 
        
        when 403
          errorsObj = {"errors": "Not Allowed."}
          directives = {"span": "errors"}
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          $(showSelector).before(htmlWithData)

        when 404
          errorsObj = {"errors": "Resources not exist."}
          directives = {"span": "errors"}
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          $(showSelector).before(htmlWithData)
           
        when 400
          responseText = JSON.parse(response.responseText)
          errorsObj = {"errors": responseText.errors}
          directives = {
            "li": {
              "error<-errors": {
                "span": "error"
              }
            }
          }
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          $(showSelector).before(htmlWithData)
            
