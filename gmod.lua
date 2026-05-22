-- Script Unificado: Painel Flutuante Admin Max V4.1 (Ultimate Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Estados globais das funções
local flying = false
local flyConnection = nil
local flySpeed = 50
local espActive = false
local noclipActive = false
local noclipConnection = nil
local spinConnection = nil
local infJumpActive = false
local freeCamActive = false
local freeCamPart = nil
local godModeActive = false
local godConnection = nil

-- Novas variáveis da V4
local killAuraActive = false
local killAuraConnection = nil
local floatPart = nil
local floatConnection = nil
local fpsValue = 0
local pingValue = 0

-- Configuração do Sistema de Key Avançado (100 Chaves Aleatórias Sem Expiração)
local BANCO_DE_KEYS = {
    ["KEY_x7R9bW2mQz"] = true, ["KEY_L3vP8kTxNf"] = true, ["KEY_gY5mC1sJvW"] = true, ["KEY_H9bZ4qRtKd"] = true, ["KEY_pL2xN8vMwQ"] = true,
    ["KEY_fK6sJ3wYtZ"] = true, ["KEY_vR1mN9bCxP"] = true, ["KEY_tQ4kL7zWjF"] = true, ["KEY_M2vP5nX8sK"] = true, ["KEY_bZ9rQ1wYtJ"] = true,
    ["KEY_nG4mK7vP2x"] = true, ["KEY_wR8bN3zLqF"] = true, ["KEY_jY1sC5wKtP"] = true, ["KEY_H7vM2nX9sQ"] = true, ["KEY_kL4zR8bWjF"] = true,
    ["KEY_pQ9mY1sK3v"] = true, ["KEY_tN6wX8zL2r"] = true, ["KEY_gB4vP7mK1s"] = true, ["KEY_jF9sQ3wYtZ"] = true, ["KEY_xR2mN5bCxP"] = true,
    ["KEY_vL7zK1wJtF"] = true, ["KEY_M4vP8nX2sK"] = true, ["KEY_bQ9rY5wJtG"] = true, ["KEY_nG1mK6vP3x"] = true, ["KEY_wX8bN2zLqF"] = true,
    ["KEY_jY4sC7wKtP"] = true, ["KEY_H1vM9nX3sQ"] = true, ["KEY_kL6zR2bWjF"] = true, ["KEY_pQ4mY8sK1v"] = true, ["KEY_tN2wX7zL9r"] = true,
    ["KEY_gB9vP3mK6s"] = true, ["KEY_jF1sQ4wYtZ"] = true, ["KEY_xR7mN2bCxP"] = true, ["KEY_vL4zK8wJtF"] = true, ["KEY_M1vP6nX9sK"] = true,
    ["bQ3rY7wJtG"] = true, ["KEY_nG8mK2vP5x"] = true, ["KEY_wX1bN6zLqF"] = true, ["KEY_jY7sC2wKtP"] = true, ["KEY_H4vM8nX1sQ"] = true,
    ["KEY_kL9zR3bWjF"] = true, ["KEY_pQ2mY6sK7v"] = true, ["KEY_tN8wX1zL4r"] = true, ["KEY_gB3vP9mK2s"] = true, ["KEY_jF7sQ2wYtZ"] = true,
    ["KEY_xR1mN6bCxP"] = true, ["KEY_vL9zK3wJtF"] = true, ["KEY_M2vP7nX4sK"] = true, ["KEY_bQ8rY1wJtG"] = true, ["KEY_nG3mK9vP2x"] = true,
    ["KEY_wX7bN4zLqF"] = true, ["KEY_jY2sC8wKtP"] = true, ["KEY_H6vM1nX9sQ"] = true, ["KEY_kL3zR7bWjF"] = true, ["KEY_pQ8mY2sK4v"] = true,
    ["KEY_tN1wX6zL8r"] = true, ["KEY_gB7vP2mK9s"] = true, ["KEY_jF3sQ8wYtZ"] = true, ["KEY_xR9mN4bCxP"] = true, ["KEY_vL2zK7wJtF"] = true,
    ["KEY_M8vP3nX1sK"] = true, ["KEY_bQ4rY9wJtG"] = true, ["KEY_nG2mK7vP6x"] = true, ["KEY_wX9bN3zLqF"] = true, ["KEY_jY1sC6wKtP"] = true,
    ["KEY_H8vM3nX2sQ"] = true, ["KEY_kL1zR6bWjF"] = true, ["KEY_pQ7mY3sK8v"] = true, ["KEY_tN9wX2zL1r"] = true, ["KEY_gB6vP1mK7s"] = true,
    ["KEY_jF2sQ9wYtZ"] = true, ["KEY_xR8mN3bCxP"] = true, ["KEY_vL1zK6wJtF"] = true, ["KEY_M9vP2nX7sK"] = true, ["KEY_bQ1rY6wJtG"] = true,
    ["KEY_nG7mK3vP9x"] = true, ["KEY_wX2bN8zLqF"] = true, ["KEY_jY9sC3wKtP"] = true, ["KEY_H2vM7nX4sQ"] = true, ["KEY_kL8zR1bWjF"] = true,
    ["KEY_pQ3mY9sK2v"] = true, ["KEY_tN7wX3zL6r"] = true, ["KEY_gB2vP8mK3s"] = true, ["KEY_jF6sQ1wYtZ"] = true, ["KEY_xR3mN7bCxP"] = true,
    ["KEY_vL8zK2wJtF"] = true, ["KEY_M3vP9nX6sK"] = true, ["KEY_bQ2rY8wJtG"] = true, ["KEY_nG9mK4vP1x"] = true, ["KEY_wX3bN7zLqF"] = true,
    ["KEY_jY2sC9wKtP"] = true, ["KEY_H3vM6nX8sQ"] = true, ["KEY_kL2zR9bWjF"] = true, ["KEY_pQ6mY4sK9v"] = true, ["KEY_tN3wX9zL2r"] = true,
    ["KEY_gB1vP6mK8s"] = true, ["KEY_jF8sQ2wYtZ"] = true, ["KEY_xR4mN1bCxP"] = true, ["KEY_vL3zK9wJtF"] = true, ["KEY_M7vP4nX2sK"] = true,
}

local LINK_WHATSAPP = "https://chat.whatsapp.com/DTOSXCmR3S7K4LQ1f7kbBV?s=cl&p=a&mlu=3"

-- Tabela para guardar os objetos revelados e suas propriedades originais
local objetosOcultosRevelados = {}

-- 1. INJEÇÃO DA INTERFACE VISUAL (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelDeltaMaxV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentSucesso = false
local targets = { game:GetService("CoreGui"), player:WaitForChild("PlayerGui", 5), workspace }
for _, target in ipairs(targets) do
    if target then
        local ok, _ = pcall(function() ScreenGui.Parent = target end)
        if ok and ScreenGui.Parent == target then parentSucesso = true break end
    end
end
if not parentSucesso then pcall(function() gethui(ScreenGui) end) end

-- Janela Principal (Inicia invisível esperando a chave)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 130)
MainFrame.Position = UDim2.new(0.5, -150, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- INTERFACE DO SISTEMA DE KEY (Sempre por cima)
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.3, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.ZIndex = 5
KeyFrame.Parent = ScreenGui

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 8)
UICornerKey.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 30)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "SISTEMA DE VERIFICAÇÃO"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.ZIndex = 6
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -30, 0, 35)
KeyInput.Position = UDim2.new(0, 15, 0, 45)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.SourceSans
KeyInput.PlaceholderText = "Insira a chave de acesso..."
KeyInput.Text = ""
KeyInput.ZIndex = 6
KeyInput.Parent = KeyFrame

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 5)
UICornerInput.Parent = KeyInput

