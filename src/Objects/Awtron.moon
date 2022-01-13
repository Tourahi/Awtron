Graphics = love.graphics

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @x, @y = ww/2 - 16, wh - 48
    @w, @h = 32, 32
    @v = 0
    @a = 100

    @move = true

    @maxV = 100

    @dir = 1

    @spriteSheetMovement = Graphics.newImage 'assets/Awtron.png'
    @spriteSheetEmo = Graphics.newImage 'assets/AwtronEmo.png'

    @gridMv = Animation.newGrid 32, 32, @spriteSheetMovement\getWidth!, @spriteSheetMovement\getHeight!
    @gridEmo = Animation.newGrid 32, 32, @spriteSheetEmo\getWidth!, @spriteSheetEmo\getHeight!

    @animations = {
      idle: Animation.newAnimation(self.gridMv('1-1', 1), 0.2)
      move: Animation.newAnimation(self.gridMv('2-7', 1), 0.1)
      emo: Animation.newAnimation(self.gridEmo('1-3', 1), 0.3)
    }

    @currentAnimation = @animations.move
    @currentEmotion = @animations.emo

    @collider = area.world\newRectangleCollider @x, @y, @w/2, @h
    with @collider
      \setObject self
      \setCollisionClass 'Awtron'

  update: (dt) =>
    super dt
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
    @currentEmotion\update dt

  draw: =>
    @currentAnimation\draw @spriteSheetMovement, @x, @y - 16, 0, @dir, 1, 16
    @currentEmotion\draw @spriteSheetEmo, @x, @y - 16, 0, @dir, 1, 16
    if opts.DEBUG
      @area.world\draw!


  destroy: =>
    super self
