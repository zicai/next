Meteor.startup(->
  if Task.find().count() is 0
    Task.insert
      name: "晚上和妹子去吃饭"
      important: true
      urgent: true
    Task.insert
      name: "翻译Meteor文档"
      important: true
      urgent: false
    Task.insert
      name: "看完《悲伤与理智》"
      important: false
      urgent: false
    Task.insert
      name: "给手机充话费"
      important: false
      urgent: true
)