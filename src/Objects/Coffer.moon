Menu = assert require "src/GUI/Menu"

export class Coffer extends InteractiveObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    @collider = area.world\newRectangleCollider @x, @y, @w, @h
    with @collider
      \setObject self
      \setCollisionClass 'Coffer'
      \setType 'static'


  update: (dt) =>
    super dt

    if @collider\enter 'Awtron'
      Log.debug "Awtron entered the coffer collider"
      Menu.root\addChildCore Menu.playerPopUp

    if @collider\exit 'Awtron'
      Log.debug "Awtron exited the coffer collider"
      Menu.root\removeChildCore Menu.playerPopUp

