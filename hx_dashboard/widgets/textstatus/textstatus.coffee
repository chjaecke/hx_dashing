class Dashing.Textstatus extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  @accessor 'bckicon', ->
    statut = @get 'status'
    if statut == true
      return "fa fa-check-circle-o icon-background"    
    else
      if statut == null
        return "fa fa-info-circle icon-background"
      else
        return "fa fa-times-circle-o icon-background"

  onData: (data) ->
    @set 'text', data.value
    node = $(@node)
    statusbool = @get 'status'
    backgroundClass = 'state-' + statusbool
    if @get 'lastClass'
      lastClassVar = @get('lastClass')
      node.toggleClass lastClassVar + ' ' + backgroundClass
      @set 'lastClass', backgroundClass
    else 
      @set 'lastClass', backgroundClass
      node.addClass backgroundClass