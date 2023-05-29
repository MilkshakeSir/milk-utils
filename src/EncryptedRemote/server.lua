local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local ECC = require(script.Parent.EllipticCurveCryptography)
local PlayerData = {}

local HandshakeRemote = Instance.new("RemoteFunction")
HandshakeRemote.Name = "Handshake"
HandshakeRemote.Parent = script.Parent

function HandshakeRemote.OnServerInvoke(Player, clientPublic)
	local serverPrivate, serverPublic = ECC.keypair(ECC.random.random())

	PlayerData[Player] = {
		clientPublic = clientPublic,
		serverPublic = serverPublic,
		serverPrivate = serverPrivate,
		sharedSecret = ECC.exchange(serverPrivate, clientPublic),
	}

	return serverPublic
end

return function(Remote: RemoteEvent)
	local Wrapper = setmetatable({}, { __index = Remote })
	Wrapper.backend = Instance.new("BindableEvent")
	Wrapper.OnServerEvent = Wrapper.backend.Event

	Remote.OnServerEvent:Connect(function(Player, encryptedData, signature)
		local secret = PlayerData[Player].sharedSecret
		local clientPublic = PlayerData[Player].clientPublic

		-- Metatables get lost in transit
		setmetatable(encryptedData, ECC._byteMetatable)
		setmetatable(signature, ECC._byteMetatable)

		local data = ECC.decrypt(encryptedData, secret)
		local verified = ECC.verify(clientPublic, data, signature)

		if not verified then
			warn("Could not verify signature", Remote.instance.Name)
			return
		end

		local args = HttpService:JSONDecode(tostring(data))
		Wrapper.backend:Fire(table.unpack(args))
	end)

	function Wrapper:FireClient(Player, ...)
		local secret = PlayerData[Player].sharedSecret
		local private = PlayerData[Player].serverPrivate

		local args = table.pack(...)
		local data = HttpService:JSONEncode(args)

		local encryptedData = ECC.encrypt(data, secret)
		local signature = ECC.sign(private, data)

		Remote:FireClient(Player, encryptedData, signature)
	end

	return Wrapper
end
