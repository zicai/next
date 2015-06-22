Template.home.helpers
  taskListTL: ->
    Task.find({important: true, urgent: true})
  taskListTR: ->
    Task.find({important: true, urgent: false})
  taskListBL: ->
    Task.find({important: false, urgent: true})
  taskListBR: ->
    Task.find({important: false, urgent: false})

Template.home.events
  'submit .form-create-task': (e)->
    e.preventDefault()
    $form = $(e.currentTarget)
    task =
      name: $form.find('input[name=name]').val()
      create_time: new Date()
      important: false
      urgent: false
    type = $form.find('input[name=type]').val()

    switch type
      when 'tl'
        task.important = true
        task.urgent = true
      when 'tr' then task.important = true
      when 'bl' then task.urgent = true
    Task.insert(task)
    $form.find('input[name=name]').val('')