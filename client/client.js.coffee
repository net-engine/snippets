
if (Meteor.isClient)
  Template.snippets.codes = ->
    return Codes.find({}, {sort: {score: -1, name: 1}})

  $(document).on('click', '.app-footer button', ->
    Codes.find({}).forEach((element)->
      Codes.remove element._id))

  Template.addCode.events
    'keydown textarea' : (e) ->
      textarea = $('#new-code-post')

      if e.keyCode is 13
        e.preventDefault()
        Codes.insert
          message: textarea.val()
        textarea.val('')

  Template.code.events
    'click .delete' : (e) ->
      e.preventDefault()
      Codes.remove(this._id)