--!native
-- Path: StarterPlayer.StarterPlayerScripts.FustAnimShield
-- Full Reconstructed Source (Exposed LPH_NO_VIRTUALIZE Functions + Runtime Loop)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Fust = ReplicatedStorage:WaitForChild("Fust", 30)

local CONFIG = {
	MAX_ID_LEN = 128,
	VERDICTS = 512,
	REREAD = 2.0,
	SCAN_INTERVAL = 0.25,
}

local PATTERN_ASSET_ID = "^rbxassetid://%d+$"
local PATTERN_RBX_ASSET = "^http[s]?://www%.roblox%.com/asset/%?id=%d+$"
local PATTERN_LOWER_1 = "rbxassetid://(%d+)"
local PATTERN_LOWER_2 = "id=(%d+)"

local verdictCache: { [string]: boolean } = {}
local verdictCount = 0

local staticWhitelist: { [string]: boolean } = {}
local dynamicWhitelist: { [string]: boolean } = {}
local lastReadClock = 0

local acFlagged = false
local acCounter = 0
local acPrngState = 0

-- ============================================================================
-- EXPOSED LPH_NO_VIRTUALIZE FUNCTIONS FROM VM TABLE
-- ============================================================================

-- [VM Index 11]: Immediately stop and destroy unauthorized AnimationTrack
local function stopAndDestroyTrack(track: AnimationTrack)
	pcall(function()
		track:Stop(0)
	end)
	pcall(function()
		track:Destroy()
	end)
end

-- [VM Index 49]: Validate AnimationId format and length with 512-entry cache
local function isValidAnimationId(
	animId: any,
	patternAssetId: string,
	patternRbxAsset: string,
	patternLower1: string,
	patternLower2: string
): boolean
	if type(animId) ~= "string" then
		return false
	end
	if #animId == 0 then
		return false
	end
	if #animId > CONFIG.MAX_ID_LEN then
		return false
	end

	local cached = verdictCache[animId]
	if cached ~= nil then
		return cached
	end

	local isValid = string.match(animId, patternAssetId) ~= nil
		or string.match(animId, patternRbxAsset) ~= nil

	if not isValid then
		local lowered = string.lower(animId)
		isValid = string.match(lowered, patternLower1) ~= nil
			or string.match(lowered, patternLower2) ~= nil
	end

	if verdictCount >= CONFIG.VERDICTS then
		table.clear(verdictCache)
		verdictCount = 0
	end

	verdictCache[animId] = isValid
	verdictCount += 1
	return isValid
end

-- [VM Index 110]: Check AnimationId against static & dynamic Whitelist
local function isWhitelistedAnimation(
	animId: string,
	readWhitelistFn: (Instance?) -> { [string]: boolean },
	sourceContainer: Instance?
): boolean
	if staticWhitelist[animId] then
		return true
	end
	if dynamicWhitelist[animId] then
		return true
	end

	local now = os.clock()
	if now - lastReadClock < CONFIG.REREAD then
		return false
	end

	dynamicWhitelist = readWhitelistFn(sourceContainer)
	lastReadClock = now
	return dynamicWhitelist[animId] == true
end

-- [VM Index 86]: Flag violation and advance LCG PRNG state
local function triggerShieldViolation()
	acFlagged = true
	acCounter = acCounter - (acCounter % 2) + 1
	acPrngState = (656243 * acPrngState + 265347219) % 268435456
	acPrngState = (1006351 * acPrngState + 145847241) % 268435456
end

-- [VM Index 61 & 111]: Action dispatcher
local function invokeAction(handlerFn: (any) -> (), targetArg: any)
	handlerFn(targetArg)
end

-- ============================================================================
-- RUNTIME SHIELD CONTROLLER
-- ============================================================================

local function collectAllowedAnimations(rootContainer: Instance?): { [string]: boolean }
	local allowed: { [string]: boolean } = {}

	local function scanInstance(inst: Instance?)
		if not inst then
			return
		end
		for _, desc in ipairs(inst:GetDescendants()) do
			if desc:IsA("Animation") and desc.AnimationId ~= "" then
				allowed[desc.AnimationId] = true
			end
		end
	end

	scanInstance(rootContainer)
	if LocalPlayer.Character then
		local animateScript = LocalPlayer.Character:FindFirstChild("Animate")
		scanInstance(animateScript)
	end

	return allowed
end

local function inspectAnimationTrack(track: AnimationTrack)
	local anim = track.Animation
	local animId = anim and anim.AnimationId or ""

	local formatOk = isValidAnimationId(
		animId,
		PATTERN_ASSET_ID,
		PATTERN_RBX_ASSET,
		PATTERN_LOWER_1,
		PATTERN_LOWER_2
	)

	if not formatOk then
		invokeAction(stopAndDestroyTrack, track)
		triggerShieldViolation()
		return
	end

	local whitelisted = isWhitelistedAnimation(animId, collectAllowedAnimations, Fust)
	if not whitelisted then
		invokeAction(stopAndDestroyTrack, track)
		triggerShieldViolation()
		return
	end
end

local activeConnections: { RBXScriptConnection } = {}

local function cleanupConnections()
	for _, conn in ipairs(activeConnections) do
		conn:Disconnect()
	end
	table.clear(activeConnections)
end

local function attachToCharacter(character: Model)
	cleanupConnections()

	local humanoid = character:WaitForChild("Humanoid", 15)
	if not (humanoid and humanoid:IsA("Humanoid")) then
		return
	end

	local animate = character:FindFirstChild("Animate")
	if animate then
		for _, desc in ipairs(animate:GetDescendants()) do
			if desc:IsA("Animation") and desc.AnimationId ~= "" then
				staticWhitelist[desc.AnimationId] = true
			end
		end
	end

	local animator = humanoid:WaitForChild("Animator", 15) :: Animator?
	if animator and animator:IsA("Animator") then
		table.insert(
			activeConnections,
			animator.AnimationPlayed:Connect(function(track)
				inspectAnimationTrack(track)
			end)
		)

		local lastScan = 0
		table.insert(
			activeConnections,
			RunService.Heartbeat:Connect(function()
				local now = os.clock()
				if now - lastScan < CONFIG.SCAN_INTERVAL then
					return
				end
				lastScan = now

				for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
					inspectAnimationTrack(track)
				end
			end)
		)
	end
end

if Fust then
	for _, desc in ipairs(Fust:GetDescendants()) do
		if desc:IsA("Animation") and desc.AnimationId ~= "" then
			staticWhitelist[desc.AnimationId] = true
		end
	end
end

if LocalPlayer.Character then
	task.spawn(attachToCharacter, LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(attachToCharacter)
