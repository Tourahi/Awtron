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
    Log.debug "Menu initialized."

    @padding = 16 + 10 -- 16 size of the wall tile

    @root = MManager\getInstanceRoot!


    -- Dashboard
    @exit = Button\new!
    @settings = Button\new!
    @console = Content\new!

    @Coin = SelectOpt\new Fonts.Basteleur,
      "Coin : ", Colors.gray, 10

    @Power = SelectOpt\new Fonts.Basteleur,
      "Power : ", Colors.springgreen, 10


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
      --\setDrawBorder true
      --\setText "Coin : 500"
      --\setDisableColor Colors.black


    with @Coin
      \setPos 5, 5
      \setDrawBg false

    with @Power
      \setPos 26, @padding
      \setDrawBg false

    --@console\addChild @Coin, 2


    @root\addChildCore @exit
    @root\addChildCore @settings
    @root\addChildCore @console
    @root\addChildCore @Power










Menu
