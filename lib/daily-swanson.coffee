DailySwansonView = require './daily-swanson-view'
{CompositeDisposable} = require 'atom'

module.exports = DailySwanson =
  dailySwansonView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @dailySwansonView = new DailySwansonView(state.dailySwansonViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @dailySwansonView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'daily-swanson:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dailySwansonView.destroy()

  serialize: ->
    dailySwansonViewState: @dailySwansonView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @dailySwansonView.getQuote(@dailySwansonView.getMessage())
      @modalPanel.show()
