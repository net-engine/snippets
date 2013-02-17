if (Meteor.isServer)

  Meteor.startup ->
    query   = Codes.find({})
    handle  = query.observe(
      added: (code) ->
        now = new Date()
        time = pad(now.getHours(), 2) + ':' + pad(now.getMinutes(), 2)
        Codes.update(code._id, time: time, message: code.message, author: code.author, lang: code.lang)
    )

    if (Codes.find().count() == 0)
      messages = ["MyRubycode",
        "Javascript",
        "Node",
        ]
      for message in messages
        Codes.insert
          message: message


# Private

pad = (number, length) ->
  str = "" + number
  str = "0" + str  while str.length < length
  str