local BtnVerify = Instance.new("TextButton")
BtnVerify.Size = UDim2.new(0, 130, 0, 35)
BtnVerify.Position = UDim2.new(0, 15, 0, 95)
BtnVerify.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
BtnVerify.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnVerify.TextSize = 13
BtnVerify.Font = Enum.Font.SourceSansBold
BtnVerify.Text = "VERIFICAR KEY"
BtnVerify.ZIndex = 6
BtnVerify.Parent = KeyFrame

local UICornerVerify = Instance.new("UICorner")
UICornerVerify.CornerRadius = UDim.new(0, 5)
UICornerVerify.Parent = BtnVerify

local BtnGetKey = Instance.new("TextButton")
BtnGetKey.Size = UDim2.new(0, 130, 0, 35)
BtnGetKey.Position = UDim2.new(1, -145, 0, 95)
BtnGetKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BtnGetKey.TextColor3 = Color3.fromRGB(230, 230, 230)
BtnGetKey.TextSize = 13
BtnGetKey.Font = Enum.Font.SourceSansBold
BtnGetKey.Text = "GET KEY"
BtnGetKey.ZIndex = 6
BtnGetKey.Parent = KeyFrame

local UICornerGetKey = Instance.new("UICorner")
UICornerGetKey.CornerRadius = UDim.new(0, 5)
UICornerGetKey.Parent = BtnGetKey

