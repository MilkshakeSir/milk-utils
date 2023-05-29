local DeviceFinder = {}
local UserInputService = game:GetService("UserInputService")

function DeviceFinder.getDevice()
	local deviceInfo
	local lastInput = UserInputService:GetLastInputType()

	-- Computer check
	if UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		if UserInputService.TouchEnabled then
			deviceInfo = "NOW"
		else
			deviceInfo = "PC"
		end
	else
		deviceInfo = "PHONE"
	end

	if deviceInfo then
		return deviceInfo
	else
		return "NIL"
	end
end

return DeviceFinder
