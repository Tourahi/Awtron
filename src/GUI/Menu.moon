-- controls
MManager = MeowC.core.Manager
SelectOpt = assert require 'src/Controls/SelectOpt'
CButton = assert require 'src/Controls/CircleButton'
Button = assert require 'src/Controls/Button'
Content = assert require 'src/Controls/Content'
ImageCanvas = assert require 'src/Controls/ImageCanvas'
ProgressBar = assert require 'src/Controls/ProgressBar'

Colors = MeowC.core.Colors
Menu = {}


with Menu
  .init = =>
    Graphics = love.graphics
    Log.debug "Menu initialized."

    @padding = 16 + 10 -- 16 size of the wall tile

    @root = MManager\getInstanceRoot!

    -- flags
    @cofferOn = false
    @computerOn = false

    -- Dashboard
    @exit = Button\new!
    @settings = Button\new!
    @playerPopUp = Button\new!
    @console = Content\new!
    @battryC = Content\new!
    @heatC = Content\new!
    @procC = Content\new!
    @interC = Content\new!

    --logos
    lBattry = ImageCanvas\new Graphics.newImage("assets/battery.png")
    lBattry\setPos 1, 0.5
    lcpu = ImageCanvas\new Graphics.newImage("assets/cpu.png")
    lcpu\setPos 1, 1
    lheat = ImageCanvas\new Graphics.newImage("assets/heat.png")
    lheat\setPos 0, 1
    linter = ImageCanvas\new Graphics.newImage("assets/internet.png")
    linter\setPos 1, 0


    @Text = SelectOpt\new Fonts.Pixel,
      "Press F to open the Coffer.", Colors.mediumseagreen, 15



    with @playerPopUp
      \setSize 16, 16
      \setPos 0, 0
      \setEnabled false
      \setFont 'assets/fonts/falling-sky-font/FallingSkyCondensed-9qm2.otf'
      \setFontColor Colors.mediumseagreen
      \setDrawBorder true
      \setFontSize 14
      \setBorder 1.5
      \flashOn!
      \setVisible false
      \setText "E"



    with @exit
      \setSize 20, 20
      \setPos opts.gameW - 20 - @padding, @padding
      \setEnabled true
      \setText "X"
      \onClick ->
        Event = love.event
        Event.quit!

    with @settings
      \setSize 20, 20
      \setPos opts.gameW - 20 - @padding, @padding + 25
      \setEnabled true
      \setIcon 'assets/Settings.png'
      \setPadding 4
      \onClick ->
        return

    with @console
      \setSize 230, 45
      \setEnabled false
      \setPos 200, @padding
      \setStroke 2

    with @battryC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26, @padding
      \setStroke 2
      \addChild lBattry

    with @heatC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26, @padding + 22.5
      \setStroke 2
      \addChild lheat

    with @procC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26 + 86.5, @padding + 22.5
      \setStroke 2
      \addChild lcpu

    with @interC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26 + 86.5, @padding
      \setStroke 2
      \addChild linter



      --\setDrawBorder true
      --\setText "Coin : 500"
      --\setDisableColor Colors.black


    with @Text
      \setPos 5, 5
      \setDrawBg false


    --@console\addChild @Coin, 2
    --@battryC\addChild @Power

    @initCoffer!
    @initGatewayComputer!


    @root\addChildCore @exit
    @root\addChildCore @settings
    @root\addChildCore @console
    @root\addChildCore @battryC
    @root\addChildCore @heatC
    @root\addChildCore @procC
    @root\addChildCore @interC
    @root\addChildCore @playerPopUp


  .initCoffer = =>
    @cofferSlots = {}

    for i = 22, 1, -1
      @cofferSlots[i] = Button\new!

    oy = 2.5
    x = 5
    _i = 1

    for i, v in ipairs @cofferSlots
      if _i == 12
        oy += 20
        _i = 1
      with @cofferSlots[i]
        \setSize 20, 20
        \setEnabled false
        \setPos x + (_i-1)*20, oy
        \setStroke 1
        \setEnabled true
      _i += 1

  .initGatewayComputer = =>
    Graphics = love.graphics

    @coinC = Content\new!
    @updateC = Button\new!
    @networksC = Button\new!
    @minebBtn = Button\new!
    lcoin = ImageCanvas\new Graphics.newImage("assets/coin.png")
    lcoin\setPos 2, 3

    with @minebBtn
      \setSize 20, 21
      \setPos 60, 1
      \setEnabled true
      \setFont Fonts.Pixel
      \setUpColor Colors.black
      \setHoverColor Colors.crimson
      \onHover =>
        @setFontColor Colors.black
      \onLeave =>
        @setFontColor Colors.white
      \setDownColor Colors.cornsilk
      \setBorderColor Colors.yellow
      \setFontSize 8
      \setText "Mine"

    with @updateC
      \setSize 60.5, 22.5
      \setPos 90, 10
      \setFont Fonts.Pixel
      \setBorderColor Colors.black
      \setText "Update"

    with @networksC
      \setSize 70.5, 22.5
      \setPos 155, 10
      \setFont Fonts.Pixel
      \setBorderColor Colors.black
      \setText "Network"

    with @coinC
      \setSize 80.5, 22.5
      \setEnabled false
      \setStrokeColor Colors.yellow
      \setPos 5, 10
      \setStroke 1
      \addChild @minebBtn
      \addChild lcoin


  .showGatewayComputer = =>
    @computerOn = true
    @console\addChild @coinC
    @console\addChild @updateC
    @console\addChild @networksC

  .hideGatewayComputer = =>
    @computerOn = false
    @console\removeChild @coinC
    @console\removeChild @updateC
    @console\removeChild @networksC

  .showCoffer = =>
    @cofferOn = true
    for i, v in ipairs @cofferSlots
      @console\addChild @cofferSlots[i]

  .hideCoffer = =>
    @cofferOn = false
    for i, v in ipairs @cofferSlots
      @console\removeChild @cofferSlots[i]











Menu
