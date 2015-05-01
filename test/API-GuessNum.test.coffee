Chrome_Js_Mocha = require('../src/Chrome_Js_Mocha')
GuessNum        = require('../src/API-GuessNum')

describe '| API-GuessNum |', ->
  page        = Chrome_Js_Mocha.create(before,after)
  guessNum    = new GuessNum { page: page }

  it 'home', (done)->
    guessNum.home done

  it 'page_1', (done)->
    guessNum.page_1 done

  it 'page_2', (done)->
    guessNum.page_2 done

  it 'page_3', (done)->
    guessNum.page_3 done

  it 'set_Name', (done)->
    guessNum.set_Name 'aaa', done

  it 'guess', (done)->
    guessNum.guess '123', done

  it 'multiple_guess', (done)->
    @timeout 5000
    guessNum.guess '123', ->
      guessNum.guess '122', ->
        guessNum.guess '222', -> done()
