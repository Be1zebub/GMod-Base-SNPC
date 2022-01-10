-- incredible-gmod.ru

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Sequence = "idle01"
ENT.Model = "models/Barney.mdl"

function ENT:Initialize()
	util.AddNetworkString(self.NetID or self.Folder)
	
  	self:SetModel(self.Model)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)

	self:RunAnimation(self.Sequence)
	self:OpenEyes()
end

function ENT:SetDefaultAnimation()
    if self.DefaultSequence then
        self:ResetSequence(self.DefaultSequence)
        return
    end

    local sec_id = self:LookupSequence("idle_all_01")

	if sec_id <= 0 then sec_id = self:LookupSequence("idle") end
    if sec_id <= 0 then sec_id = self:LookupSequence("walk_all") end
    if sec_id <= 0 then sec_id = self:LookupSequence("WalkUnarmed_all") end
    if sec_id <= 0 then sec_id = self:LookupSequence("walk_all_moderate") end

    self:ResetSequence(sec_id)
end

function ENT:RunAnimation(anim)
	local sec_id = self:LookupSequence(anim)
	if sec_id < 0 then self:SetDefaultAnimation() return false end

	self:ResetSequence(sec_id)
	self:SetCycle(0)
	self:SetPlaybackRate(1)
	return true
end

function ENT:RunAnimationPiece(anim, pos) -- str sequence, 0-1 position
	local sec_id = self:LookupSequence(anim)
	if sec_id < 0 then self:SetDefaultAnimation() return false end

	self:ResetSequence(sec_id)
	self:SetCycle(pos)
	self:SetPlaybackRate(0)
	return true
end

function ENT:Use(ply)
	net.Start(self.NetID or self.Folder)
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

function ENT:OpenEyes()
	local FlexNum = self:GetFlexNum()
	if FlexNum <= 0 then return end

	for i = 0, FlexNum do
		local Name = self:GetFlexName(i)
		self:SetFlexWeight(i, 0)
	end
end
