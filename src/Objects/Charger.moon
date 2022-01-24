Menu = assert require "src/GUI/Menu"

export class Charger extends InteractiveObject
  new: (area, x, y, _opts = {}) =>
    super area, x, y, _opts

    @collider = area.world\newRectangleCollider @x, @y, @w, @h
    with @collider
      \setObject self
      \setCollisionClass 'Charger'
      \setType 'static'

  update: (dt) =>
    super dt

    @collider\setPreSolve (ca, c) =>
      Menu.playerPopUp\setText "C"
      c\setEnabled false

      if @collision_class == 'Charger' and ca.collision_class == 'Awtron'
        Menu.playerPopUp\setVisible true
      elseif @collision_class == 'Charger' and ca.collision_class == 'Awtron'
        Menu.playerPopUp\setVisible false

    @collider\enter 'Awtron'
    if @collider\stay('Awtron')
      if @area.room.player.isCharging == false
        Menu.playerPopUp\setText "C"
      else
        Menu.playerPopUp\setText "S"
      if input\pressed('c') and (@area.room.player.isCharging == false)
        Menu.playerPopUp\setVisible false
        Menu.chargeVal\setText @area.room.player.battery
        Menu\addChargeView!
        @area.room.player\startCharging!
      elseif input\pressed('s') and (@area.room.player.isCharging == true)
        Menu.playerPopUp\setVisible false
        @area.room.player\stopCharging!
        Menu\removeChargeView!

    if @collider\exit 'Awtron'
      Menu.playerPopUp\setVisible false
      @area.room.player\stopCharging!

