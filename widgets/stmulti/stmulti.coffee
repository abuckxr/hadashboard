
class Dashing.Stmulti extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> @_state ? "Unknown"
    set: (key, value) -> @_state = value
    
  @accessor 'temp',
    get: -> if @_value then Math.floor(@_value) else 0
    set: (key, value) -> @_value = value

  @accessor 'icon',
    get: -> if @get('state') == 'open' then 'expand' else 'compress'
    set: Batman.Property.defaultAccessor.set

  @accessor 'icon-style', ->
    if @get('state') == 'open' then 'icon-open' else 'icon-closed'

  queryState: ->
    $.get '/smartthings/dispatch',
      widgetId: @get('id'),
      deviceType: 'contact',
      deviceId: @get('device')
      (data) =>
        json = JSON.parse data
        @set 'state', json.state

    $.get '/smartthings/dispatch',
      widgetId: @get('id'),
      deviceType: 'temperature',
      deviceId: @get('device')
      (data) =>
        json = JSON.parse data
        @set 'temp', json.value
        
  ready: ->

  onData: (data) ->
