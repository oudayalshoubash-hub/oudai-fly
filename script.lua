-- Oudai Fly | Fixed - Joystick Controls Vertical
-- Delta Executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local flying = false
local flySpeed = 100

local bv, bg
local character, humanoid, rootPart

local function getCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end

getCharacter()
player.CharacterAdded:Connect(getCharacter)

-- ============================================
-- ROBLOX NOTIFICATION SYSTEM WITH RAINBOW GLOW
-- ============================================
local function showRainbowNotification()
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "RainbowNotification"
    notificationGui.ResetOnSpawn = false
    notificationGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Full screen background (semi-transparent)
    local bgOverlay = Instance.new("Frame")
    bgOverlay.Size = UDim2.new(1, 0, 1, 0)
    bgOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bgOverlay.BackgroundTransparency = 0.5
    bgOverlay.BorderSizePixel = 0
    bgOverlay.Parent = notificationGui
    
    -- Notification container (centered)
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 600, 0, 300)
    notificationFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
    notificationFrame.BackgroundTransparency = 0.1
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = bgOverlay
    
    -- Rounded corners
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 30)
    notifCorner.Parent = notificationFrame
    
    -- Rainbow gradient stroke (glow effect)
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Color = Color3.fromRGB(255, 0, 0)
    rainbowStroke.Thickness = 3
    rainbowStroke.Transparency = 0
    rainbowStroke.Parent = notificationFrame
    
    -- Rainbow colors for animation
    local rainbowColors = {
        Color3.fromRGB(255, 0, 0),    -- Red
        Color3.fromRGB(255, 127, 0),  -- Orange
        Color3.fromRGB(255, 255, 0),  -- Yellow
        Color3.fromRGB(0, 255, 0),    -- Green
        Color3.fromRGB(0, 0, 255),    -- Blue
        Color3.fromRGB(75, 0, 130),   -- Indigo
        Color3.fromRGB(148, 0, 211),  -- Violet
    }
    
    -- Rainbow text glow effect
    local mainText = Instance.new("TextLabel")
    mainText.Size = UDim2.new(1, -40, 0, 150)
    mainText.Position = UDim2.new(0, 20, 0.5, -75)
    mainText.BackgroundTransparency = 1
    mainText.Text = "Script made by OudaiLUA on roblox ;)"
    mainText.TextColor3 = Color3.fromRGB(255, 0, 0)
    mainText.TextSize = 48
    mainText.Font = Enum.Font.GothamBold
    mainText.TextWrapped = true
    mainText.Parent = notificationFrame
    
    -- Additional glow shadow layers for rainbow effect
    local glowLayers = {}
    for i = 1, 3 do
        local glowText = Instance.new("TextLabel")
        glowText.Size = UDim2.new(1, -40, 0, 150)
        glowText.Position = UDim2.new(0, 20, 0.5, -75)
        glowText.BackgroundTransparency = 1
        glowText.Text = "Script made by OudaiLUA on roblox ;)"
        glowText.TextColor3 = Color3.fromRGB(255, 0, 0)
        glowText.TextSize = 48
        glowText.Font = Enum.Font.GothamBold
        glowText.TextWrapped = true
        glowText.TextTransparency = 0.3 + (i * 0.2)
        glowText.Parent = notificationFrame
        table.insert(glowLayers, glowText)
    end
    
    -- Subtitle
    local subText = Instance.new("TextLabel")
    subText.Size = UDim2.new(1, -40, 0, 60)
    subText.Position = UDim2.new(0, 20, 0.5, 60)
    subText.BackgroundTransparency = 1
    subText.Text = "Fly Script Ready!"
    subText.TextColor3 = Color3.fromRGB(167, 139, 250)
    subText.TextSize = 28
    subText.Font = Enum.Font.Gotham
    subText.Parent = notificationFrame
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 120, 0, 40)
    closeBtn.Position = UDim2.new(0.5, -60, 1, -50)
    closeBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    closeBtn.Text = "GOT IT!"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = notificationFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeBtn
    
    -- Rainbow animation loop
    local colorIndex = 1
    local animationConnection
    animationConnection = RunService.Heartbeat:Connect(function()
        if not notificationGui.Parent then
            animationConnection:Disconnect()
            return
        end
        
        colorIndex = colorIndex + 1
        if colorIndex > #rainbowColors then colorIndex = 1 end
        
        local currentColor = rainbowColors[colorIndex]
        local nextColor = rainbowColors[(colorIndex % #rainbowColors) + 1]
        
        mainText.TextColor3 = currentColor
        rainbowStroke.Color = currentColor
        
        for _, glowText in ipairs(glowLayers) do
            glowText.TextColor3 = currentColor
        end
    end)
    
    -- Close button functionality
    closeBtn.Activated:Connect(function()
        TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        TweenService:Create(bgOverlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
        
        task.wait(0.3)
        animationConnection:Disconnect()
        notificationGui:Destroy()
    end)
    
    -- Auto-close after 10 seconds
    task.delay(10, function()
        if notificationGui.Parent then
            closeBtn.Activated:Fire()
        end
    end)
    
    -- Entrance animation
    notificationFrame.Size = UDim2.new(0, 0, 0, 0)
    notificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 300),
        Position = UDim2.new(0.5, -300, 0.5, -150)
    }):Play()
