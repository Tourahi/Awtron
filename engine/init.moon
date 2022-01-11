PATH = ...

-- Love based moon modules (classes)
export Shake = assert require PATH..".Shake"
export Input = assert require PATH..".Input"
export Loader = assert require PATH..".Loader"
export Signal = assert require PATH..".Signal"
export Vector2D = assert require PATH..".Vector2D"
export Tiler = assert require PATH..".Tiler"
export Camera = assert require PATH..".Camera"
export Colors = assert require PATH..".Colors"
export Leak = assert require PATH..".Leak"

-- Love based lua modules
export Log = assert require PATH..".external.Log.log"
export Timer = assert require PATH..".external.EnhancedTimer.EnhancedTimer"
assert require PATH..".external.MeowCore"
export Physics = assert require PATH .. '.external.windfield.windfield'
export Animation = assert require PATH..".external.anim8"

with love
  .run = ->
    if love.load
      love.load(love.arg.parseGameArguments(arg), arg)

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer
      love.timer.step!

    dt = 0
    fixedDt = 1/60
    acc = 0
    -- Main loop time.
    return () ->
      -- Process events.
      if love.event
        love.event.pump!
        for name, a,b,c,d,e,f in love.event.poll!
          if name == "quit"
            if not love.quit or not love.quit!
              return a or 0
          love.handlers[name] a,b,c,d,e,f

      -- Update dt, as we'll be passing it to update
      if love.timer
        dt = love.timer.step!
      -- Call update and draw
      acc += dt
      while acc >= fixedDt
        if love.update
          love.update fixedDt
        acc -= fixedDt

      if love.graphics and love.graphics.isActive!
        love.graphics.origin!
        love.graphics.clear love.graphics.getBackgroundColor!

        if love.draw
          love.draw!

        love.graphics.present!

      if love.timer
        love.timer.sleep 0.001
