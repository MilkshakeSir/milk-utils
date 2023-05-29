--Services
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = Instance.new("Folder", ReplicatedStorage)
Cache.Name = "Cache"

local function ImportAsset(itemId: number)
	local List = Cache:GetChildren()
	if Cache:FindFirstChild(itemId) then
		local CloneObject = Cache:FindFirstChild(itemId):Clone()
		return CloneObject
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
