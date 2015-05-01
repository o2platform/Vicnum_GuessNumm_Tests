require 'fluentnode'
cheerio = require 'cheerio'

xdescribe 'Browser Automation Tests', ->
  page        = require('../src/Chrome_Js_Mocha').create(before,after)


  open_home_page = (callback)->
    page.chrome.open 'http://vicnum.ciphertechs.com', ->
      page.wait_For_Complete ->
        callback()

  click_on_second_link =  (callback)->
    code = "document.getElementsByTagName('a')[1].click()"
    page.chrome.eval_Script code
    page.wait_For_Complete ->
      callback()

  set_name = (name, callback)->
    code ="document.documentElement.querySelector('input[name=player]').value = '#{name}';
           document.forms.g.submit();"
    page.chrome.eval_Script code
    page.wait_For_Complete ->
      callback()

  xit 'open vicnum', (done)->
    page.chrome.open 'http://vicnum.ciphertechs.com', ()->
      page.html (html)->
        $ = cheerio.load(html)
        $('a').each (index, anchor)->
          log $(anchor).attr()
        done()

  it 'open home page', (done)->
    open_home_page ->
        done()

  xit 'Set name', (done)->
      click_on_second_link ->
        name = 'aaa'.add_5_Random_Letters()
        set_name name, ->
          page.html (html, $)->
            $($('h2')[0]).html().assert_Contains name
          done()

  it 'xss name', (done)->
      click_on_second_link ->
        name = 'aaa <img src=aaaa onerror=alert("42") >'
        set_name name, ->
          page.html (html, $)->
            $($('h2')[0]).html().assert_Contains name
          done()

  xit 'find_name', (done)->
    page.html (html, $)->
      log $($('h2')[0]).html()
      done()

  #xit 'abc', (done)->
#
  #  page.chrome.open "http://vicnum.ciphertechs.com",()->
  #    page.html (html,$)->
  #      console.log $('ssssss').html()
  #      done()
#

