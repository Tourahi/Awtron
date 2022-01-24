-- controls
MManager = MeowC.core.Manager
SelectOpt = assert require 'src/Controls/SelectOpt'
CButton = assert require 'src/Controls/CircleButton'
Button = assert require 'src/Controls/Button'
Content = assert require 'src/Controls/Content'
ImageCanvas = assert require 'src/Controls/ImageCanvas'
ProgressBar = assert require 'src/Controls/ProgressBar'
Inv = assert require 'src/Inventory'
Items = assert require 'src/items'
Colors = MeowC.core.Colors
Menu = {}


with Menu
  .init = (player) =>
    Graphics = love.graphics

    @padding = 16 + 10 -- 16 size of the wall tile

    @root = MManager\getInstanceRoot!

    @player = player
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

    -- Specs controls
    @heatBar = ProgressBar!
    with @heatBar
      \setSize 40,10
      \setPos 30, 6
      \setMaxValue 100
      \setDangerType "mt"
      \setDangerZone 70
      \setDangerColor Colors.red
      \setColor Colors.green

    @batteryBar = ProgressBar!
    with @batteryBar
      \setSize 40,10
      \setPos 30, 6
      \setMaxValue 100
      \setDangerType "lt"
      \setDangerZone 15
      \setDangerColor Colors.red
      \setColor Colors.green

    @Text = SelectOpt\new Fonts.Pixel,
      "Press F to open the Coffer.", Colors.mediumseagreen, 15

    @Cpu = SelectOpt\new Fonts.Pixel,
      "0%", Colors.white, 15
    @Cpu\setPos 45, 1.5
    @Cpu\setDrawBg false

    @Net = SelectOpt\new Fonts.Pixel,
      "0%", Colors.white, 15
    @Net\setPos 45, 1.5
    @Net\setDrawBg false



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
        Sounds.select\play!
        Event = love.event
        Event.quit!

    with @settings
      \setSize 20, 20
      \setPos opts.gameW - 20 - @padding, @padding + 25
      \setEnabled true
      \setIcon 'assets/Settings.png'
      \setPadding 4
      \setEnabled false
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
      \addChild @batteryBar

    with @heatC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26, @padding + 22.5
      \setStroke 2
      \addChild lheat
      \addChild @heatBar

    with @procC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26 + 86.5, @padding + 22.5
      \setStroke 2
      \addChild lcpu
      \addChild @Cpu

    with @interC
      \setSize 80.5, 22.5
      \setEnabled false
      \setPos 26 + 86.5, @padding
      \setStroke 2
      \addChild linter
      \addChild @Net


    with @Text
      \setPos 5, 5
      \setDrawBg false


    @initCoffer!
    @initGatewayComputer!
    @initItemInfo!
    @initMiniScreen!
    @initChargeView!


    @root\addChildCore @exit
    @root\addChildCore @settings
    @root\addChildCore @console
    @root\addChildCore @battryC
    @root\addChildCore @heatC
    @root\addChildCore @procC
    @root\addChildCore @interC
    @root\addChildCore @playerPopUp


  .showStart = =>
    @root = MManager\getInstanceRoot!
    @Start = SelectOpt\new Fonts.FD,
      "Awtron", Colors.blueviolet, 150
    @Start\setEnabled false
    @startbtn = Button\new!

    with @startbtn
      \setPos 380, 300
      \setSize 200, 50
      \setText "Start"
      \setFont Fonts.FD
      \onClick =>
        Sounds.startGame\play!
        Menu.root\removeChildCore Menu.Start
        Menu.root\removeChildCore Menu.startbtn
        Menu.Start = nil
        Menu.startbtn = nil
        Utils.room.gotoRoom 'Stage'

    @Start\setPos 140, 100

    @root\addChildCore @Start
    @root\addChildCore @startbtn

  .showDead = =>
    @root = MManager\getInstanceRoot!
    @Start = SelectOpt\new Fonts.FD,
      "Dead. RIPBOZO.", Colors.blueviolet, 90
    @Start\setEnabled false
    @startbtn = Button\new!

    with @startbtn
      \setPos 380, 300
      \setSize 200, 50
      \setText "End."
      \setFont Fonts.FD
      \onClick =>
        Sounds.select\play!
        Event = love.event
        Menu.root\removeChildCore Menu.Start
        Menu.root\removeChildCore Menu.startbtn
        Menu.Start = nil
        Menu.startbtn = nil
        Event.quit!


    @Start\setPos 140, 100

    @root\addChildCore @Start
    @root\addChildCore @startbtn


  .initChargeView = =>
    @chargeView = Content\new!
    @chargeVal = SelectOpt\new Fonts.BPixel,
      0, Colors.white, 8
    @chargeVal\setDrawBg false
    @chargeVal\setPos 2,5
    with @chargeView
      \setSize 20, 20
      \setEnabled false
      \setPos 422, 118
      \setStroke 2
      \addChild @chargeVal



  .addChargeView = =>
    Sounds.charge\play!
    @root\addChildCore @chargeView

  .removeChargeView = =>
    @root\removeChildCore @chargeView

  .initItemInfo = =>

    with @itemType = SelectOpt\new Fonts.BPixel, "", Colors.white, 15
      \setPos 15, 1.5
      \setDrawBg false

    with @itemProperty = SelectOpt\new Fonts.BPixel, "", Colors.white, 15
      \setPos 15, 25
      \setDrawBg false

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

  .checkTransaction = (price) =>
    if Inv.coin >= price
      Inv.coin -= price
      return true
    return false


  .initMiniScreen = =>
    Graphics = love.graphics
    @MiniScreen = Content\new!
    @priceScreen = Content\new!
    @buyBtn = Button\new!
    @price = SelectOpt\new Fonts.BPixel,
      0, Colors.darkorange, 15

    @price\setDrawBg false
    @price\setPos 5, 0
    @price\setEnabled false

    @itemSlots = {}
    for i = #Items, 1, -1
      @itemSlots[i] = Content\new!

    oy = 8
    x = 10
    _i = 1

    for i, v in ipairs @itemSlots
      if _i == 7 --math.floor(#Items/2) + 1
        oy += 20
        _i = 1

      logo = {}
      with Items[i].icon = ImageCanvas\new Graphics.newImage(Items[i].icon)
        \setPos 1, 0.5
      Items[i].icon.p = Items[i].p
      Items[i].icon.id = Items[i].id
      Items[i].icon.it = Items[i].type
      Items[i].icon.ip = Items[i].property
      Items[i].icon.power = Items[i].power
      Items[i].icon.chargeRate = Items[i].chargeRate
      Items[i].icon.dischargeRate = Items[i].dischargeRate

      --@itemType
      --@itemProperty
      Items[i].icon\onClick =>
        Sounds.select\play!
        Menu.buyBtn\setEnabled true
        Menu.buyBtn\setText "Buy"

        if @chargeRate == nil
          Menu.price\setText @p
          Menu.itemType\setText @it
          Menu.itemProperty\setText @ip ..' : '.. @power
          Menu.selectedShopItem = @id
        else
          Menu.price\setText @p
          Menu.itemType\setText @it
          Menu.itemProperty\setText @ip ..' : '.. @chargeRate .. '/' .. @dischargeRate
          Menu.selectedShopItem = @id

      with @itemSlots[i]
        \setSize 20, 20
        \setEnabled false
        \setPos x + (_i-1)*20, oy
        \setStroke 1
        \setEnabled true
        \addChild Items[i].icon
      _i += 1

    for i, v in ipairs @itemSlots
      @MiniScreen\addChild @itemSlots[i]

    with @buyBtn
      \setSize 50, 20
      \setPos 161, 30
      \setEnabled true
      \setFont Fonts.BPixel
      \setUpColor Colors.black
      \setHoverColor Colors.green
      \setDisableColor Colors.crimson
      \setDownColor Colors.mediumseagreen
      \setText "Buy"
      \onClick =>
        for i, item in pairs Items
          if item.icon.id == Menu.selectedShopItem
            if Menu\checkTransaction(item.icon.p)
              table.insert Inv.items, item.icon
              Menu.itemSlots[i]\removeChild item.icon
              Menu.buyBtn\setEnabled false
              Menu.buyBtn\setText "Done"
              Menu.buyBtn\setDisableColor Colors.green
              Menu.player\equipe item.icon
              Sounds.upgrade\play!
            else
              Menu.buyBtn\setEnabled false
              Menu.buyBtn\setText "Failed"
              Menu.buyBtn\setDisableColor Colors.red
              Menu.player\equipe item.icon

    with @priceScreen
      \setSize 50, 20
      \setPos 161, 6
      \setStroke 1
      \addChild @price

    with @MiniScreen
      \setSize 216, 54
      \setPos 116, 100
      \setBackgroundColor Colors.black
      \setStroke 1
      \setEnabled false
      \setVisible true
      \addChild @priceScreen
      \addChild @buyBtn

  .initShop = =>
    @itemType\setText ""
    @itemProperty\setText ""
    @console\addChild @itemType
    @console\addChild @itemProperty
    @root\addChildCore @MiniScreen

  .removeShop = =>
    @console\removeChild @itemType
    @console\removeChild @itemProperty
    @root\removeChildCore @MiniScreen

  .initGatewayComputer = =>
    Graphics = love.graphics

    @coinC = Content\new!
    @updateC = Button\new!
    @shop = Button\new!
    @mineBtn = Button\new!
    lcoin = ImageCanvas\new Graphics.newImage("assets/coin.png")
    lcoin\setPos 2, 3
    @coinV = SelectOpt\new Fonts.BPixel,
      Inv.coin, Colors.darkorange, 15
    @coinV\setPos 20, 1.1
    @coinV\setDrawBg false

    player = @player

    with @mineBtn
      \setSize 20, 21
      \setPos 60, 1
      \setEnabled true
      \setFont Fonts.Pixel
      \setUpColor Colors.black
      \setHoverColor Colors.crimson
      \setDisableColor Colors.crimson
      \onHover =>
        @setFontColor Colors.black
      \onLeave =>
        @setFontColor Colors.white
      \setDownColor Colors.cornsilk
      \setBorderColor Colors.yellow
      \setFontSize 8
      \setText "Mine"
      \onClick =>
        --player\freez true
        Sounds.select\play!
        player\mine!
        Menu.playerPopUp\setText "S"
        Menu.playerPopUp\setVisible true


    with @updateC
      \setSize 60.5, 22.5
      \setPos 90, 10
      \setFont Fonts.Pixel
      \setBorderColor Colors.black
      \setText "Update"
      \setEnabled false

    with @shop
      \setSize 70.5, 22.5
      \setPos 155, 10
      \setFont Fonts.Pixel
      \setBorderColor Colors.black
      \setText "Shop"
      \onClick =>
        Sounds.select\play!
        Menu\hideGatewayComputer!
        Menu\initShop!

    @mineBar = ProgressBar!
    with @mineBar
      \setSize 60.5,22.5
      \setPos 0, 0
      \setDepth -1
      \setValue 1
      \setMaxValue 100
      \setBgAlpha 0
      \setColor Colors.gold
      \setEnabled false

    with @coinC
      \setSize 80.5, 22.5
      \setEnabled false
      \setStrokeColor Colors.yellow
      \setPos 5, 10
      \setStroke 1
      \addChild lcoin
      \addChild @coinV
      \addChild @mineBtn
      \addChild @mineBar

    @coinC\sortChildren!



  .showGatewayComputer = =>
    @computerOn = true
    @coinC\sortChildren!
    @console\addChild @coinC
    @console\addChild @updateC
    @console\addChild @shop



  .hideGatewayComputer = =>
    @computerOn = false
    @console\removeChild @coinC
    @console\removeChild @updateC
    @console\removeChild @shop

  .showCoffer = =>
    @cofferOn = true
    invItemsNum = #Inv.items
    if invItemsNum > 0
      for i, item in ipairs Inv.items
        item\setEnabled false
        item\onClick =>
          Sounds.select\play!
          @parent\setDisableColor Colors.silver
        if item.it == "battery"
          @cofferSlots[1]\addChild item
        elseif item.it == "cpu"
          @cofferSlots[2]\addChild item
        elseif item.it == "wifi card"
          @cofferSlots[3]\addChild item
        elseif item.it == "fan"
          @cofferSlots[4]\addChild item
    for i, v in ipairs @cofferSlots
      @console\addChild @cofferSlots[i]

  .hideCoffer = =>
    @cofferOn = false
    for i, v in ipairs @cofferSlots
      @console\removeChild @cofferSlots[i]











Menu
