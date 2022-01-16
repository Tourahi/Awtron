M = assert require 'moon'
export Dump = M.p
assert require "engine"
assert require "opts"


-- Utils
export Utils = assert require 'utils'
MManager = MeowC.core.Manager

assert require 'src.Objects.Area'
assert require 'src.GameObject'
assert require 'src.InteractiveObject'



with love
  .load = ->
    Graphics = love.graphics

    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'

    export Fonts = {
      FTitlesHand: 'assets/fonts/FoundationTitlesHand/FoundationTitlesHand-v0.85.ttf'
      Pixel: 'assets/fonts/datcub-font/Datcub-eZO2g.ttf'
    }

    export input = Input!
    export timer = Timer!

    objectFiles = {}
    Utils.recEnumerate 'src/Objects', objectFiles
    Utils.requireFiles objectFiles
    roomFiles = {}
    Utils.recEnumerate 'Rooms', roomFiles
    Utils.requireFiles roomFiles

    Utils.room.gotoRoom 'Stage'

    input\bindArr {
      'right': 'right'
      'left': 'left'
      'up': 'up'
      'down': 'down'
      'f2': 'f2'
      'f4': 'f4'
      'l': 'l'
      's': 's'
      'return': 'enter'
      'escape': 'escape'
    }


  .update = (dt) ->
    Event = love.event
    if input\down 'escape' then Event.quit!
    timer\update dt * opts.slow
    if G_currentRoom
      G_currentRoom\update dt * opts.slow

  .draw = ->
    if G_currentRoom then G_currentRoom\draw!

  .mousepressed = (x, y, button) ->
    G_currentRoom\mousepressed x, y, button

  .keypressed = (key, is_r) ->
    G_currentRoom\keypressed key, is_r

  .mousemoved = (x, y, button) ->
    G_currentRoom\mousemoved x, y, button

  .mousereleased = (x, y, button) ->
    G_currentRoom\mousereleased x, y, button

  .wheelmoved = (x, y) ->
    G_currentRoom\wheelmoved x, y

  .keyreleased = (key) ->
    G_currentRoom\keyreleased key

  .textinput = (text) ->
    G_currentRoom\textinput text


