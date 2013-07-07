class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
        ten: switch 
                when card % 13 == 1
                  true
                when card % 13 <10
                  false
                when card % 13 > 9
                  true


  dealPlayer: -> hand = new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
