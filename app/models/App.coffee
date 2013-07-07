#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'outcome', false
    @set 'deck', deck = new Deck()
    @set 'count', 0
    @newgame()
    return

  stand: ->
    @get('dealerHand').models[0].flip()
    @get('dealerHand').dealergo()

  checkScore: ->
    console.log(@get 'deck')
    if @get('dealerHand').scores()[0] > 21
      @set 'outcome', 'Dealer Busts! YOU Sir are the winner!'
      @trigger('checkScore')
    else if @get('playerHand').scores()[0] > @get('dealerHand').scores()[0]
      @set 'outcome', "You win!"
      @trigger ('checkScore')
    else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] 
      @set 'outcome', "You lose, haha!"
      @trigger ('checkScore')
    else
      @set 'outcome', "You tie!"
      @trigger ('checkScore')

  checkCount: ->


  newgame: ->
    console.log('newgame')
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'stand', => @stand()
    @get('dealerHand').on 'checkScore', => @checkScore()
    @get('dealerHand').on 'checkCount', => @checkCount()
    @get('dealerHand').on 'checkCount', => @checkCount()


    @trigger 'newgame'