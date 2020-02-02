-- init script, adapted from: https://nodemcu.readthedocs.io/en/master/upload/#initlua

dofile("credentials.lua")

function startup()
  dofile("application.lua")
end

wifi_connected_event = function(event, info)
  wifi.sta.sethostname(STATION_NAME)
end

wifi_got_ip_event = function(event, info)
  print("Wifi connection is ready! IP address is: " .. info.ip)
  print("Startup will resume momentarily, you have 3 seconds to abort...")
  tmr.create():alarm(3000, tmr.ALARM_SINGLE, startup)
end

print("Connecting to WiFi access point...")
wifi.start()
wifi.mode(wifi.STATION)
wifi.sta.config({ssid=SSID, pwd=PASSWORD})
wifi.sta.on("connected", wifi_connected_event)
wifi.sta.on("got_ip", wifi_got_ip_event)
