#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @newgame()
    @set 'count',0
    return

  stand: ->
    @get('dealerHand').models[0].flip()
    @get('dealerHand').dealergo()

  checkScore: ->
    @set 'count' , @get('dealerHand').handcount()+ @get('count')
    @set 'count' , @get('playerHand').handcount()+ @get('count')
    console.log(@get('count'))
    if @get('playerHand').currentscore() > 21
      @set 'outcome', 'Busted Bigtime Yea...'
      @trigger ('checkScore')
    else if @get('dealerHand').currentscore() > 21
      @set 'outcome', 'Dealer Busts! YOU Sir are the winner!'
      @trigger('checkScore')
    else if @get('playerHand').currentscore() > @get('dealerHand').currentscore()
      @set 'outcome', "You win!"
      @trigger ('checkScore')
    else if @get('playerHand').currentscore() < @get('dealerHand').currentscore()
      @set 'outcome', "You lose, haha!"
      @trigger ('checkScore')
    else
      @set 'outcome', "You tie!"
      @trigger ('checkScore')

  checkCount: ->
    console.log(@get 'count')
    countguess = prompt ("what's the count?")
    console.log(countguess,@get('count').toString())
    console.log(countguess.toString() == @get('count'.toString()))
    if (countguess!= @get('count'.toString()))
      alert('wrong the count is actually '+ @get 'count')
    else
      alert('You got it right... Impressive.')



  newgame: ->
    console.log(@get('deck').length)
    if @get('deck').length < 25
      @checkCount()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'stand', => @stand()
    @get('playerHand').on 'checkScore', => @checkScore()
    @get('dealerHand').on 'checkScore', => @checkScore()
    @get('dealerHand').on 'checkCount', => @checkCount()
    @get('dealerHand').on 'checkCount', => @checkCount()
    @trigger 'newgame'