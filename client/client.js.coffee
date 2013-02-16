
scrollToBottom = ->
  $('.container').scrollTop( $('.snippets').height() )

if (Meteor.isClient)

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

  Template.newSnippet.events
    'keydown textarea' : (e) ->
      now = new Date()
      textarea = $('#new-code-post')
      select = $('#new-snippet-language')

      if e.keyCode is 13
        e.preventDefault()
        
        Codes.insert
          message: textarea.val()
          lang: select.val()

        textarea.val('')
        select.val('Guess')
    
    'keyup textarea' : (e) ->
      scrollToBottom()

  Template.code.events
    'click .delete' : (e) ->
      e.preventDefault()
      Codes.remove(this._id)