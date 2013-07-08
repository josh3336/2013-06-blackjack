class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->

    @add _(_.range(1, 105)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
        cardcount: switch 
                when card % 13 == 1
                  -1
                when card % 13 == 0
                  -1
                when card % 13 == 7
                  0
                when card % 13 == 8
                  0
                when card % 13 == 9
                  0
                when card % 13 <7
                  1
                when card % 13 > 9
                  -1

  dealPlayer: -> hand = new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
