Polymer 'grapp-graph-epoch',

  created: ->
    @axis = []
    @theme = 'default'

  ready: ->
    @data = (@createData(s) for s in @querySelectorAll 'grapp-graph-epoch-series')
    @draw()

  createData: (series) ->
    { label: series.label, values: series.data }

  axisChanged: ->
    @graph.option 'axis', @axis

  draw: ->
    @$.graph.innerHTML = ''
    options =
      el: @$.graph
      data: @data
      axes: @axis
    @graph = new Epoch._typeMap[@type] options
    @graph.draw()

  push: (args...) ->
    # if typeof(args[0]) == 'number'
      # @graph.push [{time: args[0], y: args[1]}]
    # else
      # @graph.push ({time: d[0], y: d[1]} for d in args[0])
