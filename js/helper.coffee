define ["jquery", "text!templates/errors.html"], ($, errorsHtml) ->
  class Helper
    
    errorsTemplate: $(errorsHtml)

    dealErrors: (showSelector, response, before=true)-> 

      status = response.status
      switch status
        when 401
          window.router.navigate '/login', {trigger: true} 
        
        when 403
          errorsObj = {"errors": "Not Allowed."}
          directives = {"span": "errors"}
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          if before
            $(showSelector).before(htmlWithData)
          else
            $(showSelector).after(htmlWithData)

        when 404
          errorsObj = {"errors": "Resources not exist."}
          directives = {"span": "errors"}
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          if before
            $(showSelector).before(htmlWithData)
          else
            $(showSelector).after(htmlWithData)
           
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
          if before
            $(showSelector).before(htmlWithData)
          else
            $(showSelector).after(htmlWithData)
            
