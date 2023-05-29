local cameraModule = {}
local rs = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local camera = game.Workspace.CurrentCamera
local TweenData = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local TweenService = game:GetService("TweenService")

if not rs:IsClient() then
	warn("The script has to be run on the client to work, use a remote to use on the server.")
end

function cameraModule:LookAtPart(part: Part)
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CameraSubject = part
	camera.CFrame = part.CFrame
end

function cameraModule:TweenPart(part: Part, tweenInfo: TweenInfo)
	camera.CameraType = Enum.CameraType.Scriptable

	local tween = TweenService:Create(camera, tweenInfo, { CFrame = part.CFrame })
	tween:Play()
end

function cameraModule:Clear()
	camera.CameraSubject = Character.Humanoid
	camera.CameraType = Enum.CameraType.Custom
end

return cameraModule
