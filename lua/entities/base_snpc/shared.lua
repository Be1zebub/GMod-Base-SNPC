-- incredible-gmod.ru

ENT.Base = "base_entity"
ENT.AutomaticFrameAdvance = true

ENT.Spawnable 	= false -- its base :v
ENT.AdminOnly 	= false

ENT.Author       = "Beelzebub"
ENT.Contact      = "beelzebub@incredible-gmod.ru"

function ENT:SetAutomaticFrameAdvance(bool)
	self.AutomaticFrameAdvance = bool
end
