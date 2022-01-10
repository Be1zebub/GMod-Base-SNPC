-- incredible-gmod.ru

include("shared.lua")

function ENT:Draw(f)
	self:DrawModel(f)
end

net.Receive(ENT.NetID or ENT.Folder, function()
	local ent = net.ReadEntity()

	if ent.OnUse then
		ent:OnUse()
	end
end)
