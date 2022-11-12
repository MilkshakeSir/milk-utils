--Services
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = Instance.new("Folder", ReplicatedStorage)
Cache.Name = "Cache"

function loop(item)
	for i, v in pairs(item) do
		print(i, v)
	end
end

local function ImportAsset(itemId: number)
	local List = Cache:GetChildren()

	loop(List)

	if Cache:FindFirstChild(itemId) then
		warn("Item found in cache")
		return Cache:FindFirstChild(itemId)
	else
		local object

		local work, errorMsg = pcall(function()
			object = InsertService:LoadAsset(itemId)
		end)

		if object then
			for i, v in pairs(object:GetChildren()) do
				local item = v:Clone()
				item.Name = tostring(itemId)
				item.Parent = Cache

				return v
			end
		end
	end
end

return ImportAsset
