
Menu = assert require "src/GUI/Menu"

export class Updater extends InteractiveObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    @collider = area.world\newRectangleCollider @x, @y, @w, @h
    with @collider
      \setObject self
      \setCollisionClass 'Coffer'
      \setType 'static'

  update: (dt) =>
    super dt

    @collider\setPreSolve (ca, c) =>
      Menu.playerPopUp\setText "U"
      c\setEnabled false

      if input\pressed 'u'
        Menu\showGatewayComputer!
      if @collision_class == 'Coffer' and ca.collision_class == 'Awtron' and (Menu.computerOn == false)
        Menu.playerPopUp\setVisible true
      elseif @collision_class == 'Coffer' and ca.collision_class == 'Awtron' and (Menu.computerOn == true)
        Menu.playerPopUp\setVisible false

    @collider\enter 'Awtron'
    if @collider\stay('Awtron')
      if input\pressed('u') and (Menu.computerOn == false)
        Menu.playerPopUp\setVisible false
        Menu\showGatewayComputer!

    if @collider\exit 'Awtron'
      Menu.playerPopUp\setVisible false
      if Menu.computerOn
        Menu\hideGatewayComputer!
