Control = MeowC.core.Control
Theme = MeowC.core.Theme
Graphics = love.graphics

Content = Control\extend "Content",{
  theme: nil
  isHovered: false
  backgroundColor: nil
  transparency: nil
  stroke: nil
  strokeColor: nil
  ox: 0
  oy: 0
}

with Content
  .init = =>
    @super.init(self)
    theme = table.copy(Theme\getInstance!\getProperty "content")
    @setClip false
    @setEnabled true
    @backgroundColor = theme.backgroundColor
    @transparency = theme.transparency
    @stroke = theme.stroke
    @strokeColor = theme.strokeColor
    -- event Connections
    @on "UI_DRAW", @onDraw, self
    @on "UI_MOUSE_ENTER", @onMouseEnter, self
    @on "UI_WHELL_MOVE", @onWheelMove, self

  .onDraw = =>
    Graphics.push!
    box = self\getBoundingBox!
    r, g, b, a = Graphics.getColor!
    Graphics.setColor @backgroundColor[1], @backgroundColor[2], @backgroundColor[3], @transparency
    Graphics.rectangle "fill", box\getX!, box\getY!, box\getWidth!, box\getHeight!, 1, 1, @ox, @oy

    -- Border
    oldLW = Graphics.getLineWidth!
    Graphics.setLineWidth @stroke
    Graphics.setLineStyle "rough"

    Graphics.setColor @strokeColor[1], @strokeColor[2], @strokeColor[3], @strokeColor[4]
    Graphics.rectangle "line", box.x, box.y, box\getWidth!, box\getHeight!, 1, 1, @ox, @oy
    Graphics.setLineWidth oldLW


    Graphics.setColor r, g, b, a

    Graphics.pop!


  .setBackgroundColor = (bc) =>
    @backgroundColor = bc

  .setTransparency = (t) =>
    @transparency = t

  .setStroke = (s) =>
    @stroke = s

  .setStrokeColor = (sc) =>
    @strokeColor = sc

  .setOffset = (ox, oy) =>
    @ox, @oy = ox, oy



return Content
