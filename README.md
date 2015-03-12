grapp-graph-epoch
=================

A web component that displays [Epoch graphs](https://github.com/fastly/epoch).


Attributes
----------

* **type**

  - *type:* (time.)? area|bar|gauge|heatmap|line
  - *default:* undefined

  Specify the Epoch graph type.

* **axis**

  - *type:* (left|bottom|right|top)*
  - *default:* left,buttom

  Specify which axes should be printed.

* **theme**

  - *type:* default|dark
  - *default:* default

  Select one of the two Epoch CSS themes.

* **width**

  - *type:* Width in pixel
  - *default:* Automatically calculated

  Defines the graph width.

* **height**

  - *type:* Height in pixel
  - *default:* Automatically calculated

  Defines the graph height.


Methods
-------

* **push(time, value)**

  Push a new value into a data series.

* **clear()**

  Clear a time series graph.


grapp-graph-epoch-series
========================

Defines a single data series inside an grapp-graph-epoch.

Attributes
----------

* **label**

  - *type:* String
  - *default:* ''

  The series label

* **data**

  - *type:* Array of {x:, y:} pairs
  - *default:* undefined
