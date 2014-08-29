class NavigationMachineItem extends JView

  {Running, Stopped} = Machine.State

  stateClasses  = ''
  stateClasses += "#{state.toLowerCase()} " for state in Object.keys Machine.State


  constructor:(options = {}, data)->

    machine            = data
    @alias             = machine.label
    path               = KD.utils.groupifyLink "/IDE/VM/#{machine.uid}"

    options.tagName    = 'a'
    options.cssClass   = "vm #{machine.status.state.toLowerCase()} #{machine.provider}"
    options.attributes =
      href             : path
      title            : "Open IDE for #{@alias}"

    super options, data

    @machine   = @getData()

    @label     = new KDCustomHTMLView
      partial  : @alias

    @progress  = new KDProgressBarView
      cssClass : 'hidden'

    {computeController} = KD.singletons
    computeController.on "public-#{@machine._id}", @bound 'handleMachineEvent'


  handleMachineEvent: (event) ->

    {percentage, status} = event

    switch status
      when Machine.State.Terminated then @destroy()
      else @setState status

    @updateProgressBar percentage


  setState: (state) ->

    return  unless state

    @unsetClass stateClasses
    @setClass status.toLowerCase()


  updateProgressBar: (percentage) ->

    return @progress.hide()  unless percentage

    @progress.show()
    @progress.updateBar percentage

    if percentage is 100
      KD.utils.wait 1000, @progress.bound 'hide'


  pistachio:->

    return """
      <figure></figure>
      {{> @label}}
      <span></span>
      {{> @progress}}
    """
