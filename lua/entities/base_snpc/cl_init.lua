-- incredible-gmod.ru

include("shared.lua")

function ENT:Draw(f)
	self:DrawModel(f)
end

function ENT:Initialize()
	net.Receive(self.NetID or self.Folder, function()
		local ent = net.ReadEntity()

		if ent.OnUse then
			ent:OnUse()
		end
	end)
end
