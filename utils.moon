
import insert from table
import remove from table

Utils = {}
Utils.room = {}

Graphics = love.graphics
Window = love.window
Filesystem = love.filesystem

with Utils

  .room.gotoRoom = (roomType, ...) ->
    export G_currentRoom = _G[roomType](...)

  .slowDt = (amount = 1, dur = 0) ->
    opts.slow = amount
    Gtimer\tween 'slow', dur, love, {slow: 1}, 'in-out-cubic'

  .randomTableValue = (t) ->
    keys = {}
    for key, value in pairs t do keys[#keys+1] = key
    i = keys[love.math.random(1, #keys)]
    t[i]

  .recEnumerate = (folder, fileList)->
    items = Filesystem.getDirectoryItems folder
    for i, item in ipairs items
      if item\find('.moon', 1, true) ~= nil
        remove items, i
    for _, item in ipairs items
      file = folder .. "/" .. item
      if Filesystem.getInfo(file).type == "file"
        insert fileList, file
      elseif Filesystem.getInfo(file).type == "directory"
        Utils.recEnumerate file, fileList

  .requireFiles = (files) ->
    for _,file in ipairs files
      -- remove .lua
      file = file\sub 1, -5
      assert require file

  .Uid = ->
    f = (x) ->
      r = random(16) - 1
      r = (x == "x") and (r + 1) or (r % 4) + 9
      return ("0123456789abcdef")\sub r, r
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx")\gsub("[xy]", f))

  .Random = (min, max) ->
    min, max = min or 0, max or 1
    (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)


Utils
