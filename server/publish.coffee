Meteor.publish('tasks', ->
  Task.find()
)