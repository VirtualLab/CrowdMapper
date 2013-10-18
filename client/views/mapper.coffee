# The map needs to load first or openlayers complains
@Mapper = @Mapper || {}

Mapper.switchTab = (page) ->
  return unless page is "docs" or page is "events" or page is "map"
  $("a[data-target='#{page}']").trigger("click")
  # TODO why is this necessary? Should not be since the above should trigger it.
  Session.set("taskView", page)

Meteor.startup ->
  Session.set("taskView", 'events')

  Session.set("scrollEvent", null)
  Session.set("scrollTweet", null)

Template.pageNav.events =
  "click a": (e) -> e.preventDefault()

  "click a[data-target='docs']": ->
    Session.set("taskView", 'docs')
  "click a[data-target='events']": ->
    Session.set('taskView', 'events')
  "click a[data-target='map']": ->
    Session.set('taskView', 'map')

Template.mapper.rendered = ->
  # Set initial active tab when rendered
  tab = Session.get('taskView')
  return unless tab?
  $('#mapper-'+tab).addClass('active')

# Do the stack with jQuery to avoid slow reloads
Deps.autorun ->
  tab = Session.get('taskView')
  return unless tab?
  $('.stack .pages').removeClass('active')
  $('#mapper-'+tab).addClass('active')
