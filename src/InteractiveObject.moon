Graphics = love.graphics
import getTime from love.timer

export class  InteractiveObject extends GameObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    @area = area
    @x, @y = x, y
    @id  = Utils.Uid!
    @creationTime = getTime!
    @timer = Timer!
    @dead = false
    @depth = 50
    @collider = nil
    @w, @h = _opts.width, _opts.height
    @visible = _opts.visible
    @shape = _opts.shape
    @rot = _opts.rot
    @vertices  = _opts.vertices

