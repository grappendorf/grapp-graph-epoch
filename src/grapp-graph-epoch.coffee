convertStringToArray = (s) ->
  (parseInt(n) for n in s.split ',')

convertStringToObject = (s) ->
  o = {}
  for kv in (part.split ':' for part in s.split ',')
    o[kv[0]] = parseInt(kv[1])
  o


Polymer 'grapp-graph-epoch',

  created: ->
    @axis = []
    @theme = 'default'
    @category ='category10'

  domReady: ->
    for s in @querySelectorAll 'grapp-graph-epoch-series'
      (new PathObserver s, 'data').open (->
        @createGraph()).bind @
    @createGraph()

  createGraph: ->
    @data = ({ label: s.label, values: s.data } for s in @querySelectorAll 'grapp-graph-epoch-series')
    @draw()

  axisChanged: ->
    if @graph
      @graph.option 'axis', @axis

  draw: ->
    @$.graph.innerHTML = ''
    console.log convertStringToObject @margins if @margins
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
    @graph = new Epoch._typeMap[@type] options
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
