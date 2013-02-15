
if (Meteor.isClient)
  Template.snippets.codes = ->
    return Codes.find({}, {sort: {score: -1, name: 1}})
