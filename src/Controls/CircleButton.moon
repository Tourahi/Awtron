Theme = MeowC.core.Theme
Graphics = love.graphics
Button = assert require 'src.Controls.Button'

CButton = Button\extend "CButton",{
  isHovred: false
  isPressed: false
  text: ""
  theme: nil
  width: 0
  hight: 0
  font: nil
  textDrawable: nil
  iconImg: nil
  rot: 0
  scaleX: 1
  scaleY: 1
  originOffsetX: 0
  originOffsetY: 0
  shearingX: 0
  shearingY: 0
  alpha: 1
}


with CButton
  .init = =>
    -- call the parent constructor
    @super.super.init(self, 'Circle')
    @theme = table.copy(Theme\getInstance!\getProperty "button")
    @width = @theme.width
    @height = @theme.height
    if @theme.font
      @font = Graphics.newFont @theme.font, @theme.fontSize
    else
      @font = Graphics.newFont 15
    @textDrawable = Graphics.newText @font, @text
    -- @setClip true
    @setEnabled true

    -- Events
    @on "UI_DRAW", @onDraw, self
    @on "UI_MOUSE_ENTER", @onMouseEnter, self
    @on "UI_MOUSE_LEAVE", @onMouseLeave, self
    @on "UI_MOUSE_DOWN", @onMouseDown, self
    @on "UI_MOUSE_UP", @onMouseUp, self


  .onDraw = =>
    box = @getBoundingBox!
    r, g, b, a = Graphics.getColor!

    local color
    if @isPressed
      color = @theme.downColor
    elseif @isHovred
      color = @theme.hoverColor
    elseif @enabled
      color = @theme.upColor
    else
      color = @theme.disableColor

    Graphics.setColor color[1], color[2], color[3], @alpha
    Graphics.circle 'fill', box.x, box.y, box.r

    -- text/icon drawing and alignment

    text = @textDrawable
    textW = text and text\getWidth! * @scaleX or 0
    textH = text and text\getHeight! * @scaleY or 0
    textX = box.x - textW/2
    textY = box.y - textH/2


    icon = @iconImg
    if icon
      if not @isPressed
        Graphics.setColor r, g, b, @alpha
      if @isHovred
        Graphics.setColor color[1], color[2], color[3], @alpha
      sf = @stencileFunc!
      Graphics.stencil sf, "replace", 1
      Graphics.setStencilTest "greater", 0
      Graphics.draw @iconImg, (box.x - (@iconImg\getWidth!*0.5) * @scaleX),
        (box.y - (@iconImg\getHeight!*0.5) * @scaleY),
        @rot, @scaleX, @scaleY

      -- Graphics.draw @iconImg, box.x - @iconImg\getWidth!*0.5, box.y - @iconImg\getHeight!*0.5
      Graphics.setStencilTest!
      Graphics.setColor color[1], color[2], color[3], @alpha

    -- Border drawing
    if @enabled
      oldLW = Graphics.getLineWidth!
      Graphics.setLineWidth @theme.stroke
      Graphics.setLineStyle "smooth"
      local color
      color = @theme.strokeColor
      Graphics.setColor color[1], color[2], color[3], @alpha
      Graphics.circle 'line', box.x, box.y, box.r
      Graphics.setLineWidth oldLW


    if text
      local color
      color = @theme.fontColor
      Graphics.setColor color[1], color[2], color[3], @alpha
      Graphics.draw text, textX, textY

    Graphics.setColor r, g, b, a

  .stencileFunc = =>
    box = @getBoundingBox!
    return () -> Graphics.circle "fill", box.x, box.y, box.r

  .setScale = (sx = nil, sy = nil) =>
    @scaleX = sx or @scaleX
    @scaleY = sy or @scaleY




CButton