-- Lógica do Sistema de Key (Corrigida e Sem Expiração)
BtnGetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LINK_WHATSAPP)
        BtnGetKey.Text = "LINK COPIADO!"
        task.wait(2)
        BtnGetKey.Text = "GET KEY"
    else
        BtnGetKey.Text = "Erro (Sem Clipboard)"
    end
end)

BtnVerify.MouseButton1Click:Connect(function()
    local chaveDigitada = KeyInput.Text
    
    if BANCO_DE_KEYS[chaveDigitada] then
        KeyFrame:Destroy()
        MainFrame.Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "CHAVE INCORRETA!"
        task.wait(1.5)
        KeyInput.PlaceholderText = "Insira a chave de acesso..."
    end
end)

-- Título do Painel
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "  G-MODS PANEL V1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Display de FPS e PING em tempo real no topo
local MonitorLabel = Instance.new("TextLabel")
MonitorLabel.Size = UDim2.new(0, 120, 0, 25)
MonitorLabel.Position = UDim2.new(1, -130, 0, 0)
MonitorLabel.BackgroundTransparency = 1
MonitorLabel.Text = "FPS: -- | PING: --"
MonitorLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
MonitorLabel.TextSize = 11
MonitorLabel.Font = Enum.Font.SourceSansBold
MonitorLabel.TextXAlignment = Enum.TextXAlignment.Right
MonitorLabel.Parent = MainFrame

local BarraComando = Instance.new("TextBox")
BarraComando.Size = UDim2.new(1, -20, 0, 35)
BarraComando.Position = UDim2.new(0, 10, 0, 35)
BarraComando.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BarraComando.TextColor3 = Color3.fromRGB(255, 255, 255)
BarraComando.TextSize = 15
BarraComando.PlaceholderText = "Digite o comando aqui..."
BarraComando.Text = ""
BarraComando.Parent = MainFrame

local UICornerBarra = Instance.new("UICorner")
UICornerBarra.CornerRadius = UDim.new(0, 5)
UICornerBarra.Parent = BarraComando

local BotaoAjuda = Instance.new("TextButton")
BotaoAjuda.Size = UDim2.new(1, -20, 0, 30)
BotaoAjuda.Position = UDim2.new(0, 10, 0, 80)
BotaoAjuda.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BotaoAjuda.TextColor3 = Color3.fromRGB(230, 230, 230)
BotaoAjuda.TextSize = 13
BotaoAjuda.Font = Enum.Font.SourceSansBold
BotaoAjuda.Text = "VER TODOS OS COMANDOS"
BotaoAjuda.Parent = MainFrame

local UICornerBotao = Instance.new("UICorner")
UICornerBotao.CornerRadius = UDim.new(0, 5)
UICornerBotao.Parent = BotaoAjuda

-- Janela de Rolagem para Lista de Comandos V4
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 0, 240)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 135)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ScrollingFrame.Visible = false
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.Parent = MainFrame

local UICornerScroll = Instance.new("UICorner")
UICornerScroll.CornerRadius = UDim.new(0, 8)
UICornerScroll.Parent = ScrollingFrame

