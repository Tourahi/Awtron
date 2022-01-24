M = assert require 'moon'
export Dump = M.p
assert require "engine"
assert require "opts"
export Audio = love.audio

-- Utils
export Utils = assert require 'utils'
MManager = MeowC.core.Manager

assert require 'src.Objects.Area'
assert require 'src.GameObject'
assert require 'src.InteractiveObject'

love.math.clamp = (val, min, max) ->
  assert val and min and max, "Please provide all the parameters. [love.math.clamp]"
  if min > max then min, max = max, min
  math.max min, math.min(max, val)

with love
  .load = ->
    Graphics = love.graphics

    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'

    export Sounds = {
      charge: Audio.newSource "assets/music/charge.wav", "stream"
      coin: Audio.newSource "assets/music/coin.wav", "stream"
      danger: Audio.newSource "assets/music/danger.wav", "stream"
      select: Audio.newSource "assets/music/select.wav", "stream"
      startGame: Audio.newSource "assets/music/startGame.wav", "stream"
      upgrade: Audio.newSource "assets/music/upgrade.wav", "stream"
    }

    export Fonts = {
      Pixel: 'assets/fonts/datcub-font/Datcub-eZO2g.ttf'
      BPixel: 'assets/fonts/datcub-font/DatcubBold-4BMy6.ttf'
      FD: 'assets/fonts/FoundationTitlesHand/FoundationTitlesHand-SemiBold-v0.85.ttf'
    }

    export input = Input!
    export timer = Timer!

    objectFiles = {}
    Utils.recEnumerate 'src/Objects', objectFiles
    Utils.requireFiles objectFiles
    roomFiles = {}
    Utils.recEnumerate 'Rooms', roomFiles
    Utils.requireFiles roomFiles

    Utils.room.gotoRoom 'Start'

    input\bindArr {
      'right': 'right'
      'left': 'left'
      'up': 'up'
      'down': 'down'
      'f2': 'f2'
      'f4': 'f4'
      'e': 'e'
      'u': 'u'
      'l': 'l'
      's': 's'
      'c': 'c'
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
    Graphics = love.graphics
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


