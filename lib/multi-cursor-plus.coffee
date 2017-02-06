{CompositeDisposable} = require 'atom'


module.exports =
  subscriptions: null
  
  #
  # Activate the package.
  #
  activate: ->
    @subscriptions = new CompositeDisposable
    
    # Add commands
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:mark': =>
        @mark()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-up': =>
        @moveUp()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-down': =>
        @moveDown()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-left': =>
        @moveLeft()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-right': =>
        @moveRight()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-beginning-of-word': =>
        @moveToBeginningOfWord()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-end-of-word': =>
        @moveToEndOfWord()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-first-character-of-line': =>
        @moveToFirstCharacterOfLine()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-end-of-line': =>
        @moveToEndOfLine()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-top': =>
        @moveToTop()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:move-to-bottom': =>
        @moveToBottom()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-up': =>
        @selectUp()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-down': =>
        @selectDown()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-left': =>
        @selectLeft()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-right': =>
        @selectRight()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-beginning-of-word': =>
        @selectToBeginningOfWord()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-end-of-word': =>
        @selectToEndOfWord()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-first-character-of-line': =>
        @selectToFirstCharacterOfLine()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-end-of-line': =>
        @selectToEndOfLine()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-top': =>
        @selectToTop()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'multi-cursor-plus:select-to-bottom': =>
        @selectToBottom()
  
  
  #
  # Deactivate the package.
  #
  deactivate: ->
    @subscriptions.dispose()
  
  
  #
  # Get the last cursor.
  #
  getCursor: ->
    atom.workspace.getActiveTextEditor()?.getLastCursor()
  
  
  #
  # Get the last selection.
  #
  getSelection: ->
    atom.workspace.getActiveTextEditor()?.getLastSelection()
  
  
  #
  # Create a mark where the current cursor is (or destroy existing mark).
  #
  mark: ->
    editor = atom.workspace.getActiveTextEditor()
    lastSelection = @getSelection()
    lastCursor = @getCursor()
    
    if not editor or not lastSelection or not lastCursor
      return
    
    # Get the last selection's original range
    range  = lastSelection.getBufferRange()
    
    # Get the last cursor's position
    row    = lastCursor.getBufferRow()
    column = lastCursor.getBufferColumn()
    
    destroyedSelection = false
    beginningHasCursor = false
    
    # Iterate over existing selections
    for selection in editor.getSelections()
      selectionRange = selection.getBufferRange()
      
      if selectionRange.start.row is 0 and selectionRange.start.column is 0
        # There is a cursor at the beginning of the buffer
        beginningHasCursor = true
      
      if selection is lastSelection
        # Ignore current cursor
        continue
      else if selection.intersectsWith(lastSelection)
        # Destroy the existing selection
        selection.destroy()
        destroyedSelection = true
    
    # Return if one or more selections were destroyed (toggled off)
    if destroyedSelection
      return
    
    # "Re-mark" the current buffer range (in order to set invalidate: 'never')
    editor.markBufferRange(
      [[range.start.row, range.start.column], [range.end.row, range.end.column]],
      {
        invalidate: 'never'
      }
    )
    
    # FIXME: Cannot currently mark the beginning *and* the end of the buffer
    if beginningHasCursor
      # Last row and column in buffer
      lastRow = editor.getLastBufferRow()
      lastColumn = editor.lineTextForBufferRow(lastRow).length
      
      # Create new cursor at the end of the buffer
      # (can't be added at the current position, or it will be invalidated)
      editor.addCursorAtBufferPosition([lastRow, lastColumn])
    else
      # Create new cursor at the beginning of the buffer
      # (can't be added at the current position, or it will be invalidated)
      editor.addCursorAtBufferPosition([0, 0])
    
    # Move the new cursor to the correct position
    editor.getLastSelection().cursor.setBufferPosition([row, column])
  
  
  #
  # Move the current cursor.
  #
  moveUp: ->
    @getCursor()?.moveUp()
  moveDown: ->
    @getCursor()?.moveDown()
  moveLeft: ->
    @getCursor()?.moveLeft()
  moveRight: ->
    @getCursor()?.moveRight()
  moveToBeginningOfWord: ->
    @getCursor()?.moveToBeginningOfWord()
  moveToEndOfWord: ->
    @getCursor()?.moveToEndOfWord()
  moveToFirstCharacterOfLine: ->
    @getCursor()?.moveToFirstCharacterOfLine()
  moveToEndOfLine: ->
    @getCursor()?.moveToEndOfLine()
  moveToTop: ->
    @getCursor()?.moveToTop()
  moveToBottom: ->
    @getCursor()?.moveToBottom()
  
  
  #
  # Select with the current cursor.
  #
  selectUp: ->
    @getSelection()?.selectUp()
  selectDown: ->
    @getSelection()?.selectDown()
  selectLeft: ->
    @getSelection()?.selectLeft()
  selectRight: ->
    @getSelection()?.selectRight()
  selectToBeginningOfWord: ->
    @getSelection()?.selectToBeginningOfWord()
  selectToEndOfWord: ->
    @getSelection()?.selectToEndOfWord()
  selectToFirstCharacterOfLine: ->
    @getSelection()?.selectToFirstCharacterOfLine()
  selectToEndOfLine: ->
    @getSelection()?.selectToEndOfLine()
  selectToTop: ->
    @getSelection()?.selectToTop()
  selectToBottom: ->
    @getSelection()?.selectToBottom()
