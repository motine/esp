-- useful resources:
-- https://www.banggood.com/HC-SR501-Adjustable-Infrared-IR-Pyroelectric-PIR-Module-Motion-Sensor-Human-Body-Induction-Detector-p-1545488.html?rmmds=search&cur_warehouse=CN
-- https://nodemcu.readthedocs.io/en/dev-esp32/modules/gpio/

-- we should use a level converter for the PIR sensor
gpio.config({ gpio=13, dir=gpio.IN, pull= gpio.FLOATING })

function inspect()
  print(gpio.read(13))
  -- gpio.write(pin, state)
end

tmr.create():alarm(500, tmr.ALARM_AUTO, inspect)