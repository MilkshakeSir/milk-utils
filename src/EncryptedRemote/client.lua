local HttpService = game:GetService("HttpService")

local ECC = require(script.Parent.EllipticCurveCryptography)

local HandshakeRemote = script.Parent:WaitForChild("Handshake")

local clientPrivate, clientPublic = ECC.keypair(ECC.random.random())
local serverPublic = HandshakeRemote:InvokeServer(clientPublic)
local sharedSecret = ECC.exchange(clientPrivate, serverPublic)

return function(Remote)
	local Wrapper = setmetatable({}, { __index = Remote })
	Wrapper.backend = Instance.new("BindableEvent")
	Wrapper.OnClientEvent = Wrapper.backend.Event

	function Wrapper:FireServer(...)
		local args = table.pack(...)
		local data = HttpService:JSONEncode(args)

		local encryptedData = ECC.encrypt(data, sharedSecret)
		local signature = ECC.sign(clientPrivate, data)

		Remote:FireServer(encryptedData, signature)
	end

	Remote.OnClientEvent:Connect(function(encryptedData, signature)
		warn(encryptedData, signature)
		setmetatable(encryptedData, ECC._byteMetatable)
		setmetatable(signature, ECC._byteMetatable)

		local data = ECC.decrypt(encryptedData, sharedSecret)
		local verified = ECC.verify(serverPublic, data, signature)

		if not verified then
			warn("Could not verify signature", Remote.instance.Name)
			return
		end
		local args = HttpService:JSONDecode(tostring(data))
		Wrapper.backend:Fire(table.unpack(args))
	end)

	return Wrapper
end
