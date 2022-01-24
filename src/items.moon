
return {
  [1]: {
    id: UID!
    icon: "assets/items/batr1.png"
    chargeRate: 20 -- +15% every 30s
    dischargeRate: 15 -- -10% every 30s
    p: 50
    property: "C/D rates"
    type: "battery"
  }
  [2]: {
    id: UID!
    icon: "assets/items/batr2.png"
    chargeRate: 25
    dischargeRate: 10
    property: "C/D rates"
    p: 100
    type: "battery"
  }
  [3]: {
    id: UID!
    icon: "assets/items/batr3.png"
    chargeRate: 30
    dischargeRate: 2.5
    property: "C/D rates"
    p: 200
    type: "battery"
  }

  [4]: {
    id: UID!
    icon: "assets/items/wifiC1.png"
    power: 50
    property: "Range"
    p: 20
    type: "wifi card"
  }
  [5]: {
    id: UID!
    icon: "assets/items/wifiC2.png"
    power: 75
    p: 50
    property: "Range"
    type: "wifi card"
  }
  [6]: {
    id: UID!
    icon: "assets/items/wifiC3.png"
    power: 100
    p: 100
    property: "Range"
    type: "wifi card"
  }

  [7]: {
    id: UID!
    icon: "assets/items/fan1.png"
    power: 40
    p: 50
    property: "Cooling"
    type: "fan"
  }
  [8]: {
    id: UID!
    icon: "assets/items/fan2.png"
    power: 25
    p: 100
    property: "Cooling"
    type: "fan"
  }
  [9]: {
    id: UID!
    icon: "assets/items/fan3.png"
    power: 10
    p: 200
    property: "Cooling"
    type: "fan"
  }

  [10]: {
    id: UID!
    icon: "assets/items/cpu1.png"
    power: 5
    property: "Speed"
    p: 50
    type: "cpu"
  }
  [11]: {
    id: UID!
    icon: "assets/items/cpu2.png"
    power: 10
    property: "Speed"
    p: 100
    type: "cpu"
  }
  [12]: {
    id: UID!
    icon: "assets/items/cpu3.png"
    power: 20
    property: "Speed"
    p: 200
    type: "cpu"
  }

}
