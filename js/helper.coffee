define ["jquery", "text!templates/errors.html"], ($, errorsHtml) ->
  class Helper
    
    errorsTemplate: $(errorsHtml)

    dealErrors: (showSelector, response, before=true)-> 
      $("#errors").remove()
    
      status = response.status
      switch status
        when 404
          errorsObj = {"errors": "not allowed or resources not exist."}
          directives = {"span": "errors"}
          htmlWithData = this.errorsTemplate.render(errorsObj, directives)
          if before
            $(showSelector).before(htmlWithData)
          else
            $(showSelector).after(htmlWithData)
           
        when 400
          responseText = JSON.parse(response.responseText)
          errorsObj = {"errors": new Array()}
          for key, value of responseText.errors
            for e in value by 1
              errorsObj.errors.push e
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
            
