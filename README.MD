# milk-utils

Here are some modules I made when making my games.

## CameraModule

- [Link](https://github.com/MilkdevNew/GameUtils/blob/master/Code/CameraModule.lua)
- [Raw](https://raw.githubusercontent.com/MilkdevNew/GameUtils/master/Code/CameraModule.lua)

I made this module because most of the time I forget on how to move the camera so I made this module

> ⚠️ Run the module on the client

**API**

LookAtPart

```lua
local CameraModule = require(path.to.module)
CameraModule:LookAtPart(part:Part) -- Change the camera CFrame too the part
```

TweenPart

```lua
local CameraModule = require(path.to.module)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
CameraModule:TweenPart(part,tweenInfo) -- Tweens the camera
```

> ⚠️ You need to pass in the a tweenInfo object into the function

Clear

```lua
local CameraModule = require(path.to.module)
CameraModule:Clear() -- Reset the camera
```

## DeviceChecker

- [Link](https://github.com/MilkdevNew/GameUtils/blob/master/Code/DeviceChecker.lua)
- [Raw](https://raw.githubusercontent.com/MilkdevNew/GameUtils/master/Code/DeviceChecker.lua)

Return the boolean value for the device function

Examples

Using a computer

`isComputer() ---> true`
`isTouchDevice() ---> false`

Using a phone

`isComputer() ---> false`
`isTouchDevice() ---> true`

Here are the available function

- _isComputer_
- _isTouchDevice_
- _isXbox_
- _isVr_

## ImportAsset

- [Link](https://github.com/MilkdevNew/GameUtils/blob/master/Code/ImportAsset.lua)
- [Raw](https://raw.githubusercontent.com/MilkdevNew/GameUtils/master/Code/ImportAsset.lua)

This function is use to import avatar item into the game

All imports are put into a cache for faster execution

```lua
local ImportAsset = require(path.to.module)
local item = ImportAsset(id) -- Return a Instance and saves the instance in the cache
```
