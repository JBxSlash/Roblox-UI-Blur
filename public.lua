local module = {}

local camera = workspace.CurrentCamera
local screenSizeX = camera.ViewportSize.X
local screenSizeY = camera.ViewportSize.Y

local offset = 0.28
local scale = 0.000182908 * (2160 / camera.ViewportSize.Y)
local blurscaleoffset = Vector2.new(-22 * scale, -22 * scale)

local dof = Instance.new("DepthOfFieldEffect")
dof.Parent = game:GetService("Lighting")
dof.FarIntensity = 0
dof.FocusDistance = 11
dof.InFocusRadius = 10
dof.NearIntensity = 1
dof.Name = "UIBlurEffect"

function module.new(ui)
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.Parent = workspace
	p.Name = "UIBlurHub | ".. tostring(ui.Name)
	p.Size = Vector3.new(.01,.01,0)
	p.Transparency = 0.5
	p.Material = Enum.Material.Glass
local a = {
			p,
			Vector3.new(),
			ui
		}
	local carage = game:GetService("RunService").RenderStepped:Connect(function()
		camera = workspace.CurrentCamera
		local scale = 0.000182908 * (2160 / camera.ViewportSize.Y)
local blurscaleoffset = Vector2.new(-22 * scale, -22 * scale)
		local NewSize = Vector2.new(
			a[3].AbsoluteSize.X * scale,
			a[3].AbsoluteSize.Y * scale
		)
		local NewPosition = Vector2.new(
			a[3].AbsolutePosition.X * scale,
			a[3].AbsolutePosition.Y * scale
		)
		local Screen = Vector2.new(
			(camera.ViewportSize.X * scale) / 2, 
			-(camera.ViewportSize.Y * scale) / 2
		)

		local Corner = Vector3.new(NewSize.X / 2, -(NewSize.Y / 2), 0) + Vector3.new(-Screen.X, -Screen.Y, 0)
		a[2] = Corner + Vector3.new(NewPosition.X, -NewPosition.Y - (36 * scale), 0)
		a[1].CFrame = camera.CFrame * CFrame.new(Vector3.new(0, 0, -offset)) * CFrame.new(a[2])
		a[1].Size = Vector3.new(NewSize.X, NewSize.Y, 0) + Vector3.new(blurscaleoffset.X, blurscaleoffset.Y, 0)
	end)
	local j = {}
	function j:Destroy()
		carage:Disconnect()
		p:Destroy()
	end
	return j
end

return module