local ListaTexto = Instance.new("TextLabel")
ListaTexto.Size = UDim2.new(1, -15, 1, 0)
ListaTexto.Position = UDim2.new(0, 10, 0, 10)
ListaTexto.BackgroundTransparency = 1
ListaTexto.TextColor3 = Color3.fromRGB(220, 220, 220)
ListaTexto.TextSize = 12
ListaTexto.Font = Enum.Font.Code
ListaTexto.TextXAlignment = Enum.TextXAlignment.Left
ListaTexto.TextYAlignment = Enum.TextYAlignment.Top
ListaTexto.Text = [[
> fly [speed]       - Voo (Ex: fly 150)
> unfly             - Desativa o voo
> speed [num]       - Altera velocidade
> jump [num]        - Altera força pulo
> esp               - Realce de players
> tp [player]       - Teleporta ao player
> spin / unspin     - Gira o personagem
> spectate [player] - Assiste o jogador
> unspectate        - Para de assistir
> noclip            - Atravessa paredes
> unnoclip          - Desativa o noclip
> infjump / uninf   - Pulo infinito
> clicktp           - Item para teleportar
> tphome            - Vai para o Spawn
> fov [num]         - Campo de visão
> freecam           - Libera a câmera
> btools            - Ferramentas locais
> god               - Evita killbricks
> sit               - Senta o boneco
> re                - Reseta o boneco
> hipheight [num]   - Altura do chão
> antilag           - Tira lag de texturas
> killaura / unkill - Bate em quem aproximar
> day / night       - Muda hora local
> nofog             - Limpa a névoa
> brightness [num]  - Luz do ambiente
> float / unfloat   - Plataforma Invisível
> gravity [num]     - Altera a gravidade
> superjump         - Super pulo lunar
> showhidden        - Revela salas ocultas
> unshowhidden      - Oculta as salas novamente]]
ListaTexto.Parent = ScrollingFrame

-- 2. ENGENHARIA DE CÁLCULO (FPS / PING)
pcall(function()
    local contagemQuadros = 0
    local tempoAnterior = os.clock()
    
    RunService.RenderStepped:Connect(function()
        contagemQuadros = contagemQuadros + 1
        local tempoAtual = os.clock()
        if tempoAtual - tempoAnterior >= 1 then
            fpsValue = contagemQuadros
            contagemQuadros = 0
            tempoAnterior = tempoAtual
        end
        
        local pingAproximado = math.floor((Workspace:GetRealPhysicsFPS() / 60) * 25)
        MonitorLabel.Text = "FPS: " .. fpsValue .. " | PING: " .. pingAproximado .. "ms"
    end)
end)

-- 3. FUNÇÕES AUXILIARES E MECÂNICAS
local function obterJogador(nomeParcial)
    if not nomeParcial or nomeParcial == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, string.len(nomeParcial)) == string.lower(nomeParcial) or 
           (p.DisplayName and string.sub(string.lower(p.DisplayName), 1, string.len(nomeParcial)) == string.lower(nomeParcial)) then
            return p
        end
    end
    return nil
end

local function alternarKillAura()
    killAuraActive = not killAuraActive
    if killAuraActive then
        killAuraConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local tool = char and char:FindFirstChildOfClass("Tool")
            if root and tool then
                for _, outro in ipairs(Players:GetPlayers()) do
                    if outro ~= player and outro.Character and outro.Character:FindFirstChild("HumanoidRootPart") then
                        local distancia = (root.Position - outro.Character.HumanoidRootPart.Position).Magnitude
                        if distancia <= 15 then
                            tool:Activate()
                        end
                    end
                end
            end
        end)
    else
        if killAuraConnection then killAuraConnection:Disconnect() killAuraConnection = nil end
    end
end

local function alternarFloat()
    if floatPart then floatPart:Destroy() floatPart = nil end
    if floatConnection then floatConnection:Disconnect() floatConnection = nil end
    
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    floatPart = Instance.new("Part")
    floatPart.Size = Vector3.new(6, 0.5, 6)
    floatPart.Transparency = 1
    floatPart.Anchored = true
    floatPart.CanCollide = true
    floatPart.Parent = Workspace
    
    floatConnection = RunService.RenderStepped:Connect(function()
        if char and root.Parent and floatPart then
            floatPart.CFrame = CFrame.new(root.Position.X, root.Position.Y - 3.25, root.Position.Z)
        else
            if floatConnection then floatConnection:Disconnect() floatConnection = nil end
            if floatPart then floatPart:Destroy() floatPart = nil end
        end
    end)
