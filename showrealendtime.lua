-- shows the actual (clock) end time of a file when played. So you have a definitive end time rather than calculating the time

function descriptor()
  return {
    title = "Show Real End Time",
    version = "0.0.1",
    author = "David Brown",
    capabilities = { "playing-listener" }
  }
end

function activate()
  updateEndTime()
end

function deactivate() 
end

function meta_changed()
end

function playing_changed()
  updateEndTime()
end

function getTimeLeft()
	-- get elapsed time in seconds
	local current = vlc.var.get(vlc.object.input(), "time")
	-- get duration in seconds
	local duration = vlc.input.item():duration()
  return duration - current
end

function updateEndTime()
  local timeLeft = getTimeLeft()
  local currentTime = os.time(t)
  local endTime = os.date("%I:%M", currentTime + timeLeft)
  vlc.osd.message( 'End Time: ' .. endTime, vlc.osd.channel_register(), "bottom-right", 3000000)
end
