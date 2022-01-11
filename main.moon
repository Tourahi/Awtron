M = assert require 'moon'
export Dump = M.p
assert require "engine"
assert require "opts"


-- Utils
export Utils = assert require 'utils'
export Gtimer = Timer!

assert require 'src.Objects.Area'
assert require 'src.GameObject'

with love
  .load = ->
    Graphics = love.graphics

    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'

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


