require 'fluentnode'
cheerio = require 'cheerio'

describe 'Vicnum QA Tests', ->
  page        = require('../src/Chrome_Js_Mocha').create(before,after)

  it 'Check home page links', (done)->
    page.chrome.open 'http://vicnum.ciphertechs.com', ->

      page.html (html, $)->
        links = $('a')
        #log links.length
        checklink = (index, href)->
          $(links[index]).attr().assert_Is { href: href }

        values =  ['http://www.owasp.org',  'guessnum.html' , 'jotto.html',
                   'union.html', 'http://cyclone.ciphertechs.com/cyclone']

        for value, index in values
          checklink index, value

        done()


