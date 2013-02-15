
if (Meteor.isClient)
  Template.snippets.codes = ->
    return Codes.find({}, {sort: {score: -1, name: 1}})

  $(document).on('click', '.app-footer button', ->
    Codes.find({}).forEach((element)->
      Codes.remove element._id))
