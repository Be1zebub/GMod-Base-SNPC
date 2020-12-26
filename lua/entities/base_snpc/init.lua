-- incredible-gmod.ru

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Sequence = "idle01"
ENT.Model = "models/Barney.mdl"

function ENT:Initialize()
  	self:SetModel(self.Model)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)

	self:RunAnimation(self.Sequence)
end

function ENT:RunAnimation(anim)
	self:ResetSequence(
		self:LookupSequence(anim)
	)
	self:SetCycle(0)
	self:SetPlaybackRate(1)
end
