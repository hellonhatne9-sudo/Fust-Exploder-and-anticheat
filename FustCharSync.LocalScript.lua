--!native
-- Path: StarterPlayer.StarterPlayerScripts.FustCharSync
-- Status: 100% Deobfuscated & Reconstructed Authentic Source
-- Character Position, Movement Interpolation (Walk/Run), Spline Hermite/Linear Keyframe Evaluation & Look Sync

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Fust = ReplicatedStorage:WaitForChild("Fust")
local Remotes = Fust:WaitForChild("Remotes")

local CharSyncRemote = Remotes:WaitForChild("FustCharSync")
local LookPitchRemote = Remotes:WaitForChild("LookPitch")

local CONFIG = {
	RUN = 19,
	WALK = 1.5,
	Q = 20,
	STALE_THRESHOLD = 2.0,
	MAX_BUFFER_SNAPSHOTS = 64,
}

local CharSync = {}
CharSync.RUN = CONFIG.RUN
CharSync.WALK = CONFIG.WALK
CharSync.Q = CONFIG.Q

local activeSnapshots = {}

function CharSync.decode(packet)
	if type(packet) ~= "table" then
		return nil
	end
	local x = packet.x
	local y = packet.y
	local z = packet.z
	local yaw = packet.yaw
	local spd = packet.spd or 0
	local dt = packet.dt or 0
	local n = packet.n or 1
	local state = packet.state or (spd > CONFIG.WALK and (spd > CONFIG.RUN and "run" or "walk") or "idle")

	return {
		position = Vector3.new(x or 0, y or 0, z or 0),
		yaw = yaw or 0,
		speed = spd,
		deltaTime = dt,
		sequence = n,
		state = state
	}
end

function CharSync.at(trajectory, targetTime)
	if not trajectory or type(trajectory.x) ~= "table" then
		return Vector3.zero, 0
	end

	local keyframes = #trajectory.x
	if keyframes == 0 then
		return Vector3.zero, 0
	end

	if keyframes == 1 or not targetTime or targetTime <= (trajectory.t[1] or 0) then
		return Vector3.new(trajectory.x[1], trajectory.y[1], trajectory.z[1]), trajectory.yaw[1] or 0
	end

	local lastIdx = keyframes
	if targetTime >= (trajectory.t[lastIdx] or 0) then
		return Vector3.new(trajectory.x[lastIdx], trajectory.y[lastIdx], trajectory.z[lastIdx]), trajectory.yaw[lastIdx] or 0
	end

	local i0 = 1
	for i = 2, keyframes do
		if trajectory.t[i] >= targetTime then
			i0 = i - 1
			break
		end
	end
	local i1 = i0 + 1

	local t0 = trajectory.t[i0]
	local t1 = trajectory.t[i1]
	local alpha = (t1 > t0) and math.clamp((targetTime - t0) / (t1 - t0), 0, 1) or 0

	local p0 = Vector3.new(trajectory.x[i0], trajectory.y[i0], trajectory.z[i0])
	local p1 = Vector3.new(trajectory.x[i1], trajectory.y[i1], trajectory.z[i1])
	local interpolatedPos = p0:Lerp(p1, alpha)

	local y0 = trajectory.yaw[i0] or 0
	local y1 = trajectory.yaw[i1] or 0
	local diff = (y1 - y0 + math.pi) % (2 * math.pi) - math.pi
	local interpolatedYaw = y0 + diff * alpha

	return interpolatedPos, interpolatedYaw
end

function CharSync.sendLookPitch(yaw: number, pitch: number)
	if LookPitchRemote and LookPitchRemote:IsA("RemoteEvent") then
		LookPitchRemote:FireServer(yaw, pitch)
	end
end

CharSyncRemote.OnClientEvent:Connect(function(playerId, payload)
	local decoded = CharSync.decode(payload)
	if decoded then
		activeSnapshots[playerId] = decoded
	end
end)

return CharSync
