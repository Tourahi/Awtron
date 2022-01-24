Graphics = love.graphics
Content = assert require 'src/Controls/Content'
Menu = assert require 'src/GUI/Menu'
Flux = MeowC.core.Flux

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts


    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @freezed = false

    @isCharging = false

    @inventory = assert require 'src/Inventory'

    @x, @y = ww/2, wh - 62
    @w, @h = 20, 46
    @ox, @oy = @w/2, @h/2
    @v = 0
    @a = 100
    @dir = -1

    @move = true

    @maxV = 100

    @battery = 100 -- %
    @heat = 0 -- c
    @net = 50 -- %
    @cpu = 20 -- %

    @minnigTimer = nil

    -- Rates of discharge
    @batteryR = 20 -- -20% every 30s
    @batteryC = 10

    -- Accumulated Heat
    @accHeat = 0
    @lastAccHeat = 0

    -- Cooling
    @cooling = 50

    -- @Desc : Cpu speed is the ammount of coins you mine every 15s
    @cpuSpeed = 2.5 -- default

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
    @timer\every 'battery', 30, ->
      if @isCharging == false
        @battery -= @batteryR
        @battery = love.math.clamp @battery, 0, 100
        @heat += @accHeat


  update: (dt) =>
    super dt
    if @battery == 0 or @heat == 100
      Menu.root\removeChildCore Menu.exit
      Menu.root\removeChildCore Menu.settings
      Menu.root\removeChildCore Menu.console
      Menu.root\removeChildCore Menu.battryC
      Menu.root\removeChildCore Menu.heatC
      Menu.root\removeChildCore Menu.procC
      Menu.root\removeChildCore Menu.interC
      Menu.root\removeChildCore Menu.playerPopUp
      Utils.room.gotoRoom 'Dead'

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
    if @fHeat
      @fHeat\stop!
      Flux\remove @fHeat
      @fHeat = nil

    @isMining = true
    @freez true
    @minnigTimer = @timer\every 'minnigTimer', 15,(c) ->
      Sounds.coin\play!
      @inventory.coin += @cpuSpeed
      if @accHeat < 100
        @accHeat += 5

    Menu.mineBar.Ttimer = @timer\every 'Ttimer', 1, ->
      Menu.mineBar\setValue(Menu.mineBar.value + (100 / 15))

    Menu.mineBar.TAtimer = @timer\every 'TAtimer', 15, ->
      Menu.mineBar\setValue 1

    Menu.mineBtn\setEnabled false


  stopMinning: =>
    @lastAccHeat = @accHeat
    if @lastAccHeat > 0
      @heat += @lastAccHeat
    @accHeat = 0
    @isMining = false
    @freez false
    @timer\cancel 'minnigTimer'
    @timer\cancel 'Ttimer'
    @timer\cancel 'TAtimer'
    Menu.mineBar\setValue 1
    Menu.mineBtn\setEnabled true
    if @isMining == false and @heat > 5
      @fHeat = Flux.to self, @cooling + (@lastAccHeat * 0.2), {heat: 5}
      @fHeat\oncomplete () ->
        Flux\remove @fHeat
        @fHeat = nil

  equipe: (item) =>
    if item.it == "battery"
      @batteryR = item.dischargeRate
      @batteryc = item.chargeRate
    elseif item.it == "cpu"
      @cpuSpeed = item.power
    elseif item.it == "wifi card"
      @net = item.power
    elseif item.it == "fan"
      @cooling = item.power

  startCharging: =>
    @isCharging = true
    @freez true

    @chargerTimer = @timer\every 'chargerTimer', 15,(c) ->
      if @battery < 100
        @battery += @batteryC
        Menu.chargeVal\setText @battery

  stopCharging: =>
    @isCharging = false
    @freez false
    @timer\cancel 'chargerTimer'



  destroy: =>
    super self
