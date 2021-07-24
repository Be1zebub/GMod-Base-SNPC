-- incredible-gmod.ru

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Sequence = "idle01"
ENT.Model = "models/Barney.mdl"

util.AddNetworkString(ENT.NetID)

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

function ENT:RunAnimationPiece(anim, pos) -- str sequence, 0-1 position
	self:ResetSequence(
		self:LookupSequence(anim)
	)
	self:SetCycle(pos)
	self:SetPlaybackRate(0)
end

function ENT:Use(ply)
	net.Start(self.NetID)
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos - tr.HitNormal)

	local ang = tr.HitNormal:Angle()
	ang:RotateAroundAxis(ang:Right(), -90)
	ent:SetAngles(ang)

	ent:Spawn()
	ent:Activate()

	return ent
end
