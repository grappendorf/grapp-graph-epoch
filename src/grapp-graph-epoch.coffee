Polymer

  is: 'grapp-graph-epoch'

  properties:
    type: {type: String}
    axis: {type: String, observer: '_axisChanged'}
    theme: {type: String, value: 'default'}
    category: {type: String, value: 'category10'}
    width: {type: Number}
    height: {type: Number}
    ticks: {type: String}
    tickSize: {type: Number}
    tickOffset: {type: Number}
    windowSize: {type: Number}
    historySize: {type: Number}
    queueSize: {type: Number}
    margins: {type: String}
    domain: {type: String}
    range: {type: String}

  attached: ->
# TODO: Observe changes to series data
#    for s in Polymer.dom(@).querySelectorAll 'grapp-graph-epoch-series'
#      (new PathObserver s, 'data').open (->
#        @_createGraph()).bind @
    @_createGraph() if @type

  draw: ->
    @$.graph.innerHTML = ''
    options =
      el: @$.graph
      data: @data
      axes: @axis
      width: @width
      height: @height
      ticks: convertStringToObject @ticks if @ticks
      tickSize: @tickSize
      tickOffset: @tickOffset
      windowSize: @windowSize
      historySize: @historySize
      queueSize: @queueSize
      margins: convertStringToObject @margins if @margins
      domain: convertStringToArray @domain if @domain?
      range: convertStringToArray @range if @range?
    @graph = new Epoch._typeMap[@type](options)
    @graph.draw()

  push: (args...) ->
    if typeof(args[0]) == 'number'
      @graph.push [{time: args[0], y: args[1]}]
    else
      @graph.push ({time: d[0], y: d[1]} for d in args)

  clear: ->
    for series in @data
      series.values = [time: 0, y: 0]
    @draw()

  _createGraph: ->
    @data = ({ label: s.label, values: s.data } for s in Polymer.dom(@).querySelectorAll 'grapp-graph-epoch-series')
    @draw()

  _axisChanged: ->
    if @graph
      @graph.option 'axis', @axis

  _convertStringToArray: (s) ->
    (parseInt(n) for n in s.split ',')

  _convertStringToObject: (s) ->
    o = {}
    for kv in (part.split ':' for part in s.split ',')
      o[kv[0]] = parseInt(kv[1])
    o

  _epochThemeClass: (theme) ->
    "epoch-theme-#{theme}"

  _epochGraphClass: (category) ->
    "epoch #{category}"
