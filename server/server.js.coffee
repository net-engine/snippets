if (Meteor.isServer)
  Meteor.startup ->
    if (Codes.find().count() == 0)
      messages = ["MyRubycode",
        "Javascript",
        "Node",
        ]
      for message in messages
        Codes.insert
          message: message

