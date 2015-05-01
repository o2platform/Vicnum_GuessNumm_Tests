require 'fluentnode'
cheerio = require 'cheerio'

class API_GuessNum

  constructor: (options)->
    @.options    = options || {}
    @.page       = @.options.page
    @.wait_Value = 100


  home: (callback)=>
    @.page.chrome.open 'http://vicnum.ciphertechs.com/guessnum.html', callback

  page_1: (callback)=>
    @.page.chrome.open 'http://vicnum.ciphertechs.com/cgi-bin/guessnum1.pl', callback

  page_2: (callback)=>
    @.page.chrome.open 'http://vicnum.ciphertechs.com/cgi-bin/guessnum2.pl', callback

  page_3: (callback)=>
    @.page.chrome.open 'http://vicnum.ciphertechs.com/cgi-bin/guessnum3.pl', callback

  set_Name: (value ,callback)=>
    @.home =>
      code ="document.documentElement.querySelector('input[name=player]').value = '#{value}';"
      @.page.chrome.eval_Script code, =>
        @.wait_Value.wait =>
          @.submit_Form "g", callback

  guess: (value ,callback)=>
    @.page_1 =>
      code ="document.documentElement.querySelector('input[name=userguess]').value = '#{value}';"
      @.page.chrome.eval_Script code, =>
        @.wait_Value.wait =>
          @.submit_Form "F", callback

  submit_Form: (name,callback)=>
    code ="document.forms.#{name}.submit();"
    @.page.chrome.eval_Script code, =>
      @.page.wait_For_Complete =>
        callback()

module.exports = API_GuessNum