
if (Meteor.isClient)

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


  Template.avatar.events
    'click #user-avatar': (e) ->
      e.preventDefault()
      $('#image-upload').click()

    'change input': (e) ->
      console.log e.srcElement

      _.each e.srcElement.files, (file) ->
        localStorage.setItem('avatar', file.name)
        setAvatar(file.name)
        Meteor.saveFile(file, file.name)

  Template.snippets.rendered = ->
    prettyPrint()
    scrollToBottom()

    if localStorage.getItem('avatar')
      setAvatar(localStorage.getItem('avatar'))

  Template.code.rendered = ->
    prettyPrint()
    scrollToBottom()



# Private

scrollToBottom = ->
  $('.container').scrollTop( $('.snippets').height() )

setAvatar = (filename)->
  pos = $('#login-buttons').position()
  $('#user-avatar').removeClass('user-avatar-upload').html("<img src='" + filename + "'> upload new image")


