AddCSLuaFile()

ENT.Base = "base_snpc"

ENT.PrintName = "My 1st SNPC"
ENT.Author = "Me"
ENT.Category = "My Stuff"

ENT.Spawnable 	= true
ENT.AdminOnly 	= true

ENT.Model = "models/characters/hostage_04.mdl"
ENT.Sequence = "LineIdle04"

if CLIENT then
	function ENT:OnUse()
		local menu = vgui.Create("DFrame")
		menu:SetSize(400, 600)
		menu:Center()
		menu:MakePopup()
		menu:SetTitle(self:GetClass())

		menu.lbl = menu:Add("DLabel")
		menu.lbl:SetText("Hello world!")
		menu.lbl:SizeToContents()
		menu.lbl:SetPos(menu:GetWide() * 0.5 - menu.lbl:GetWide() * 0.5, menu:GetTall() * 0.5 - menu.lbl:GetTall() * 0.5)
	end
end
