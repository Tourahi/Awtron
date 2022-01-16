Control = MeowC.core.Control
Theme = MeowC.core.Theme
Graphics = love.graphics
Mouse = love.mouse

Button = Control\extend "Button",{
  isHovred: false
  isPressed: false
  text: ""
  theme: nil
  width: 0
  hight: 0
  padding: 0
  font: nil
  textDrawable: nil
  iconImg: nil
  border: 0
  Etimer: nil
}


with Button
  .init = =>
    -- call the parent constructor
    @super.init(self)
    @theme = table.copy(Theme\getInstance!\getProperty "button")
    @width = @theme.width
    @height = @theme.height
    @border = @theme.stroke
    @drawBorder = false
    if @theme.font
      @font = Graphics.newFont @theme.font, @theme.fontSize
    else
      @font = Graphics.newFont 15
    @textDrawable = Graphics.newText @font, @text
    -- @setClip true
    @setEnabled true


    @Etimer = Timer!

    -- Events
    @on "UI_DRAW", @onDraw, self
    @on "UI_UPDATE", @onUpdate, self
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

    Graphics.setColor color[1], color[2], color[3], color[4]
    Graphics.rectangle "fill", box.x, box.y, box\getWidth!, box\getHeight!

    -- Border drawing
    if @enabled or @drawBorder
      oldLW = Graphics.getLineWidth!
      Graphics.setLineWidth @border
      Graphics.setLineStyle "rough"
      local color
      color = @theme.strokeColor
      Graphics.setColor color[1], color[2], color[3], color[4]
      Graphics.rectangle "line", box.x, box.y, box\getWidth!, box\getHeight!
      Graphics.setLineWidth oldLW

    -- text/icon drawing and alignment

    text = @textDrawable
    textW = text and text\getWidth! or 0
    textH = text and text\getHeight! or 0
    textX = 0
    textY = (box\getHeight! - textH)/2 + box.y

    icon = @iconImg
    iconW = icon and icon\getWidth! or 0
    iconH = icon and icon\getHeight! or 0
    iconX = 0
    iconY = (box\getHeight! - iconH)/2 + box.y

    space = text and icon and @theme.iconAndTextSpace or 0
    dynamicContentWidth = space + textW + iconW


    if @theme.iconDir == "left"
      iconX = (box\getWidth! - dynamicContentWidth) / 2 + box.x + @padding
      textX = iconX + iconW + space
    else
      textX = (box\getWidth! - dynamicContentWidth) / 2 + box.x
      iconX = iconX + iconW + space

    if text
      local color
      color = @theme.fontColor
      Graphics.setColor color[1], color[2], color[3], color[4]
      Graphics.draw text, textX, textY

    if @iconImg
      Graphics.draw icon, iconX, iconY

    Graphics.setColor r, g, b, a


  .onUpdate = (dt) =>
    if @Etimer
      @Etimer\update dt



  .onClick = (cb) =>
    @Click = cb

  .onHover = (cb) =>
    @Hover = cb

  .onLeave = (cb) =>
    @Leave = cb

  .onAfterClick = (cb) =>
    @aClick = cb

  .onMouseEnter = =>
    if @Hover
      @Hover!
    @isHovred = true
    if Mouse.getSystemCursor "hand"
      Mouse.setCursor(Mouse.getSystemCursor("hand"))

  .onMouseLeave = =>
    if @Leave
      @Leave!
    @isHovred = false
    Mouse.setCursor!

  .onMouseDown = (x, y) =>
    if @Click
      @Click!
    @isPressed = true

  .onMouseUp = (x, y) =>
    if @aClick
      @aClick!
    @isPressed = false

  .setIcon = (icon) =>
    @iconImg = Graphics.newImage icon

  .setIconDir = (dir) =>
    @theme.iconDir = dir

  .setText = (text) =>
    @text = text
    @textDrawable\set text

  .setUpColor = (color) =>
    @theme.upColor = color

  .setDownColor = (color) =>
    @theme.downColor = color

  .setHoverColor = (color) =>
    @theme.setHoverColor = color

  .setDisableColor = (color) =>
    @theme.disableColor = color

  .setStroke = (s) =>
    @theme.stroke = s

  .setFont = (f) =>
    @theme.font = f
    @font = Graphics.newFont f, @theme.fontSize
    @textDrawable = Graphics.newText @font, @text

  .setFontColor = (c) =>
    @theme.fontColor[1] = c[1]
    @theme.fontColor[2] = c[2]
    @theme.fontColor[3] = c[3]

  .setBorder = (b) =>
    @border = b

  .flashOn = =>
    @Etimer\every 0.3, ->
      --@isHovred = not @isHovred
      @isPressed = not @isPressed

  .setBorderColor = (b) =>
    @theme.strokeColor = b

  .setDrawBorder = (b) =>
    @drawBorder = b

  .setFontSize = (fs) =>
    if @theme.font
      @font = Graphics.newFont @theme.font, fs
    else
      @font = Graphics.newFont fs
    @textDrawable = Graphics.newText @font, @text

  .setPadding = (p) =>
    @padding = p


Button
