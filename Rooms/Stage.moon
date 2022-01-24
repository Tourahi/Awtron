MManager = MeowC.core.Manager
Menu = assert require "src/GUI/Menu"

export class Stage
  new: =>

    @map = Tiler "assets/Maps/map.lua"

    -- Area
    @area = Area self, nil
    @area\addPhysicsWorld!

    -- Colli classes
    with @area.world
      \addCollisionClass 'Awtron'
      \addCollisionClass 'Coffer'
      \addCollisionClass 'Charger'
      --\addCollisionClass 'Projectile', {ignores: {'Projectile', 'Player', 'Bebop'}}
      --\addCollisionClass 'Collectable', {ignores: {'Collectable', 'Projectile', 'Bebop'}}

    @player = @area\addGameObject 'Awtron'

    @camera = Camera 0, 0, nil, nil, 2, 0, @map.width * @map.tilewidth, @map.height * @map.tilewidth
    @camera\setScale 2
    @camera\setFollowStyle "LOCKED"
    @camera\setFollowLerp 0.2
    @camera.drawDeadzone = true

    @area\attachMapObjects!

    Menu\init @player

    --Log.debug @player.id


  update: (dt) =>
    MManager\update dt
    --@camera.smoother = Camera.smooth.damped 5
    --@camera\lockPosition dt, G_baseW/2, G_baseH/2
    --@camera\lookAt @player.x, @player.y
    @camera\update dt
    @area\update dt

    --if input\down 'f4'
      --@area\addGameObject 'Boost', Random(0, G_baseW), Random(0, G_baseH),
        --{color: Colors.magenta}
      -- Gtimer\after 5, -> o\die!

    if input\down 'l'
      Leak.report!


  draw: () =>
    @camera\attachC nil, ->
      @map\drawLayers!
      @area\draw!
      MManager\draw!

  mousepressed: (x, y, button) =>
    x, y = @camera\toWorldCoords x, y
    MManager\mousepressed x, y, button


  keypressed: (key, is_r) =>
    MManager\keypressed key, is_r


  mousemoved: (x, y, button) =>
    x, y = @camera\toWorldCoords x, y
    MManager\mousemoved x, y, button

  mousereleased: (x, y, button) =>
    x, y = @camera\toWorldCoords x, y
    MManager\mousereleased x, y, button

  wheelmoved: (x, y) =>
    x, y = @camera\toWorldCoords x, y
    MManager\wheelmoved x, y

  keyreleased: (key) =>
    MManager\keyreleased key

  textinput: (text) =>
    MManager\textinput text



  destroy: =>
    @area\destroy!
    @area = nil
