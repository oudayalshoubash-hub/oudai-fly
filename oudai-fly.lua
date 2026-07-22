local P,U,R,T=game:GetService("Players"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("TweenService")
local p,c,h,rp,f,s=P.LocalPlayer,nil,nil,nil,false,100
local function g()c=p.Character or p.CharacterAdded:Wait()h=c:WaitForChild("Humanoid")rp=c:WaitForChild("HumanoidRootPart")end
g()p.CharacterAdded:Connect(g)
local sg=Instance.new("ScreenGui")sg.Name="OudaiFly"sg.ResetOnSpawn=false sg.Parent=p:WaitForChild("PlayerGui")
local fr=Instance.new("Frame")fr.Size=UDim2.new(0,300,0,220)fr.Position=UDim2.new(0.5,-150,0.2,0)fr.BackgroundColor3=Color3.fromRGB(25,20,45)fr.BackgroundTransparency=0.1 fr.BorderSizePixel=0 fr.Active=true fr.Draggable=true fr.Parent=sg
local fc=Instance.new("UICorner")fc.CornerRadius=UDim.new(0,20)fc.Parent=fr
local st=Instance.new("UIStroke")st.Color=Color3.fromRGB(147,51,234)st.Thickness=2 st.Transparency=0.6 st.Parent=fr
local gr=Instance.new("UIGradient")gr.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(147,51,234)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(99,102,241)),ColorSequenceKeypoint.new(1,Color3.fromRGB(59,130,246))})gr.Parent=fr
local tb=Instance.new("Frame")tb.Size=UDim2.new(1,0,0,50)tb.BackgroundColor3=Color3.fromRGB(0,0,0)tb.BackgroundTransparency=0.5 tb.BorderSizePixel=0 tb.Parent=fr
local tbc=Instance.new("UICorner")tbc.CornerRadius=UDim.new(0,20)tbc.Parent=tb
local ti=Instance.new("TextLabel")ti.Size=UDim2.new(1,-20,1,0)ti.Position=UDim2.new(0,15,0,0)ti.BackgroundTransparency=1 ti.Text="oudai fly"ti.TextColor3=Color3.fromRGB(255,255,255)ti.TextSize=22 ti.Font=Enum.Font.GothamBold ti.Parent=tb
local sd=Instance.new("Frame")sd.Size=UDim2.new(0,12,0,12)sd.Position=UDim2.new(1,-30,0.5,-6)sd.BackgroundColor3=Color3.fromRGB(0,255,120)sd.BorderSizePixel=0 sd.Parent=tb
local dc=Instance.new("UICorner")dc.CornerRadius=UDim.new(1,0)dc.Parent=sd
local co=Instance.new("Frame")co.Size=UDim2.new(1,-30,1,-70)co.Position=UDim2.new(0,15,0,60)co.BackgroundTransparency=1 co.Parent=fr
local tg=Instance.new("TextButton")tg.Name="ToggleBtn"tg.Size=UDim2.new(1,0,0,60)tg.BackgroundColor3=Color3.fromRGB(147,51,234)tg.Text="ENABLE FLY"tg.TextColor3=Color3.new(1,1,1)tg.TextSize=18 tg.Font=Enum.Font.GothamBold tg.Parent=co
local tgc=Instance.new("UICorner")tgc.CornerRadius=UDim.new(0,15)tgc.Parent=tg
local tgs=Instance.new("UIStroke")tgs.Color=Color3.fromRGB(168,85,247)tgs.Thickness=2 tgs.Transparency=0.5 tgs.Parent=tg
local sc=Instance.new("Frame")sc.Size=UDim2.new(1,0,0,80)sc.Position=UDim2.new(0,0,0,75)sc.BackgroundTransparency=1 sc.Parent=co
local sl=Instance.new("TextLabel")sl.Size=UDim2.new(1,0,0,25)sl.BackgroundTransparency=1 sl.Text="SPEED"sl.TextColor3=Color3.fromRGB(167,139,250)sl.TextSize=14 sl.Font=Enum.Font.GothamSemibold sl.Parent=sc
local svb=Instance.new("Frame")svb.Size=UDim2.new(0,80,0,40)svb.Position=UDim2.new(0.5,-40,0,30)svb.BackgroundColor3=Color3.fromRGB(40,35,65)svb.BorderSizePixel=0 svb.Parent=sc
local svc=Instance.new("UICorner")svc.CornerRadius=UDim.new(0,10)svc.Parent=svb
local sv=Instance.new("TextLabel")sv.Size=UDim2.new(1,0,1,0)sv.BackgroundTransparency=1 sv.Text=tostring(s)sv.TextColor3=Color3.fromRGB(255,255,255)sv.TextSize=20 sv.Font=Enum.Font.GothamBold sv.Parent=svb
local mb=Instance.new("TextButton")mb.Size=UDim2.new(0,50,0,40)mb.Position=UDim2.new(0.5,-95,0,30)mb.BackgroundColor3=Color3.fromRGB(99,102,241)mb.Text="-"mb.TextColor3=Color3.new(1,1,1)mb.TextSize=24 mb.Font=Enum.Font.GothamBold mb.Parent=sc
local mbc=Instance.new("UICorner")mbc.CornerRadius=UDim.new(0,10)mbc.Parent=mb
local pb=Instance.new("TextButton")pb.Size=UDim2.new(0,50,0,40)pb.Position=UDim2.new(0.5,45,0,30)pb.BackgroundColor3=Color3.fromRGB(147,51,234)pb.Text="+"pb.TextColor3=Color3.new(1,1,1)pb.TextSize=24 pb.Font=Enum.Font.GothamBold pb.Parent=sc
local pbc=Instance.new("UICorner")pbc.CornerRadius=UDim.new(0,10)pbc.Parent=pb
local d,di,ds,dsp=false,nil,nil,nil
tb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true ds=i.Position dsp=fr.Position i.Changed:Connect(function()if d then end end)end end)
tb.InputChanged:Connect(function(i)if d and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds fr.Position=UDim2.new(dsp.X.Scale,dsp.X.Offset+d.X,dsp.Y.Scale,dsp.Y.Offset+d.Y)end end)
tb.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=false end end)
local function a(b,n,h)b.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then T:Create(b,TweenInfo.new(0.15),{BackgroundColor3=n}):Play()end end)b.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then T:Create(b,TweenInfo.new(0.15),{BackgroundColor3=h}):Play()end end)end
a(tg,Color3.fromRGB(147,51,234),Color3.fromRGB(168,85,247))a(mb,Color3.fromRGB(99,102,241),Color3.fromRGB(129,140,248))a(pb,Color3.fromRGB(147,51,234),Color3.fromRGB(168,85,247))
local bv,bg
local function sf()f=true g()h.PlatformStand=true bv=Instance.new("BodyVelocity")bv.MaxForce=Vector3.new(600000,900000,600000)bv.Velocity=Vector3.new(0,0,0)bv.Parent=rp bg=Instance.new("BodyGyro")bg.MaxTorque=Vector3.new(600000,600000,600000)bg.CFrame=rp.CFrame bg.Parent=rp tg.Text="DISABLE FLY"tg.BackgroundColor3=Color3.fromRGB(220,38,38)sd.BackgroundColor3=Color3.fromRGB(255,100,100)end
local function st()f=false if bv then bv:Destroy()end if bg then bg:Destroy()end if h then h.PlatformStand=false end tg.Text="ENABLE FLY"tg.BackgroundColor3=Color3.fromRGB(147,51,234)sd.BackgroundColor3=Color3.fromRGB(0,255,120)end
R.Heartbeat:Connect(function()if not f or not rp or not bv then return end local m=h.MoveDirection local v=m.Z*-30 if U:IsKeyDown(Enum.KeyCode.Space)then v=v+60 end if U:IsKeyDown(Enum.KeyCode.LeftControl)then v=v-60 end bv.Velocity=(rp.CFrame.LookVector*Vector3.new(1,0,1)+Vector3.new(0,1,0)*m.Y).Unit*(math.abs(m.X)+math.abs(m.Z))*s+Vector3.new(0,v*0.6,0)bg.CFrame=rp.CFrame end)
tg.Activated:Connect(function()if f then st()else sf()end end)
mb.Activated:Connect(function()s=math.max(30,s-10)sv.Text=tostring(s)end)
pb.Activated:Connect(function()s=math.min(500,s+10)sv.Text=tostring(s)end)
U.InputBegan:Connect(function(i,g)if g then return end if i.KeyCode==Enum.KeyCode.F then if f then st()else sf()end end end)

