Menu = assert require "src/GUI/Menu"

export class Charger extends InteractiveObject
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
      Menu.playerPopUp\setText "C"
      c\setEnabled false

      if input\pressed 'e'
        Menu\showCoffer!
      if @collision_class == 'Coffer' and ca.collision_class == 'Awtron' and (Menu.cofferOn == false)
        Menu.playerPopUp\setVisible true
      elseif @collision_class == 'Coffer' and ca.collision_class == 'Awtron' and (Menu.cofferOn == true)
        Menu.playerPopUp\setVisible false

    @collider\enter 'Awtron'
    if @collider\stay('Awtron')
      if input\pressed('e') and (Menu.cofferOn == false)
        Menu.playerPopUp\setVisible false
        Menu\showCoffer!

    if @collider\exit 'Awtron'
      Menu.playerPopUp\setVisible false
      if Menu.cofferOn
        Menu\hideCoffer!

