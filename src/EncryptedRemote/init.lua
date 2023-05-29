if game:GetService("RunService"):IsServer() then
	return require(script.server)
else
	return require(script.client)
end
