Control = MeowC.core.Control
import Colors from MeowC.core.Theme
Graphics = love.graphics
import Flux from MeowC.core

-- Extend from the Control class
ImageCanvas = Control\extend "ImageCanvas",{
  theme: nil
  isHovered: false
  drawable: nil
  rot: 0
  scaleX: 1
  scaleY: 1
  originOffsetX: 0
  originOffsetY: 0
  shearingX: 0
  shearingY: 0
  tween: nil
}

with ImageCanvas
  .init = (img) =>
    -- call the parent constructor
    @super.init(self)

    @setClip true
    @setEnabled true
    if type(img) == 'string'
      @setImage img
    else
      @drawable = img
      @resetSize!

    -- event Connections
    @on "UI_DRAW", @onDraw, self
    @on "UI_MOUSE_ENTER", @onMouseEnter, self
    @on "UI_MOUSE_LEAVE", @onMouseLeave, self
    @on "UI_MOUSE_DOWN", @onMouseDown, self
    @on "UI_MOUSE_UP", @onMouseUp, self

  .setImage = (filename) =>
    if filename
      @drawable = Graphics.newImage filename
      @resetSize!

  .resetSize = =>
    if @drawable
      @setWidth @drawable\getWidth! * @scaleX
      @setHeight @drawable\getHeight! * @scaleY
    else
      @setWidth 0
      @setHeight 0

  .onDraw = =>
    Graphics.push!
    box = @getBoundingBox!
    Graphics.draw @drawable, box\getX!, box\getY!,
      @rot, @scaleX, @scaleY, @originOffsetX, @originOffsetY,
      @shearingX, @shearingY
    Graphics.pop!

  .setScale = (sx = nil, sy = nil) =>
    @scaleX = sx or @scaleX
    @scaleY = sy or @scaleY

  .getScale = =>
    @scaleX, @scaleY

  .setOriginOffset = (ox = nil, oy= nil) =>
    @originOffsetX = ox or @originOffsetX
    @originOffsetY = oy or @originOffsetY

  .getOriginOffset = =>
    @originOffsetX, @originOffsetY

  .setShearing = (sx = nil, sy = nil) =>
    @shearingX = sx or @shearingX
    @shearingY = sx or @shearingY

  .scaleContactArea = (sx, sy) =>
    @setWidth @drawable\getWidth! * sx
    @setHeight @drawable\getHeight! * sy

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



ImageCanvas
