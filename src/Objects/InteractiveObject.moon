Graphics = love.graphics

export class  InteractiveObject extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    @x, @y = x, y
    @w, @h = _opts.width, _opts.height

    @collider = area.world\newRectangleCollider @x, @y, @w, @h
    with @collider
      \setObject self
      \setCollisionClass _opts.name
