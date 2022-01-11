Graphics = love.graphics

export class Awtron extends GameObject
  new: (area, x, y, _opts = {}) =>
    _opts.spriteSheet = 'assets/Awtron.png'
    super area, x, y, _opts

    ww = G_baseW/opts.scale
    wh = G_baseH/opts.scale

    @x, @y = ww/2 - 16, wh - 48
    @w, @h = 32, 32

    @grid = Animation.newGrid 32, 32, @spriteSheet\getWidth!, @spriteSheet\getHeight!


    @animation = {
      idle: Animation.newAnimation(self.grid('1-1', 1), 0.2)
      move: Animation.newAnimation(self.grid('2-7', 1), 0.1)
    }

    @currentAnimation = @animation.move

    @collider = area.world\newCircleCollider @x, @y, @w
    with @collider
      \setObject self
      \setCollisionClass 'Awtron'

  update: (dt) =>
    @currentAnimation\update dt

  draw: =>
    @currentAnimation\draw @spriteSheet, @x, @y
