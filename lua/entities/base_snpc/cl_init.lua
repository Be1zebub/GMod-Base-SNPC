-- from incredible-gmod.ru with <3

include("shared.lua")

function ENT:Draw(f)
	self:DrawModel(f)
end

local BASED = {} -- https://tenor.com/view/based-gigachad-chad-gif-23901955

for class, sent in pairs(scripted_ents.GetList()) do
	if sent.Base == "base_snpc" then
		BASED[class] = true
	end
end

function ENT:Initialize()
	BASED[self:GetClass()] = true

	net.Receive(self.NetID or self.Folder, function()
		local ent = net.ReadEntity()

		if ent.OnUse then
			ent:OnUse()
		end
	end)
end

local maxDist = 512 ^ 2
local Ang90 = Angle(0, 0, 90)

hook.Add("PreDrawEffects", "https://github.com/Be1zebub/GMod-Base-SNPC", function()
	local ply = LocalPlayer()

	for _, npc in ipairs(ents.GetAll()) do
		if BASED[npc:GetClass()] and npc.Overhead then
			local pos = npc:LookupBone("ValveBiped.Bip01_Head1")
			if pos and pos > -1 then
				pos = npc:GetBonePosition(pos) + npc:GetAngles():Up() * 12
			else
				pos = npc:GetPos() + npc:GetAngles():Up() * (npc:OBBMaxs().z + 3)
			end

			local dist = ply:GetPos():DistToSqr(pos)

			if dist > (npc.Overhead.maxDist or maxDist) then continue end
			local alpha = 1 - dist / (npc.Overhead.maxDist or maxDist)

			local ang = ply:EyeAngles()
			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), 90)

			Ang90.y = ang.y

			cam.Start3D2D(pos, Ang90, 0.05)
			surface.SetAlphaMultiplier(alpha)
				npc.Overhead.draw(npc)
			surface.SetAlphaMultiplier(1)
			cam.End3D2D()
		end
	end
end)
