kd                  = require 'kd'
KDButtonView        = kd.ButtonView
KDCustomHTMLView    = kd.CustomHTMLView
KDHitEnterInputView = kd.HitEnterInputView
KDMultipleChoice    = kd.MultipleChoice
JView               = require 'app/jview'
_                   = require 'lodash'
keycode             = require 'keycode'

module.exports = class AceFindAndReplaceView extends JView

  constructor: (options = {}, data) ->

    options.cssClass = 'ace-find-replace-view'

    super options, data

    @mode             = null
    @lastViewHeight   = 0

    @findInput = new KDHitEnterInputView
      type         : 'text'
      placeholder  : 'Find...'
      validate     :
        rules      :
          required : yes
      keydown      : _.bind @handleKeyDown, this, yes
      callback     : => @findNext()

    @findNextButton = new KDButtonView
      cssClass     : 'editor-button'
      title        : 'Find Next'
      callback     : => @findNext()

    @findPrevButton = new KDButtonView
      cssClass     : 'editor-button'
      title        : 'Find Prev'
      callback     : => @findPrev()

    @replaceInput = new KDHitEnterInputView
      type         : 'text'
      cssClass     : 'ace-replace-input'
      placeholder  : 'Replace...'
      validate     :
        rules      :
          required : yes
      keydown      : _.bind @handleKeyDown, this, no
      callback     : => @replace()

    @replaceButton = new KDButtonView
      title        : 'Replace'
      cssClass     : 'ace-replace-button'
      callback     : => @replace()

    @replaceAllButton = new KDButtonView
      title        : 'Replace All'
      cssClass     : 'ace-replace-button'
      callback     : => @replaceAll()

    @closeButton = new KDCustomHTMLView
      tagName      : 'span'
      cssClass     : 'close-icon'
      click        : => @close()

    @choices = new KDMultipleChoice
      cssClass     : 'clean-gray editor-button control-button'
      labels       : ['case-sensitive', 'whole-word', 'regex']
      multiple     : yes
      defaultValue : 'fakeValueToDeselectFirstOne'


  handleKeyDown: (isFind, e) ->

    code = e.which or e.keyCode
    key  = keycode code

    switch key
      when 'esc' then @close()
      when 'enter'
        @findPrev()  if isFind and e.shiftKey is yes
      when 'f'
        if e.metaKey
          e.preventDefault()
          @setViewHeight e.shiftKey is yes
    return


  close: (fireEvent = yes) ->
    @hide()
    @resizeEditor 0
    @findInput.setValue    ""
    @replaceInput.setValue ""
    @emit 'FindAndReplaceViewClosed'  if fireEvent

  setViewHeight: (isReplaceMode) ->
    height   = 31
    @mode    = 'find'
    if isReplaceMode
      height = 60
      @mode  = 'replace'

    @$().css { height }
    @resizeEditor height

    for widget in [@replaceInput, @replaceButton, @replaceAllButton]
      if isReplaceMode then widget.show() else widget.hide()

    @show()


  resizeEditor: (height) ->
    if @getDelegate()?.ace?
      {ace} = @getDelegate()
      return unless ace.editor

      ace.setHeight ace.getHeight() + @lastHeightTakenFromAce - height
      ace.editor.resize yes
      @lastHeightTakenFromAce = height

  lastHeightTakenFromAce: 0

  setTextIntoFindInput: (text) ->
    return @findInput.setFocus() if text.indexOf("\n") > 0 or text.length is 0
    @findInput.setValue text
    @findInput.setFocus()

  getSearchOptions: ->
    @selections   = @choices.getValue()

    caseSensitive : @selections.indexOf('case-sensitive') > -1
    wholeWord     : @selections.indexOf('whole-word') > -1
    regExp        : @selections.indexOf('regex') > -1
    backwards     : no

  findNext: -> @findHelper 'next'

  findPrev: -> @findHelper 'prev'

  findHelper: (direction) ->
    keyword = @findInput.getValue()
    return unless keyword
    methodName = if direction is 'prev' then 'findPrevious' else 'find'
    @getDelegate().ace.editor[methodName] @findInput.getValue(), @getSearchOptions()
    @findInput.focus()

  replace:    -> @replaceHelper no

  replaceAll: -> @replaceHelper yes

  replaceHelper: (doReplaceAll) ->
    findKeyword    = @findInput.getValue()
    replaceKeyword = @replaceInput.getValue()
    return unless findKeyword or replaceKeyword

    {editor}   = @getDelegate().ace
    methodName = if doReplaceAll then 'replaceAll' else 'replace'

    editor[methodName] replaceKeyword
    @findNext()

  pistachio: ->
    """
      <div class="ace-find-replace-settings">
        {{> @choices}}
      </div>
      <div class="ace-find-replace-inputs">
        {{> @findInput}}
        {{> @replaceInput}}
      </div>
      <div class="ace-find-replace-buttons">
        {{> @findNextButton}}
        {{> @findPrevButton}}
        {{> @replaceButton}}
        {{> @replaceAllButton}}
      </div>
      {{> @closeButton}}
    """
