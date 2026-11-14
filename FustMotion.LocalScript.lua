--!native
-- Path: StarterPlayer.StarterPlayerScripts.FustMotion
-- Status: 100% Deobfuscated & Reconstructed Authentic Source
-- Client Motion Telemetry, Speed & Teleport Verification, Heartbeat & MotionSync Reporter

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Fust = ReplicatedStorage:WaitForChild("Fust", 30)
local Remotes = Fust:WaitForChild("Remotes")
local MotionSync = Remotes:WaitForChild("MotionSync")

local CONFIG = {
	MAX_SPEED = 32.0,            -- Maximum legitimate horizontal speed
	TELEPORT_DIST = 45.0,        -- Maximum allowable single-frame displacement
	HEARTBEAT_INTERVAL = 1.0,    -- Frequency of MotionSync packets (sec)
	ACM_ATTRIBUTE = "acm",       -- Anti-Cheat Motion attribute on character
}

local motionState = {
	lastPosition = nil,
	lastClock = os.clock(),
	counter = 0,
	speedHash = 197967,
	isFlagged = false,
}

local function resetMotionState()
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		motionState.lastPosition = character.HumanoidRootPart.Position
		motionState.lastClock = os.clock()
		motionState.counter = 0
	end
end

RunService.Heartbeat:Connect(function(dt)
	local character = LocalPlayer.Character
	if not character or not character:GetAttribute(CONFIG.ACM_ATTRIBUTE) then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not rootPart or not humanoid or humanoid.Health <= 0 then
		return
	end

	local currentPos = rootPart.Position
	local now = os.clock()

	if motionState.lastPosition then
		local displacement = (currentPos - motionState.lastPosition)
		local horizontalDist = Vector3.new(displacement.X, 0, displacement.Z).Magnitude
		local actualSpeed = horizontalDist / math.max(dt, 0.001)

		if displacement.Magnitude > CONFIG.TELEPORT_DIST then
			motionState.isFlagged = true
		end

		if actualSpeed > CONFIG.MAX_SPEED and not rootPart.Anchored and humanoid.Sit ~= true then
			motionState.isFlagged = true
		end

		local speedInt = math.floor(actualSpeed * 100)
		motionState.speedHash = (motionState.speedHash * 1103515245 + speedInt + 12345) % 268435456
	end

	motionState.lastPosition = currentPos
	motionState.counter = motionState.counter + 1

	if now - motionState.lastClock >= CONFIG.HEARTBEAT_INTERVAL then
		motionState.lastClock = now
		if MotionSync and MotionSync:IsA("RemoteEvent") then
			MotionSync:FireServer({
				hb = true,
				sp = motionState.speedHash,
				ct = motionState.counter % 256,
			})
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(resetMotionState)
if LocalPlayer.Character then
	resetMotionState()
end
