
export G_baseW = 960
export G_baseH = 640

-- Ingame flags && options
export opts = {}

scale = 2

with opts
  .flashEnabled = true
  .gameScale = 1
  .slow = 1 -- secs
  .scale = scale -- map size 480 - 320
  .gameW = G_baseW / scale
  .gameH = G_baseW / scale
  .DEBUG = false
