
Template.title.name = ->
  "This is a title"

Template.hello.greeting = ->
  "Welcome to the best app in the world."

Template.hello.events
  'keyup input': (e) ->
    console?.log e.keyCode
