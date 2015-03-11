Polymer 'grapp-graph-epoch',

  created: ->
    @axis = []

  ready: ->
    @data = (@createData(s) for s in @querySelectorAll 'grapp-graph-epoch-series')
    @draw()

  createData: (series) ->
    { label: series.label, values: series.data }

  axisChanged: ->
    @draw()

  draw: ->
    @$.graph.innerHTML = ''
    options =
      el: @$.graph
      data: @data
      axes: @axis
    @graph = new Epoch._typeMap[@type] options
    @graph.draw()

  push: (time, value) ->
    @graph.push [{time: time, y: value}]
