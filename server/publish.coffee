Meteor.publish('tasks', ->
  Task.find({user_id: @userId})
)