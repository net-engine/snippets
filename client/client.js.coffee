
scrollToBottom = ->
  $('.container').scrollTop( $('.snippets').height() )

if (Meteor.isClient)
  window.setTimeout (->
    
    
  ), 500

  Template.snippets.rendered = ->
    prettyPrint()
    scrollToBottom()

  Template.code.rendered = ->
    prettyPrint()
    scrollToBottom()

  Template.snippets.codes = ->
    Codes.find()

  $(document).on('click', '.app-footer button', ->
    Codes.find({}).forEach((element)->
      Codes.remove element._id))

  Template.addCode.events
    'keydown textarea' : (e) ->
      now = new Date()
      time = now.getHours() + ':' + (now.getMinutes() + 1)
      textarea = $('#new-code-post')

      if e.keyCode is 13
        e.preventDefault()
        
        Codes.insert
          message: textarea.val()
          time: time
        textarea.val('')
    
    'keyup textarea' : (e) ->
      scrollToBottom()

  Template.code.events
    'click .delete' : (e) ->
      e.preventDefault()
      Codes.remove(this._id)