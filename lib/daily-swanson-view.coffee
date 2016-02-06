http = require 'http'

module.exports =
class DailySwansonView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('daily-swanson')

    # Create Image
    img = document.createElement('img')
    img.classList.add('img')
    img.src = 'http://actionflickchick.com/superaction/wp-content/uploads/2014/09/b99165123z.1_20131217190755_000_gib401il.1-1.jpg'
    @element.appendChild(img)

    # Create Caption
    @message = document.createElement('div')
    @message.classList.add('quote')
    @element.appendChild(@message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getMessage: ->
    @message

  getQuote: (message) ->
    options =
      host: 'ron-swanson-quotes.herokuapp.com'
      method: 'GET'
      port: 80
      path: '/v2/quotes'

    http.get options, (res) ->
      str = ''
      res.on 'data', (chunk) ->
        str += chunk.toString()
      res.on 'end', () ->
        # Create message element
        message.textContent = "\"" + JSON.parse(str)[0] + "\""
