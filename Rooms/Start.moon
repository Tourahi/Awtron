MManager = MeowC.core.Manager
Menu = assert require "src/GUI/Menu"

export class Start
  new: =>
    Menu\showStart!

  update: (dt) =>
    MManager\update dt


  draw: () =>
    MManager\draw!

  mousepressed: (x, y, button) =>
    MManager\mousepressed x, y, button


  keypressed: (key, is_r) =>
    MManager\keypressed key, is_r


  mousemoved: (x, y, button) =>
    MManager\mousemoved x, y, button

  mousereleased: (x, y, button) =>
    MManager\mousereleased x, y, button

  wheelmoved: (x, y) =>
    MManager\wheelmoved x, y

  keyreleased: (key) =>
    MManager\keyreleased key

  textinput: (text) =>
    MManager\textinput text
