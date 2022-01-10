-- incredible-gmod.ru

ENT.Base = "base_entity"
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.Spawnable 	= false -- its base :v
ENT.AdminOnly 	= false

ENT.Author   = "gmodstore.com/users/beelzebub"
ENT.Contact  = "discord.incredible-gmod.ru"

function ENT:SetAutomaticFrameAdvance(bool)
	self.AutomaticFrameAdvance = bool
end
