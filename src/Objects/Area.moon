import remove from table
import insert from table
MManager = MeowC.core.Manager

export class Area
  new: (room, GUI) =>
    @room = room
    @GUI = GUI

    root = MManager\getInstanceRoot!
    if @GUI
      for k,widget in pairs @GUI
        root\addChildCore widget

    @gameObjects = {}
    @mapObjects  = @room.map.objects

  update: (dt) =>
    if Gtimer then Gtimer\update dt
    if @world then @world\update dt

    for i = #@gameObjects, 1, -1
      gameObject = @gameObjects[i]
      gameObject\update dt
      if gameObject.dead
        gameObject\destroy!
        remove @gameObjects, i

  draw: =>
    table.sort @gameObjects, (a, b) ->
      if a.depth == b.depth then return a.creationTime < b.creationTime
      else return a.depth < b.depth

    for _, gameObject in ipairs @gameObjects do gameObject\draw!

  addGameObject: (gameObjectType, x = 0, y = 0, opts = {}) =>
    gameObject = _G[gameObjectType](self, x, y, opts)
    insert @gameObjects, gameObject
    gameObject

  attachMapObjects: =>
    for _, o in pairs @mapObjects
      Log.debug "Tiled Object : " .. o.name
      if _G[o.name]
        @addGameObject o.name, o.x, o.y, {
          width: o.width,
          height: o.height,
          visible: o.visible,
          shape: o.shape,
          rot: o.rotation,
          vertices: o.rectangle
        }

  getCamera: =>
    @room.camera

  getRoom: =>
    @room

  addPhysicsWorld: =>
    @world = Physics.newWorld 0, 0, true
    @leftWall = @world\newRectangleCollider 0, 0, 16, G_baseH/opts.scale
    @rightWall = @world\newRectangleCollider G_baseW/opts.scale - 16, 0, 16, G_baseH/opts.scale
    @leftWall\setType 'static'
    @rightWall\setType 'static'

  filterGameObjects: (filter)=>
    filtred = {}
    for _, obj in pairs @gameObjects
      if filter(obj) then table.insert(filtred, obj)
    filtred


  destroy: =>
    for i = #@gameObject, 1, -1
      gameObj = @gameObjects[i]
      gameObj\destroy!
      remove @gameObjects, i

    @gameObjects = {}

    if @world
      @world\destroy!
      @world = nil



