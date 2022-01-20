Graphics = love.graphics
Content = assert require 'src/Controls/Content'
Menu = assert require 'src/GUI/Menu'

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts


    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @freezed = false

    @inventory = assert require 'src/Inventory'

    @x, @y = ww/2, wh - 62
    @w, @h = 20, 46
    @ox, @oy = @w/2, @h/2
    @v = 0
    @a = 100
    @dir = -1

    @move = true

    @maxV = 100

    @battery = 90 -- %
    @heat = 5 -- c
    @net = 50 -- %
    @cpu = 20 -- %

    @minnigTimer = nil

    -- Rates of discharge
    @batteryR = 20 -- -20% every 30s

    -- Accumulated Heat
    @accHeat = 5

    -- Cooling
    @cooling = 5

    -- @Desc : Cpu speed is the ammount of coins you mine every 15s
    @cpuSpeed = 0.5 -- default

    @spriteSheetMovement = Graphics.newImage 'assets/AwtronV2.png'
    --@spriteSheetEmo = Graphics.newImage 'assets/AwtronEmo.png'

    @gridMv = Animation.newGrid 20, 46, @spriteSheetMovement\getWidth!, @spriteSheetMovement\getHeight!
    --@gridEmo = Animation.newGrid 32, 32, @spriteSheetEmo\getWidth!, @spriteSheetEmo\getHeight!

    @animations = {
      idle: Animation.newAnimation(self.gridMv('1-1', 1), 0.2)
      move: Animation.newAnimation(self.gridMv('1-3', 1), 0.1)
      --emo: Animation.newAnimation(self.gridEmo('1-3', 1), 0.3)
    }

    @currentAnimation = @animations.move
    --@currentEmotion = @animations.emo

    @collider = area.world\newRectangleCollider @x, @y, @w, @h
    with @collider
      \setObject self
      \setCollisionClass 'Awtron'


    -- Timers
    @timer\every 30, ->
      @battery -= @batteryR
      @battery = love.math.clamp @battery, 1, 100
      @heat += (@accHeat - @cooling)


  update: (dt) =>
    super dt
    Menu.playerPopUp\setPos @x - 5 , @y - 43
    Menu.heatBar\setValue @heat
    Menu.batteryBar\setValue @battery
    Menu.coinV\setText @inventory.coin
    Menu.Cpu\setText @cpu.."%"
    Menu.Net\setText @net.."%"


    ww = G_baseW/opts.scale

    @v = math.min @v + @a*dt, @maxV

    if @freezed == false
      if input\down 'right'
        @collider\setLinearVelocity @v, 0
        @currentAnimation = @animations.move
        @dir = 1
      elseif input\down 'left'
        @collider\setLinearVelocity -@v, 0
        @currentAnimation = @animations.move
        @dir = -1
      else
        @collider\setLinearVelocity 0, 0
        @currentAnimation = @animations.idle
    elseif @freezed == true
      @currentAnimation = @animations.idle

    @currentAnimation\update dt
    --@currentEmotion\update dt

  draw: =>
    x, y = @collider\getPosition!
    @currentAnimation\draw @spriteSheetMovement, x, y, 0, @dir, 1, @ox, @oy
    --@currentEmotion\draw @spriteSheetEmo, @x, @y - 16, 0, @dir, 1, 16
    if opts.DEBUG
      @area.world\draw!

  freez: (f) =>
    @freezed = f

  mine: =>
    @minnigTimer = @timer\every 3,(c) ->
        @inventory.coin += @cpuSpeed

    Menu.mineBar.Ttimer = @timer\every 1, ->
      Menu.mineBar\setValue(Menu.mineBar.value + (100 / 3))

    Menu.mineBar.TAtimer = @timer\every 3, ->
      Menu.mineBar\setValue 1

    Menu.minebBtn\setEnabled false

  stopMinning: =>
    @minnigTimer\destroy!



  destroy: =>
    super self
