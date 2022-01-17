Graphics = love.graphics
Content = assert require 'src/Controls/Content'
Menu = assert require "src/GUI/Menu"

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts


    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @x, @y = ww/2, wh - 62
    @w, @h = 20, 46
    @ox, @oy = @w/2, @h/2
    @v = 0
    @a = 100
    @dir = -1

    @move = true

    @maxV = 100


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

  update: (dt) =>
    super dt
    Menu.playerPopUp\setPos @x - 5 , @y - 43
    ww = G_baseW/opts.scale

    @v = math.min @v + @a*dt, @maxV

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

    @currentAnimation\update dt
    --@currentEmotion\update dt

  draw: =>
    x, y = @collider\getPosition!
    @currentAnimation\draw @spriteSheetMovement, x, y, 0, @dir, 1, @ox, @oy
    --@currentEmotion\draw @spriteSheetEmo, @x, @y - 16, 0, @dir, 1, 16
    if opts.DEBUG
      @area.world\draw!


  destroy: =>
    super self
