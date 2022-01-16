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


    -- Dashboard
    @exit = Button\new!
    @settings = Button\new!
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


    @root\addChildCore @exit
    @root\addChildCore @settings
    @root\addChildCore @console
    @root\addChildCore @battryC
    @root\addChildCore @heatC
    @root\addChildCore @procC
    @root\addChildCore @interC










Menu
