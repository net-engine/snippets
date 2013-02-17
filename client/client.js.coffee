
if (Meteor.isClient)

  Template.avatar.avatar = ->
    Avatars.findOne({ user_id: Meteor.userId() })

  Template.snippets.codes = ->
    Codes.find()

  Template.code.currentUserEmail = ->
    Meteor.user().emails[0].address

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
          author: Meteor.user().emails[0].address

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
      startVideo()

    'click .delete': (e) ->
      $('#video-box').hide()

    'click #startbutton': (e) ->
      e.preventDefault()
      takePicture()
      
    # 'change input': (e) ->
    #   console.log e.srcElement

    #   _.each e.srcElement.files, (file) ->
    #     localStorage.setItem('avatar', file.name)
    #     setAvatar(file.name)
    #     Meteor.saveFile(file, file.name)


  Template.code.rendered = ->
    prettyPrint()
    scrollToBottom()


# Private

scrollToBottom = ->
  $('.container').scrollTop( $('.snippets').height() )

setAvatar = (filename)->
  pos = $('#login-buttons').position()
  


takePicture = ->
  video = document.querySelector('#video')
  canvas = document.querySelector('#canvas')
  photo = document.querySelector('#photo')
  width = 400
  height = 400

  canvas.width = width
  canvas.height = height
  canvas.getContext('2d').drawImage(video, 0, 0, width, height)
  data = canvas.toDataURL('image/png')
  photo.setAttribute('src', data)

  $('#user-avatar img').attr('src', data)
  
  if Avatars.find({user_id: Meteor.userId()}).fetch().length is 0
    Avatars.insert
      image: data
      user_id: Meteor.userId()
      created_at: new Date()
      updated_at: new Date()
  else
    Avatars.update
      user_id: Meteor.userId()
    ,
      image: data
      updated_at: new Date()


