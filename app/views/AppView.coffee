class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="deal-button">Deal Another</button>
    <h2 class="message"></h2>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .deal-button": ->
      @$el.find('.stand-button, .hit-button').show()
      @model.newgame()
      @render()

  initialize: ->
    @render()
    @newgame()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  newgame: ->
    @model.on 'newgame', => 
      @newgame()
      @render
    @model.get('playerHand').on 'bust', =>
      @$('.message').text('You busted!')
      @$el.find('.stand-button, .hit-button').hide()
    @model.on 'checkScore', =>
      @$('.message').text('You busted!')
      @$el.find('.stand-button, .hit-button').hide()
      @$('.message').text(@model.get('outcome'))