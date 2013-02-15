if Meteor.isClient

  Template.title.name = ->
    'This is a title'

  Template.hello.greeting = ->
    "Welcome to the best app in the world."

  Template.hello.events
    'keydown input': ->
      console?.log "You pressed the button"
