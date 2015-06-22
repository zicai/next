Template.home.helpers
  taskListTL: ->
    Task.find({important: true, urgent: true})
  taskListTR: ->
    Task.find({important: true, urgent: false})
  taskListBL: ->
    Task.find({important: false, urgent: true})
  taskListBR: ->
    Task.find({important: false, urgent: false})