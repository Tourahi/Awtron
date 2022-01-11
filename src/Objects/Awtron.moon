Graphics = love.graphics

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    _opts.spriteSheet = 'assets/Awtron.png'
    super area, x, y, _opts

    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @x, @y = ww/2 - 16, wh - 48
    @w, @h = 32, 32
    @v = 0
    @a = 100

    @grid = Animation.newGrid 32, 32, @spriteSheet\getWidth!, @spriteSheet\getHeight!
    @move = true

    @maxV = 100

    @dir = 1


    @animation = {
      idle: Animation.newAnimation(self.grid('1-1', 1), 0.2)
      move: Animation.newAnimation(self.grid('2-7', 1), 0.1)
    }

    @currentAnimation = @animation.move

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
      @currentAnimation = @animation.move
      @dir = 1
    elseif input\down 'left'
      @collider\setLinearVelocity -@v, 0
      @currentAnimation = @animation.move
      @dir = -1
    else
      @collider\setLinearVelocity 0, 0
      @currentAnimation = @animation.idle




    @currentAnimation\update dt

  draw: =>
    @currentAnimation\draw @spriteSheet, @x, @y - 16, 0, @dir, 1, 16
    @area.world\draw!


  destroy: =>
    super self
