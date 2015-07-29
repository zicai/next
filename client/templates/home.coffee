Template.home.helpers
  taskListTL: ->
    Task.find({important: true, urgent: true}, {sort: {order: 1, create_time: 1}})
  taskListTR: ->
    Task.find({important: true, urgent: false}, {sort: {order: 1, create_time: 1}})
  taskListBL: ->
    Task.find({important: false, urgent: true}, {sort: {order: 1, create_time: 1}})
  taskListBR: ->
    Task.find({important: false, urgent: false}, {sort: {order: 1, create_time: 1}})

Template.home.events
  'submit .form-create-task': (e)->
    e.preventDefault()
    $form = $(e.currentTarget)

    order = 0
    $taskList = $form.next('.task-list')
    if $taskList.children().length > 0
      order = $taskList.children().first().attr('data-task-order') - 10000

    task =
      name: $form.find('input[name=name]').val()
      create_time: new Date()
      important: false
      urgent: false
      user_id: Meteor.userId()
      order: order
    type = $form.find('input[name=type]').val()

    switch type
      when 'tl'
        task.important = true
        task.urgent = true
      when 'tr' then task.important = true
      when 'bl' then task.urgent = true
    #    console.log task
    Task.insert(task)
    $form.find('input[name=name]').val('')

  'keypress .task-name': (e)->
    $el = $(e.currentTarget)
    taskId = $el.parent().attr('data-task-id')
    if e.keyCode is 13
      taskName = $el.text()
      Task.update({_id: taskId}, {$set: {name: taskName}})
      $el.blur()
      e.preventDefault()

  'click .delete-task': (e)->
    $el = $(e.currentTarget)
    taskId = $el.parent().attr('data-task-id')
    Task.remove({_id: taskId})
    return false


Template.home.onRendered ->
  dragula([document.querySelectorAll('.task-list')])
  drake = dragula({
    delay: true
  })
  $('.task-list').each((index, el)->
    drake.containers.push(el)
  )
  drake.on('drop', (el, container, source)->
    console.log el
    console.log container
    console.log source
    order = Next.caculateOrder(container, el)
    task_id = $(el).attr('data-task-id')
    Task.update({_id: task_id}, {$set: {order: order}})
    ##  更新任务类型
    if $(container) isnt $(source)
      is_important = $(container).attr('data-task-important') is "true"
      is_urgent = $(container).attr('data-task-urgent') is "true"
      Task.update({_id: task_id}, {$set: {important: is_important, urgent: is_urgent}})
  )
