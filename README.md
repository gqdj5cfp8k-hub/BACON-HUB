-- change_sky_red.lua
-- Colocar este Script em ServerScriptService
-- Harmless: não cria GUI nem objetos vis��veis para jogadores, apenas altera Lighting/Atmosphere.

local Lighting = game:GetService("Lighting")

local function applyRedSky()
	-- Remove efeito antigo se existir (evita duplicação)
	local existing = Lighting:FindFirstChild("RedTintEffect")
	if existing then
		existing:Destroy()
	end

	-- ColorCorrection para tintar a tela levemente de vermelho
	local cc = Instance.new("ColorCorrection")
	cc.Name = "RedTintEffect"
	cc.TintColor = Color3.fromRGB(255, 80, 80) -- tom vermelho
	cc.Contrast = 0
	cc.Saturation = -0.15
	cc.Brightness = 0
	cc.Enabled = true
	cc.Parent = Lighting

	-- Atmosphere (cria/ajusta para reforçar o tom vermelho do céu)
	local atm = Lighting:FindFirstChildOfClass("Atmosphere")
	if not atm then
		atm = Instance.new("Atmosphere")
		-- Não alterar o nome padrão (opcional), mas podemos identificá-lo se quisermos
		atm.Name = "RedAtmosphere"
		atm.Parent = Lighting
	end

	-- Ajustes sutis para um céu mais avermelhado
	pcall(function()
		atm.Density = 0.35
		atm.Offset = 0
		atm.Color = Color3.fromRGB(255, 90, 90)
		atm.Decay = Color3.fromRGB(0, 0, 0)
	end)

	-- Ajustes de iluminação ambiente e neblina
	Lighting.Ambient = Color3.fromRGB(120, 20, 20)
	Lighting.OutdoorAmbient = Color3.fromRGB(100, 10, 10)
	Lighting.FogColor = Color3.fromRGB(120, 10, 10)
	Lighting.FogStart = 0
	Lighting.FogEnd = 1000
end

-- Aplica ao iniciar
applyRedSky()

-- Opcional: reaplicar caso alguém substitua Lighting (resiliência)
Lighting.DescendantAdded:Connect(function(desc)
	-- se alguém adicionar uma nova ColorCorrection com o mesmo nome, reaplica o nosso
	if desc:IsA("ColorCorrection") or desc:IsA("Atmosphere") then
		-- pequeno atraso para garantir que mudanças tenham sido concluídas
		task.wait(0.1)
		-- reaplica garantindo que nosso visual continue
		applyRedSky()
	end
end)