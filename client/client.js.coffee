
Template.title.name = ->
  "This is a title"

Template.hello.greeting = ->
  "Welcome to the best app in the world."

Template.hello.events
  'keyup input': (e) ->
    console?.log e.keyCode

if (Meteor.isClient)
  Template.snippets.codes = ->
    return Codes.find({}, {sort: {score: -1, name: 1}})