end

local function iniciarVoo()
    if flying then return end
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local camera = Workspace.CurrentCamera
    if not rootPart or not humanoid then return end
    
    flying = true
    local bv = Instance.new("BodyVelocity", rootPart)
    bv.Name = "DeltaFlyVel"
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    
    local bg = Instance.new("BodyGyro", rootPart)
    bg.Name = "DeltaFlyGyro"
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    
    humanoid.PlatformStand = true
    
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying or not rootPart.Parent then 
            if flyConnection then flyConnection:Disconnect() end
            bv:Destroy() bg:Destroy()
            if humanoid then humanoid.PlatformStand = false end
            return 
        end
        bg.CFrame = camera.CFrame
        local move = humanoid.MoveDirection
        if move.Magnitude > 0 then
            local look = camera.CFrame.LookVector
            bv.Velocity = (rootPart.CFrame.LookVector:Dot(move) < -0.5 and look * -flySpeed) or look * flySpeed
        else
            bv.Velocity = Vector3.new(0,0,0)
        end
    end)
end

UserInputService.JumpRequest:Connect(function()
    if infJumpActive and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- 4. CONTROLADOR CENTRAL DOS COMANDOS
BotaoAjuda.MouseButton1Click:Connect(function()
    ScrollingFrame.Visible = not ScrollingFrame.Visible
    BotaoAjuda.Text = ScrollingFrame.Visible and "FECHAR LISTA" or "VER TODOS OS COMANDOS"
end)

BarraComando.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local texto = BarraComando.Text
    BarraComando.Text = ""
    
    local args = string.split(texto, " ")
    local comando = string.lower(args[1])
    
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if comando == "fly" then
        local velocidadeFornecida = tonumber(args[2])
        flySpeed = velocidadeFornecida or 50
        iniciarVoo()
    elseif comando == "unfly" then 
        flying = false
    elseif comando == "speed" and humanoid then
        local v = tonumber(args[2]) or 16 flySpeed = v humanoid.WalkSpeed = v
    elseif comando == "jump" and humanoid then
        humanoid.UseJumpPower = true humanoid.JumpPower = tonumber(args[2]) or 50
    elseif comando == "esp" then
        espActive = not espActive
        
        if _G.EspConnectionPlayers then _G.EspConnectionPlayers:Disconnect() _G.EspConnectionPlayers = nil end
        if _G.EspConnectionsChar then
            for _, conn in pairs(_G.EspConnectionsChar) do conn:Disconnect() end
            _G.EspConnectionsChar = {}
        else
            _G.EspConnectionsChar = {}
        end

        local function aplicarESP(p)
            if p == player then return end
            
            local function iluminar(char)
                if not char then return end
                task.wait(0.5)
                if not espActive then return end
                
                local old = char:FindFirstChild("DeltaESP")
                if old then old:Destroy() end
                
                local hl = Instance.new("Highlight")
                hl.Name = "DeltaESP"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
                hl.Adornee = char
                hl.Parent = char
            end

            if p.Character then task.spawn(iluminar, p.Character) end
            
            local conn = p.CharacterAdded:Connect(function(char)
                iluminar(char)
            end)
            table.insert(_G.EspConnectionsChar, conn)
        end

        if espActive then
            for _, p in ipairs(Players:GetPlayers()) do
                aplicarESP(p)
            end
            
            _G.EspConnectionPlayers = Players.PlayerAdded:Connect(function(p)
                aplicarESP(p)
            end)
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character then
                    local old = p.Character:FindFirstChild("DeltaESP")
                    if old then old:Destroy() end
                end
            end
        end
    elseif comando == "noclip" then
        noclipActive = not noclipActive
        if noclipActive then
            noclipConnection = RunService.Stepped:Connect(function()
                if player.Character then
                    for _, p in ipairs(player.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            end)
        elseif noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    elseif comando == "unnoclip" then
        noclipActive = false
        if noclipConnection then 
            noclipConnection:Disconnect() 
            noclipConnection = nil 
        end
    elseif comando == "spin" and rootPart then
        local v = tonumber(args[2]) or 30
        if spinConnection then spinConnection:Disconnect() end
        spinConnection = RunService.RenderStepped:Connect(function()
            if rootPart.Parent then rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(v), 0) end
        end)
    elseif comando == "unspin" and spinConnection then spinConnection:Disconnect() spinConnection = nil
    elseif comando == "tp" and rootPart then
        local t = obterJogador(args[2])
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            rootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
        end
    elseif comando == "spectate" then
        local cam = Workspace.CurrentCamera
        local t = obterJogador(args[2])
        if t and t.Character and t.Character:FindFirstChildOfClass("Humanoid") then
            cam.CameraSubject = t.Character:FindFirstChildOfClass("Humanoid")
        elseif humanoid then cam.CameraSubject = humanoid end
    elseif comando == "unspectate" then
        local cam = Workspace.CurrentCamera
        if humanoid then cam.CameraSubject = humanoid end
    elseif comando == "infjump" then infJumpActive = true
    elseif comando == "uninf" then infJumpActive = false
    elseif comando == "clicktp" then
        local tool = Instance.new("Tool", player.Backpack) tool.Name = "Click TP" tool.RequiresHandle = false
        tool.Activated:Connect(function() if mouse.Hit and rootPart then rootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0,3,0)) end end)
    elseif comando == "tphome" and rootPart then
        local spawn = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        if spawn then
            rootPart.CFrame = spawn.CFrame * CFrame.new(0,3,0)
        end
    elseif comando == "fov" then Workspace.CurrentCamera.FieldOfView = tonumber(args[2]) or 70
    elseif comando == "sit" and humanoid then humanoid.Sit = true
    elseif comando == "hipheight" and humanoid then humanoid.HipHeight = tonumber(args[2]) or 0
    elseif comando == "re" then 
        if humanoid then humanoid.Health = 0 end
    elseif comando == "btools" then for i = 1, 4 do Instance.new("HopperBin", player.Backpack).BinType = i end
    elseif comando == "antilag" then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then obj.Material = Enum.Material.SmoothPlastic obj.Color = Color3.fromRGB(150,150,150)
            elseif obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
        end
    elseif comando == "killaura" then alternarKillAura()
    elseif comando == "unkillaura" then killAuraActive = false if killAuraConnection then killAuraConnection:Disconnect() killAuraConnection = nil end
    elseif comando == "day" then Lighting.ClockTime = 12
    elseif comando == "night" then Lighting.ClockTime = 0
    elseif comando == "nofog" then Lighting.FogEnd = 999999 Lighting.FogStart = 999999
    elseif comando == "brightness" then Lighting.Brightness = tonumber(args[2]) or 2
    elseif comando == "float" then alternarFloat()
    elseif comando == "unfloat" then if floatPart then floatPart:Destroy() floatPart = nil end if floatConnection then floatConnection:Disconnect() floatConnection = nil end
    elseif comando == "gravity" then Workspace.Gravity = tonumber(args[2]) or 196.2
    elseif comando == "superjump" and humanoid then
        humanoid.UseJumpPower = true humanoid.JumpPower = 200 Workspace.Gravity = 50
    elseif comando == "showhidden" then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Transparency == 1 then
                objetosOcultosRevelados[obj] = {Transparency = 1, Color = obj.Color}
                obj.Transparency = 0.6
                obj.Color = Color3.fromRGB(0,255,0)
            end
        end
    elseif comando == "unshowhidden" then
        for obj, propriedadesOriginais in pairs(objetosOcultosRevelados) do
            if obj and obj.Parent then
                obj.Transparency = propriedadesOriginais.Transparency
                obj.Color = propriedadesOriginais.Color
            end
        end
        table.clear(objetosOcultosRevelados)
    end
end)

player.CharacterAdded:Connect(function()
    flying = false infJumpActive = false noclipActive = false killAuraActive = false
    table.clear(objetosOcultosRevelados)
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    if spinConnection then spinConnection:Disconnect() spinConnection = nil end
    if killAuraConnection then killAuraConnection:Disconnect() killAuraConnection = nil end
    if floatConnection then floatConnection:Disconnect() floatConnection = nil end
    if floatPart then floatPart:Destroy() floatPart = nil end
end)
