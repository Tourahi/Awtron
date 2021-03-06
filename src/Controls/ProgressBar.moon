Control = MeowC.core.Control
Theme = MeowC.core.Theme
Colors = MeowC.core.Colors
Graphics = love.graphics

ProgressBar = Control\extend "ProgressBar",{
  value: 0
  minValue: 0
  maxValue: 100
  color: nil
  background: nil
  callback: nil
  dangerZone: false
  dangerAt: 0
  dangerColor: nil
  bgAlpha: 1
}


with ProgressBar
  .init = =>
    @super.init(self)
    @color = Colors.blue
    @dangerColor = Colors.red
    @background = Colors.white

    @setEnabled true
    @setClip true

    -- Events
    @on "UI_DRAW", @onDraw, self
    -- @on "UI_UPDATE", @onDraw, self

  .onDraw = =>
    box = @getBoundingBox!
    r, g, b, a = Graphics.getColor!
    @background[4] = @bgAlpha
    Graphics.setColor @background
    Graphics.rectangle "fill", box\getX!, box\getY!, box\getWidth!, box\getHeight!, 2, 2



    barW = @value / (@maxValue - @minValue) * box\getWidth!
    if barW < 0
      barW = 0
    elseif barW == 0
      barW = 0.1
    elseif barW > box\getWidth!
      barW = box\getWidth!

    if @value <= @dangerAt and (@dangerType == "lt")
      Graphics.setColor @dangerColor
    elseif @value >= @dangerAt and (@dangerType == "mt")
      Graphics.setColor @dangerColor
    else
      Graphics.setColor @color
    Graphics.rectangle "fill", box\getX!, box\getY!, barW, box\getHeight!, 2, 2


    Graphics.setColor r, g, b, a


  .setColor = (c) =>
    @color = c

  .setDangerColor = (c) =>
    @dangerColor = c

  .setBackground = (b) =>
    @background = b

  .setValue = (v) =>
    @value = v
    @value = love.math.clamp @value, @minValue, @maxValue

  .setMaxValue = (v) =>
    @maxValue = value

  .setDangerZone = (at) =>
    @dangerAt = at

  .setDangerType = (dt) =>
    @dangerType = dt

  .setBgAlpha = (a) =>
    @bgAlpha = a

  .isEmpty = =>
    @value == 0