end

-- Show notification on script load
showRainbowNotification()

-- ============================================
-- MODERN GUI
-- ============================================
local sg = Instance.new("ScreenGui")
sg.Name = "OudaiFly"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

-- Main Frame with glassmorphism
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = sg

-- Rounded corners
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 20)
frameCorner.Parent = frame

-- Gradient border effect
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(147, 51, 234)
stroke.Thickness = 2
stroke.Transparency = 0.6
stroke.Parent = frame

-- Inner gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(147, 51, 234)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(99, 102, 241)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246))
})
gradient.Rotation = 135
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(1, 0.95)
})
gradient.Parent = frame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BackgroundTransparency = 0.5
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "oudai fly"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Status dot
local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 12, 0, 12)
statusDot.Position = UDim2.new(1, -30, 0.5, -6)
statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
statusDot.BorderSizePixel = 0
statusDot.Parent = titleBar

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

-- Content Container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -70)
content.Position = UDim2.new(0, 15, 0, 60)
content.BackgroundTransparency = 1
content.Parent = frame

-- Toggle Button (Main)
local toggle = Instance.new("TextButton")
toggle.Name = "ToggleBtn"
toggle.Size = UDim2.new(1, 0, 0, 60)
toggle.Position = UDim2.new(0, 0, 0, 0)
toggle.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
toggle.Text = "ENABLE FLY"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 18
toggle.Font = Enum.Font.GothamBold
toggle.AutoButtonColor = false
toggle.Parent = content

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 15)
toggleCorner.Parent = toggle

-- Button glow
local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(168, 85, 247)
toggleStroke.Thickness = 2
toggleStroke.Transparency = 0.5
toggleStroke.Parent = toggle

-- Speed Section
local speedContainer = Instance.new("Frame")
speedContainer.Size = UDim2.new(1, 0, 0, 80)
speedContainer.Position = UDim2.new(0, 0, 0, 75)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = content

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "SPEED"
speedLabel.TextColor3 = Color3.fromRGB(167, 139, 250)
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.Parent = speedContainer

-- Speed Value Display
local speedValueBg = Instance.new("Frame")
speedValueBg.Size = UDim2.new(0, 80, 0, 40)
speedValueBg.Position = UDim2.new(0.5, -40, 0, 30)
speedValueBg.BackgroundColor3 = Color3.fromRGB(40, 35, 65)
speedValueBg.BorderSizePixel = 0
speedValueBg.Parent = speedContainer