local function notify(msg,dur)local n=Instance.new("ScreenGui")n.Name="Notification"n.ResetOnSpawn=false n.Parent=p:WaitForChild("PlayerGui")local nb=Instance.new("Frame")nb.Size=UDim2.new(0,300,0,60)nb.Position=UDim2.new(0.5,-150,0,20)nb.BackgroundColor3=Color3.fromRGB(25,20,45)nb.BackgroundTransparency=0.1 nb.BorderSizePixel=0 nb.Parent=n local nbc=Instance.new("UICorner")nbc.CornerRadius=UDim.new(0,15)nbc.Parent=nb local nst=Instance.new("UIStroke")nst.Color=Color3.fromRGB(147,51,234)nst.Thickness=2 nst.Transparency=0.6 nst.Parent=nb local ngr=Instance.new("UIGradient")ngr.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(147,51,234)),ColorSequenceKeypoint.new(1,Color3.fromRGB(59,130,246))})ngr.Parent=nb local nt=Instance.new("TextLabel")nt.Size=UDim2.new(1,-20,1,0)nt.Position=UDim2.new(0,10,0,0)nt.BackgroundTransparency=1 nt.Text=msg nt.TextColor3=Color3.fromRGB(255,255,255)nt.TextSize=16 nt.Font=Enum.Font.GothamSemibold nt.Parent=nb local tween=T:Create(nb,TweenInfo.new(dur,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{BackgroundTransparency=1})tween:Play()tween.Completed:Connect(function()n:Destroy()end)end

notify("Script made by OudaiLUA ;)",3)

fr.Size=UDim2.new(0,0,0,0)T:Create(fr,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Size=UDim2.new(0,300,0,220)}):Play()
print("oudai fly loaded")