if (Meteor.isServer)

  Meteor.startup ->
    query   = Codes.find({})
    handle  = query.observe(
      added: (code) ->
        now = new Date()
        time = now.getHours() + ':' + (now.getMinutes() + 1)
        Codes.update(code._id, time: time, message: code.message)
    )

    if (Codes.find().count() == 0)
      messages = ["MyRubycode",
        "Javascript",
        "Node",
        ]
      for message in messages
        Codes.insert
          message: message
