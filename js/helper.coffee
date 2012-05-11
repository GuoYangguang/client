define ["jquery", "text!templates/errors.html"], ($, errorsHtml) ->
  class Helper
    
    dealErrors: (showSelector, response)-> 
      $("#errors").remove()
      $(showSelector).before(errorsHtml)

      status = response.status
      switch status
        when 404
          errorsObj = {"errors": "not allowed or resources not exist."}
          directives = {"span": "errors"}
          $("#errors").render(errorsObj, directives)
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
          $("#errors").render(errorsObj, directives)