local speedValueCorner = Instance.new("UICorner")
speedValueCorner.CornerRadius = UDim.new(0, 10)
speedValueCorner.Parent = speedValueBg

local speedValue = Instance.new("TextLabel")
speedValue.Size = UDim2.new(1, 0, 1, 0)
speedValue.BackgroundTransparency = 1
speedValue.Text = tostring(flySpeed)
speedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
speedValue.TextSize = 20
speedValue.Font = Enum.Font.GothamBold
speedValue.Parent = speedValueBg

-- Minus Button
local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 50, 0, 40)
minusBtn.Position = UDim2.new(0.5, -95, 0, 30)
minusBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
minusBtn.Text = "-"
minusBtn.TextColor3 = Color3.new(1, 1, 1)
minusBtn.TextSize = 24
minusBtn.Font = Enum.Font.GothamBold
minusBtn.AutoButtonColor = false
minusBtn.Parent = speedContainer

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(0, 10)
minusCorner.Parent = minusBtn

-- Plus Button
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 50, 0, 40)
plusBtn.Position = UDim2.new(0.5, 45, 0, 30)
plusBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.new(1, 1, 1)
plusBtn.TextSize = 24
plusBtn.Font = Enum.Font.GothamBold
plusBtn.AutoButtonColor = false
plusBtn.Parent = speedContainer

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(0, 10)
plusCorner.Parent = plusBtn

-- Draggable functionality (custom for smooth dragging)
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Button animations
local function animateButton(btn, normalColor, hoverColor)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
        end
    end)
    
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
        end
    end)
end

animateButton(toggle, Color3.fromRGB(147, 51, 234), Color3.fromRGB(168, 85, 247))
animateButton(minusBtn, Color3.fromRGB(99, 102, 241), Color3.fromRGB(129, 140, 248))
animateButton(plusBtn, Color3.fromRGB(147, 51, 234), Color3.fromRGB(168, 85, 247))

-- ============================================
-- FLY LOGIC (UNCHANGED)
-- ============================================
local function startFly()
    flying = true
    getCharacter()
    humanoid.PlatformStand = true
    
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(600000, 900000, 600000)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = rootPart
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(400000, 400000, 400000)
    bg.P = 15000
    bg.Parent = rootPart
    
    toggle.Text = "DISABLE FLY"
    toggle.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    statusDot.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    
    -- Pulse animation
    TweenService:Create(statusDot, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), 
        {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(1, -32, 0.5, -8)}
    ):Play()
end

local function stopFly()
    flying = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if humanoid then humanoid.PlatformStand = false end
    
    toggle.Text = "ENABLE FLY"
    toggle.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
    
    -- Reset dot size
    TweenService:Create(statusDot, TweenInfo.new(0.2), 
        {Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(1, -30, 0.5, -6)}
    ):Play()
end

RunService.Heartbeat:Connect(function()
    if not flying or not rootPart or not bv then return end
    
    local move = humanoid.MoveDirection
    
    -- Make forward joystick also go up when flying
    local verticalBoost = move.Z * -30   -- Forward on joystick = up
    
    local vertical = verticalBoost
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical += 60 end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vertical -= 60 end
    
    local targetVel = (move * flySpeed) + Vector3.new(0, vertical, 0)
    
    bv.Velocity = targetVel
    bg.CFrame = camera.CFrame
end)

-- Button connections
toggle.Activated:Connect(function()
    if flying then stopFly() else startFly() end
end)

minusBtn.Activated:Connect(function()
    flySpeed = math.max(30, flySpeed - 10)
    speedValue.Text = tostring(flySpeed)
end)

plusBtn.Activated:Connect(function()
    flySpeed = math.min(500, flySpeed + 10)
    speedValue.Text = tostring(flySpeed)
end)

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

-- Intro animation
frame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 300, 0, 220)
}):Play()

print("✅ Oudai Fly loaded | Blue/Purple Theme with Rainbow Notification")
