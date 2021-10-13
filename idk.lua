

        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
        local win = lib:Window("Angerware",Color3.fromRGB(44, 120, 224), Enum.KeyCode.V)
        
        local Player = win:Tab("Player")
        lib:Notification("Angerware", "Thank you for using angerware! Created by Mex and Justice", "Nice!")
        local Combat = win:Tab("Combat")
        
        local Teleports = win:Tab("Locations")

        
        local autobuy = win:Tab("Buy")
        wait()
        for _, v in pairs(workspace.Ignored.Shop:GetChildren()) do
            autobuy:Button(v.Name, function()
                local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local k = game.Workspace.Ignored.Shop[v.Name]
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
                    wait(.2)
                    fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
                end
            end)
        end
        wait()
        
        local Cash = win:Tab("Cash")
        
        local Animations = win:Tab("Animations")
        
        local Specials = win:Tab("Extras")
        local target = win:Tab("Target")
        
        
        
        Player:Button("Fly (X)",function()
            
            local plr = game.Players.LocalPlayer
            local mouse = plr:GetMouse()
        
            localplayer = plr
        
            if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
            end
        
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
        
            spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
            end)
        
            workspace:WaitForChild("Core")
        
            local torso = workspace.Core
            flying = true
            local speed=10
            local keys={a=false,d=false,w=false,s=false} 
            local e1
            local e2
            local function start()
                local pos = Instance.new("BodyPosition",torso)
                local gyro = Instance.new("BodyGyro",torso)
                pos.Name="EPIXPOS"
                pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.position = torso.Position
                gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
                gyro.cframe = torso.CFrame
                repeat
                    wait()
                    localplayer.Character.Humanoid.PlatformStand=true
                    local new=gyro.cframe - gyro.cframe.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        speed=5
                    end
                    if keys.w then 
                        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed+0
                    end
                    if keys.s then 
                        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed+0
                    end
                    if keys.d then 
                        new = new * CFrame.new(speed,0,0)
                        speed=speed+0
                    end
                    if keys.a then 
                        new = new * CFrame.new(-speed,0,0)
                        speed=speed+0
                    end
                    if speed>10 then
                        speed=5
                    end
                    pos.position=new.p
                    if keys.w then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                    elseif keys.s then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                    else
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    end
                until flying == false
                if gyro then gyro:Destroy() end
                if pos then pos:Destroy() end
                flying=false
                localplayer.Character.Humanoid.PlatformStand=false
                speed=10
            end
            e1=mouse.KeyDown:connect(function(key)
                if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
                if key=="w" then
                    keys.w=true
                elseif key=="s" then
                    keys.s=true
                elseif key=="a" then
                    keys.a=true
                elseif key=="d" then
                    keys.d=true
                elseif key=="x" then
                    if flying==true then
                        flying=false
                    else
                        flying=true
                        start()
                    end
                end
            end)
            e2=mouse.KeyUp:connect(function(key)
                if key=="w" then
                    keys.w=false
                elseif key=="s" then
                    keys.s=false
                elseif key=="a" then
                    keys.a=false
                elseif key=="d" then
                    keys.d=false
                end
            end)
            start()
        print("Pressed!")
        end)
        Player:Slider("Fly Amount",0,500,10,function(t)
            print(t)
            end)
        Player:Slider("WalkSpeed",0,500,16,function(t)
            print(t)
            end)
            Player:Slider("JumpPower",0,500,50,function(t)
                print(t)
                end)
        
        Player:Button("Noclip (K)",function()
            noclip = false
            game:GetService("RunService").Stepped:connect(function()
                if noclip then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            end)
            plr = game.Players.LocalPlayer
            mouse = plr:GetMouse()
            mouse.KeyDown:connect(function(key)
                if key == "k" then
                    noclip = not noclip
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            end)
        print("Pressed!")
        end)
        Player:Button("Auto Stomp (C)",function()
            autostomp = false
            game:GetService("RunService").Stepped:connect(function()
                if autostomp then
                    game.ReplicatedStorage.MainEvent:FireServer("Stomp")
                end
            end)
            plr = game.Players.LocalPlayer
            mouse = plr:GetMouse()
            mouse.KeyDown:connect(function(key)
                if key == "c" then
                    autostomp = not autostomp
                    game.ReplicatedStorage.MainEvent:FireServer("Stomp")
                end
            end)
        print("Pressed!")
        end)
        Player:Button("Rejoin",function()
            if (#game:GetService("Players"):GetPlayers() <= 1) then
                game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
            end
        print("Pressed!")
        end)
        Player:Button("Anonymous",function()
            pcall(function()
                game.Players.LocalPlayer.Character.Shirt:Destroy()
                game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.RightUpperLeg.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.RightUpperLeg.Massless = true
                game.Players.LocalPlayer.Character.RightUpperLeg.CanCollide = false
        
                heazd = true
        
                while heazd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.RightUpperLeg.RightHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.RightUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
            wait(0.10)
            pcall(function()
                game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
                game.Players.LocalPlayer.Character.Pants:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.LeftUpperLeg.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.LeftUpperLeg.Massless = true
                game.Players.LocalPlayer.Character.LeftUpperLeg.CanCollide = false
        
                heazd = true
        
                while heazd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.LeftUpperLeg.LeftHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.LeftUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
            wait(0.10)
            pcall(function()
                game.Players.LocalPlayer.Character.Head.Neck:Destroy()
                game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.Head.Massless = true
                game.Players.LocalPlayer.Character.Head.CanCollide = false
        
                heazd = true
        
                while heazd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
        print("Pressed!")
        end)
        Player:Button("Auto Block",function()
            while wait() do
                game.ReplicatedStorage.MainEvent:FireServer("Block", true)
            end
        print("Pressed!")
        end)
        Player:Button("Anti Bag",function()
            while wait() do
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Christmas_Sock"):Destroy()
                end)
            end
        print("Pressed!")
        end)
        Player:Button("Anti Grab",function()
            while wait() do
                pcall(function()
                    local LocalPlayer = game:GetService("Players").LocalPlayer
                    local char = LocalPlayer.Character
                    if game.Players.LocalPlayer.Character["GRABBING_CONSTRAINT"] then
                        game.Players.LocalPlayer.Character["GRABBING_CONSTRAINT"]:Destroy()
                    end
                end)
            end
            print("Pressed!")
            end)
            Player:Button("Anti Fling",function()
                while wait() do
                    game.ReplicatedStorage.MainEvent:FireServer("Block", true)
                end
            print("Pressed!")
            end)
        Player:Button("Headless",function()
            pcall(function()
                game.Players.LocalPlayer.Character.Head.Neck:Destroy()
                game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
                game.Players.LocalPlayer.Character.Head.Massless = true
                game.Players.LocalPlayer.Character.Head.CanCollide = false
        
                heazd = true
        
                while heazd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame = CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
        print("Pressed!")
        end)
        Player:Button("Animation Pack",function()
                -- // Delete Clones
            for _, v in next, game:GetService("CoreGui"):GetChildren() do
                if (v.Name:match("FreeAnimationPack")) then
                    v:Destroy()
                end
            end
        
            -- // Instances
            local FreeAnimationPack = Instance.new("ScreenGui")
            local AnimationPack = Instance.new("TextButton")
            local Animations = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local Lean = Instance.new("TextButton")
            local Lay = Instance.new("TextButton")
            local Dance1 = Instance.new("TextButton")
            local Dance2 = Instance.new("TextButton")
            local Greet = Instance.new("TextButton")
            local ChestPump = Instance.new("TextButton")
            local Praying = Instance.new("TextButton")
            local Stop = Instance.new("TextButton")
            local UniversalAnimation = Instance.new("Animation")
        
            -- // Utility
            function stopTracks()
                for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                    if (v.Animation.AnimationId:match("rbxassetid")) then
                        v:Stop()
                    end
                end
            end
        
            function loadAnimation(id)
                if UniversalAnimation.AnimationId == id then
                    stopTracks()
                    UniversalAnimation.AnimationId = "1"
                else
                    UniversalAnimation.AnimationId = id
                    local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
                    animationTrack:Play()
                end
            end
        
            -- // Properties
            FreeAnimationPack.Name = "FreeAnimationPack"
            FreeAnimationPack.Parent = game.CoreGui
            FreeAnimationPack.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
            AnimationPack.Name = "AnimationPack"
            AnimationPack.Parent = FreeAnimationPack
            AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AnimationPack.BorderSizePixel = 0
            AnimationPack.Position = UDim2.new(0, 0, 0.388007045, 0)
            AnimationPack.Size = UDim2.new(0, 100, 0, 20)
            AnimationPack.Font = Enum.Font.SourceSansBold
            AnimationPack.Text = "Animations"
            AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
            AnimationPack.TextSize = 18.000
            AnimationPack.MouseButton1Click:Connect(function()
                if (Animations.Visible == false) then
                    Animations.Visible = true
                end
            end)
        
            Animations.Name = "Animations"
            Animations.Parent = AnimationPack
            Animations.Active = true
            Animations.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
            Animations.Position = UDim2.new(-0.104712225, 0, -1.54173493, 0)
            Animations.Size = UDim2.new(0, 120, 0, 195)
            Animations.Visible = false
            Animations.CanvasPosition = Vector2.new(0, 60.0000305)
            Animations.CanvasSize = UDim2.new(0, 0, 1, 235)
        
            UIListLayout.Parent = Animations
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 2)
        
            Lean.Name = "Lean"
            Lean.Parent = Animations
            Lean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Lean.Size = UDim2.new(1, 0, 0, 30)
            Lean.Font = Enum.Font.SourceSansBold
            Lean.Text = "Lean"
            Lean.TextColor3 = Color3.fromRGB(0, 0, 0)
            Lean.TextSize = 14.000
            Lean.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3152375249")
            end)
        
            Lay.Name = "Lay"
            Lay.Parent = Animations
            Lay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Lay.Size = UDim2.new(1, 0, 0, 30)
            Lay.Font = Enum.Font.SourceSansBold
            Lay.Text = "Lay"
            Lay.TextColor3 = Color3.fromRGB(0, 0, 0)
            Lay.TextSize = 14.000
            Lay.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3152378852")
            end)
        
            Dance1.Name = "Dance1"
            Dance1.Parent = Animations
            Dance1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dance1.Size = UDim2.new(1, 0, 0, 30)
            Dance1.Font = Enum.Font.SourceSansBold
            Dance1.Text = "Dance1"
            Dance1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dance1.TextSize = 14.000
            Dance1.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189773368")
            end)
        
            Dance2.Name = "Dance2"
            Dance2.Parent = Animations
            Dance2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dance2.Size = UDim2.new(1, 0, 0, 30)
            Dance2.Font = Enum.Font.SourceSansBold
            Dance2.Text = "Dance2"
            Dance2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dance2.TextSize = 14.000
            Dance2.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189776546")
            end)
        
            Greet.Name = "Greet"
            Greet.Parent = Animations
            Greet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Greet.Size = UDim2.new(1, 0, 0, 30)
            Greet.Font = Enum.Font.SourceSansBold
            Greet.Text = "Greet"
            Greet.TextColor3 = Color3.fromRGB(0, 0, 0)
            Greet.TextSize = 14.000
            Greet.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189777795")
            end)
        
            ChestPump.Name = "ChestPump"
            ChestPump.Parent = Animations
            ChestPump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChestPump.Size = UDim2.new(1, 0, 0, 30)
            ChestPump.Font = Enum.Font.SourceSansBold
            ChestPump.Text = "Chest Pump"
            ChestPump.TextColor3 = Color3.fromRGB(0, 0, 0)
            ChestPump.TextSize = 14.000
            ChestPump.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189779152")
            end)
        
            Praying.Name = "Praying"
            Praying.Parent = Animations
            Praying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Praying.Size = UDim2.new(1, 0, 0, 30)
            Praying.Font = Enum.Font.SourceSansBold
            Praying.Text = "Praying"
            Praying.TextColor3 = Color3.fromRGB(0, 0, 0)
            Praying.TextSize = 14.000
            Praying.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3487719500")
            end)
        
            Stop.Name = "Stop"
            Stop.Parent = Animations
            Stop.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
            Stop.Size = UDim2.new(1, 0, 0, 30)
            Stop.Font = Enum.Font.SourceSansBold
            Stop.Text = "Stop Animation"
            Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
            Stop.TextSize = 14.000
            Stop.MouseButton1Click:Connect(function()
                stopTracks()
            end)
            --scripts
            local plr = game.Players.LocalPlayer
        
            plr:GetMouse().KeyDown:Connect(function(K)
                if K == "p" then
                    Animations.Visible = false
                end
            end)
        print("Pressed!")
        end)
        Player:Button("Naked",function()
            local function inTable(What, Table)
                for Index, Value in pairs(Table) do
                    if What == Value then
                        return true
                    end
                end
                return false
            end
        
            local removingClasses = {
                "Accessory",
                "Pants",
                "Shirt",
            }
        
            for _, Instance in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if inTable(Instance.ClassName, removingClasses) or Instance.Name == "face" then
                    Instance:Destroy()
                end
            end
        print("Pressed!")
        end)
        Player:Button("Unjail",function()
            if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value >= 125 then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
                wait()
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
                wait(.1)
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
                repeat
                    wait()
                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Key]")
                local Hum = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Hum.Health > 0 then
                    key1 = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Key]")
                    if key1 then
                        Hum:EquipTool(key1)
                        for i, v in pairs(game:GetService"Players".LocalPlayer.Character:GetChildren()) do
                            if v:isA("Tool") then
                                game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(key1)
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
                                v:Activate()
                            end
                        end
                    end
                end
            end
        print("Pressed!")
        end)
        Player:Button("Unban",function()
        
        end)
        
                                    -- Combat
        
                                    Combat:Button("Free Fists (T)",function()
                                        -- // Variables
                                        local localPlayer       = game:GetService("Players").LocalPlayer
                                        local localCharacter    = localPlayer.Character
                                        local Mouse             = localPlayer:GetMouse()
                                        local FistControl       = false
                                        local LeftFist          = localCharacter.LeftHand
                                        local RightFist         = localCharacter.RightHand
                                    
                                        -- // Services
                                        local uis = game:GetService("UserInputService")
                                    
                                        -- // Coroutine Loop + Functions
                                        local loopFunction = function()
                                            LeftFist.CFrame  = CFrame.new(Mouse.Hit.p)
                                            RightFist.CFrame = CFrame.new(Mouse.Hit.p)
                                        end
                                    
                                        local Loop
                                    
                                        local Start = function()
                                            Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction)
                                        end
                                    
                                        local Pause = function()
                                            Loop:Disconnect()
                                        end
                                    
                                        -- // Hotkeys
                                        uis.InputBegan:connect(function(Key)
                                            if (Key.KeyCode == Enum.KeyCode.T) then
                                                if (FistControl == false) then
                                                    FistControl = true
                                                    Start()
                                                    pcall(function()
                                                        localCharacter.RightHand.RightWrist:Remove()
                                                        localCharacter.LeftHand.LeftWrist:Remove()
                                                    end)
                                                elseif (FistControl == true) then
                                                    FistControl = false
                                                    Pause()
                                                    local rightwrist  = Instance.new("Motor6D")
                                                    rightwrist.Name   = "RightWrist"
                                                    rightwrist.Parent = localCharacter.RightHand
                                                    rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                                    rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                                    rightwrist.Part0  = localCharacter.RightLowerArm
                                                    rightwrist.Part1  = localCharacter.RightHand
                                    
                                                    local leftwrist   = Instance.new("Motor6D")
                                                    leftwrist.Name    = "LeftWrist"
                                                    leftwrist.Parent  = localCharacter.LeftHand
                                                    leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                                    leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                                    leftwrist.Part0   = localCharacter.LeftLowerArm
                                                    leftwrist.Part1   = localCharacter.LeftHand
                                                end
                                            end
                                        end)
                                    print("Pressed!")
                                    end)
                                    Combat:Button("Fist Reach",function()
                                        LP = game.Players.LocalPlayer 
                                    
                                        for i,v in ipairs(LP.Character:GetDescendants()) do 
                                            if v:IsA("MeshPart") then v.Massless = true 
                                                v.CanCollide = false 
                                                v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0) 
                                            end 
                                        end 
                                    
                                        for i,v in ipairs(game.workspace:GetDescendants()) do 
                                            if v:IsA("Seat") then 
                                                v.Disabled = true 
                                            end 
                                        end 
                                    
                                        x = 45
                                        y = 45 
                                        z = 45
                                    
                                        penis = Vector3.new(x,y,z) 
                                    
                                        LP.Character.RightHand.Size = penis 
                                        LP.Character.RightHand.Transparency = 1
                                    
                                        local selectionBox = Instance.new("SelectionBox",LP.Character.RightHand) 
                                        selectionBox.Adornee = LP.Character.RightHand 
                                        selectionBox = Enum.Material.Neon 
                                    
                                        LP.Character.LeftHand.Size = penis
                                        LP.Character.LeftHand.Transparency = 1
                                    
                                        LP.Character.BodyEffects.SpecialParts.LeftHand.Size = penis 
                                        LP.Character.LeftHand.Transparency = 1
                                    
                                        local selectionBox = Instance.new("SelectionBox",LP.Character.LeftHand) 
                                        selectionBox.Adornee = LP.Character.LeftHand 
                                        selectionBox = Enum.Material.Neon
                                        print("Pressed!")
                                        end)
                                        Combat:Button("Tool Reach",function()
                                            for i, v in pairs(game:GetService"Players".LocalPlayer.Character:GetChildren()) do
                                                if v:isA("Tool") then
                                                    local a = Instance.new("SelectionBox", v.Handle)
                                                    a.Adornee = v.Handle
                                                    v.Handle.Size = Vector3.new(50, 50, 50)
                                                    v.Handle.Transparency = 1
                                                    v.GripPos = Vector3.new(0, 0, 0)
                                                end
                                            end
                                            print("Pressed!")
                                            end)
                                            Combat:Button("Anti Stomp",function()
                                                if game.PlaceId == 2788229376 then repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("FULLY_LOADED_CHAR") else return end
                                        repeat wait() until false
                                    
                                        pcall(function() 
                                            local corepackages = game:GetService"CorePackages" 
                                            local localplayer = game:GetService"Players".LocalPlayer 
                                            local run = game:GetService"RunService" run:BindToRenderStep("rrrrrrrrrrr",2000,function() 
                                                pcall(function() 
                                                    if localplayer.Character.BodyEffects["K.O"].Value then 
                                                        localplayer.Character.Humanoid:UnequipTools() 
                                                        localplayer.Character.Humanoid:Destroy() workspace.CurrentCamera.CameraSubject = localplayer.Character 
                                                        wait() 
                                                        local prt = Instance.new("Model", corepackages) Instance.new("Part", prt).Name="Torso" Instance.new("Part", prt).Name="Head" Instance.new("Humanoid", prt).Name="Humanoid" localplayer.Character=prt
                                                    end 
                                                end)
                                            end)
                                        end)
                                                print("Pressed!")
                                                end)
                                                Combat:Button("Wallhack",function()
                                                    print("Pressed!")
                                                    end)
                                                    Combat:Button("Auto Armor",function()
                                                        print("Pressed!")
                                                        end)
                                                    Combat:Button("Aimbot",function()
                                                        print("Pressed!")
                                                        end)
                                                        Combat:Button("Silent Aim",function()
                                                            print("Pressed!")
                                                            end)
                                                            Combat:Button("Anti Fling",function()
                                                                print("Pressed!")
                                                                end)
                                                                Combat:Button("Godmode (Guns)",function()
                                                                    game.Players.LocalPlayer.DataFolder.Information.Jail.Value = 0 --new
                                                game.Players.LocalPlayer.Character.Humanoid.Health = 0;
                                                local localPlayer = game:GetService('Players').LocalPlayer;
                                                local newCharacter = localPlayer.CharacterAdded:Wait();
                                                --game.Players.LocalPlayer.Character:ClearAllChildren()
                                                local money = Instance.new("Folder", newCharacter);
                                                money.Name = "FULLY_LOADED_CHAR"
                                                newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                                                local spoofValue = Instance.new('BoolValue', newCharacter.BodyEffects);
                                                newCharacter:WaitForChild("BodyEffects")
                                                newCharacter.BodyEffects.BreakingParts:Destroy()
                                                                    print("Pressed!")
                                                                    end)
                                                                    Combat:Button("Godmode (Melees)",function()
                                                                        game:GetService("Players").LocalPlayer.DataFolder.Information.Jail.Value = 0
                                                game:GetService("Players").LocalPlayer.Character.BodyEffects:FindFirstChild("K.O").Value = false
                                                wait()
                                                game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(15)
                                                wait()
                                                local Char = game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
                                                local Fold = Instance.new("Folder")
                                                Fold.Name = "FULLY_LOADED_CHAR"
                                                Fold.Parent = Char
                                                Char:WaitForChild("RagdollConstraints"):Destroy()
                                                local Val = Instance.new("BoolValue", Char)
                                                Val.Name = "RagdollConstraints"
                                                wait(8)
                                                game:GetService("Players").LocalPlayer.Character.BodyEffects.Defense:Destroy()
                                                Instance.new("NumberValue").Name = "Defense"
                                                Instance.new("NumberValue").Parent = game:GetService("Players").LocalPlayer.Character.BodyEffects
                                                game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)
                                                local plr = game.Players.LocalPlayer
            plr.Character.Humanoid.Health = 0
            local newchar = plr.CharacterAdded:Wait()
            local foldSpoof = Instance.new("Folder",newchar)
            foldSpoof.Name = "FULLY_LOADED_CHAR"
            newchar:WaitForChild("RagdollConstraints"):Destroy()
            local valSpoof = Instance.new("IntValue", newchar:WaitForChild("BodyEffects"))
            valSpoof.Name = "Armor"
            valSpoof.Value = 100
            newchar:WaitForChild("BodyEffects").Armor:Destroy()
            game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)
                                                                            print("Pressed!")
                                                                    end)
                                                                    Combat:Button("Godbullet",function()
                                                                        local plr = game.Players.LocalPlayer
                                                plr.Character.Humanoid.Health = 0
                                                local newchar = plr.CharacterAdded:Wait()
                                                local foldSpoof = Instance.new("Folder",newchar)
                                                foldSpoof.Name = "FULLY_LOADED_CHAR"
                                                newchar:WaitForChild("RagdollConstraints"):Destroy()
                                                local valSpoof = Instance.new("IntValue", newchar:WaitForChild("BodyEffects"))
                                                valSpoof.Name = "Armor"
                                                valSpoof.Value = 100
                                                newchar:WaitForChild("BodyEffects").Armor:Destroy()
                                                game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)
                                                                        print("Pressed!")
                                                                        end)
                                                                        Combat:Button("Godblock",function()
                                                                            game:GetService("Players").LocalPlayer.DataFolder.Information.Jail.Value = 0
                                                game:GetService("Players").LocalPlayer.Character.BodyEffects:FindFirstChild("K.O").Value = false
                                                wait()
                                                game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(15)
                                                wait()
                                                local Char = game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
                                                local Fold = Instance.new("Folder")
                                                Fold.Name = "FULLY_LOADED_CHAR"
                                                Fold.Parent = Char
                                                Char:WaitForChild("RagdollConstraints"):Destroy()
                                                local Val = Instance.new("BoolValue", Char)
                                                Val.Name = "RagdollConstraints"
                                                wait(8)
                                                game:GetService("Players").LocalPlayer.Character.BodyEffects.Defense:Destroy()
                                                Instance.new("NumberValue").Name = "Defense"
                                                Instance.new("NumberValue").Parent = game:GetService("Players").LocalPlayer.Character.BodyEffects
                                                game:GetService("ReplicatedStorage").MainEvent:FireServer("UpdateMousePos", game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)
                                                                            print("Pressed!")
                                                                            end)

                                                                                    Combat:Button("Silent Block",function()
                                                                                        print("Pressed!")
                                                                                        end)
                                                                                        Combat:Button("Silent Charge",function()
                                                                                            print("Pressed!")
                                                                                            end)
                                                                                            
        
        
                                    -- Teleports
        

                                                                                            Teleports:Button("Uphill",function()
                                                                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(182.35, 47.75, -570.97)
                                                                                                print("Pressed!")
                                                                                                end)
                                                                                                Teleports:Button("Train Track",function()
                                                                                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(644.05, 48, -70.86)
                                                                                                    print("Pressed!")
                                                                                                    end)
                                                                                                    Teleports:Button("Basketball Court",function()
                                                                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-932.59, 22.1, -482.18)
                                                                                                        print("Pressed!")
                                                                                                        end)
                                                                                            Teleports:Button("School",function()
                                                                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-653.862244, 21.7499981, 266.467102, -0.999999702, 1.15190595e-07, -0.000802431023, 1.15165044e-07, 1, 3.18860742e-08, 0.000802431023, 3.17936539e-08, -0.999999702)
                                                                                                print("Pressed!")
                                                                                                end)
Teleports:Button("Bank", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
end)
Teleports:Button("Boxing Place", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-236.006, 23.151, -1120.531)
end)
Teleports:Button("Police Station", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-267.637, 21.807, -121.982)
end)
Teleports:Button("Admin Base", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-729.895, -37.642, -885.8)
end)
Teleports:Button("Sewers", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(112.622, -26.212, -277.321)
end)
Teleports:Button("Shoe Store", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.Ignored.Drop:FindFirstChildOfClass("MeshPart").Position)
end)
Teleports:Button("Hospital", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.518, 21.755, -481.680)
end)
Teleports:Button("Phone Store", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-120.121, 22.946, -870.425)
end)
Teleports:Button("Taco Shack", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(546.946, 51.061, -493.325)
end)
Teleports:Button("Casino", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-879.277, 21.254, -190.199)
end)
Teleports:Button("UFO", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71.565, 142.926, -690.33)
end)
Teleports:Button("Fire Station", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-132.674, 21.280, -145.176)
end)
Teleports:Button("Gas Station", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(595.377, 49.000, -264.222)
end)
Teleports:Button("Church", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(203.938, 21.75, -98.446)
end)
Teleports:Button("Gun Store 1", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-582, 7.172, -739.015)
end)
Teleports:Button("Gun Store 2", function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(475.022, 48.005, -603.737)
end)
        -- Auto Farm --
        Cash:Toggle("Auto Drop" ,false, function(state)
            if state then
                getgenv().click = true
                while wait() do
                    if getgenv().click == true then
                        
                -- Script generated by SimpleSpy - credits to exx#9394
                game.ReplicatedStorage.MainEvent:FireServer("DropMoney", _G.CashDropAmount)
        local A_1 = "DropMoney"
        local A_2 = "10000"
        local Event = game:GetService("ReplicatedStorage").MainEvent
        Event:FireServer(A_1, A_2)
        end
        end
        
                print("Toggle On")
            else
                getgenv().click = false
                print("Toggle Off")
        
            end
        end)
                Cash:Slider("Auto Drop Amount",0,10000,0,function(cash)
                   
                       end)
                

                    Cash:Textbox("Custom Fake Cash",function(value, focusLost)
                        if focusLost then
                            game.Players.LocalPlayer.PlayerGui.Framework.CurrencySound:Play()
                            game.Players.LocalPlayer.DataFolder.Currency.Value = value
                            game.Players.LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text = "$"..value
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Wallet") then
                                game.Players.LocalPlayer.Backpack.Wallet.Handle.BillboardGui.TextLabel.Text = "$"..value
                               
                            else
                                game.Players.LocalPlayer.Character.Wallet.Handle.BillboardGui.TextLabel.Text = "$"..value
                            end
                        end
                    end)
                            Cash:Slider("Fake Cash Amount",0,1000000000,0,function(value)
                                game.Players.LocalPlayer.PlayerGui.Framework.CurrencySound:Play()
            game.Players.LocalPlayer.DataFolder.Currency.Value = value
            game.Players.LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text = "$"..value
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Wallet") then
                game.Players.LocalPlayer.Backpack.Wallet.Handle.BillboardGui.TextLabel.Text = "$"..value
            else
                game.Players.LocalPlayer.Character.Wallet.Handle.BillboardGui.TextLabel.Text = "$"..value
            end
                                print(t)
                                end)
                    Cash:Toggle("Auto Pickup",function(t)
                        print(t)
                            end)
                            Cash:Button("Cash ESP",function()
                                local ESPholder = Instance.new("Folder", game.CoreGui)
            function cham(object)
                if object.Name == "MoneyDrop" then
                    local a = Instance.new("BoxHandleAdornment", ESPholder)
                    a.Adornee = object
                    a.AlwaysOnTop = true
                    a.ZIndex = 10
                    a.Size = object.Size
                    a.Transparency = 0.3
                    a.Color = object.BrickColor
                    local bill = object:WaitForChild("BillboardGui")
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(2, 10, 1, 5)
                    spawn(function()
                        while true do
                            if object.Parent.ChildRemoving:wait() == object then
                                a:Destroy()
                                break
                            end
                        end
                    end)
                end
            end
            for i, v in next, game.Workspace.Ignored.Drop:GetChildren() do
                cham(v)
            end
            game.Workspace.Ignored.Drop.ChildAdded:connect(cham)
                                print(t)
                                end)
                    Cash:Button("Cash Fling",function()
                        print("Pressed!")
                        end)
                        Cash:Button("Cash Shield",function()
                            print("Pressed!")
                            end)
                            Cash:Button("Bring Cash",function()
                                print("Pressed!")
                                end)													
        
                                -- Animation -- 
        
                                Animations:Button("Old School",function()
                                    print("Pressed!")
                                    end)
                                    Animations:Button("Toy",function()
                                        local Animate = game.Players.LocalPlayer.Character.Animate
                                        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
                                        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
                                        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
                                        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
                                        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
                                        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
                                        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
                                        game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                        print("Pressed!")
                                        end)
                                        Animations:Button("Stylish",function()
                                            local Animate = game.Players.LocalPlayer.Character.Animate
                                            Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
                                            Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
                                            Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
                                            Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
                                            Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
                                            Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
                                            Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
                                            game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                            print("Pressed!")
                                            end)
                                            Animations:Button("Robot",function()
                                                local Animate = game.Players.LocalPlayer.Character.Animate
                                                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
                                                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
                                                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
                                                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
                                                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
                                                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
                                                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
                                                game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                print("Pressed!")
                                                end)
                                                    Animations:Button("Bubbly",function()
                                                        local Animate = game.Players.LocalPlayer.Character.Animate
                                    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
                                    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=910009958"
                                    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
                                    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
                                    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
                                    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
                                    Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=910030921"
                                    Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=910028158"
                                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                        print("Pressed!")
                                                        end)
                                                        Animations:Button("Cartoony",function()
                                                            local Animate = game.Players.LocalPlayer.Character.Animate
                                    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
                                    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
                                    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
                                    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
                                    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
                                    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
                                    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
                                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                            print("Pressed!")
                                                            end)
                                                            Animations:Button("Zombie",function()
                                                                local Animate = game.Players.LocalPlayer.Character.Animate
                                                                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
                                                                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
                                                                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
                                                                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
                                                                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
                                                                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
                                                                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
                                                                game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                print("Pressed!")
                                                                end)
                                                                Animations:Button("Mage",function()
                                                                    local Animate = game.Players.LocalPlayer.Character.Animate
                                                                    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
                                                                    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
                                                                    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
                                                                    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
                                                                    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
                                                                    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
                                                                    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
                                                                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                    print("Pressed!")
                                                                    end)
                                                                    Animations:Button("Ninja",function()
                                                                        local Animate = game.Players.LocalPlayer.Character.Animate
                                                                        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
                                                                        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
                                                                        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
                                                                        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
                                                                        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
                                                                        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
                                                                        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
                                                                        game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                        print("Pressed!")
                                                                        end)
                                                                        Animations:Button("Elder",function()
                                                                            local Animate = game.Players.LocalPlayer.Character.Animate
                                                                            Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
                                                                            Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
                                                                            Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
                                                                            Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
                                                                            Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
                                                                            Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
                                                                            Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
                                                                            game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                            print("Pressed!")
                                                                            end)
                                                                            Animations:Button("Superhero",function()
                                                                                local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
                                                                                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
                                                                                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
                                                                                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
                                                                                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
                                                                                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
                                                                                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
                                                                                game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                print("Pressed!")
                                                                                end)
                                                                                Animations:Button("Astronaunt",function()
                                                                                    local Animate = game.Players.LocalPlayer.Character.Animate
                                    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
                                    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
                                    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
                                    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
                                    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
                                    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
                                    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
                                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                    print("Pressed!")
                                                                                    end)
                                                                                    Animations:Button("Vampire",function()
                                                                                        local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
                                                                                        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
                                                                                        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
                                                                                        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
                                                                                        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
                                                                                        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
                                                                                        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
                                                                                        game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                        print("Pressed!")
                                                                                        end)
                                                                                        Animations:Button("Werewolf",function()
                                                                                            local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                            Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
                                                                                            Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
                                                                                            Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
                                                                                            Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
                                                                                            Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
                                                                                            Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
                                                                                            Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
                                                                                            game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                            print("Pressed!")
                                                                                            end)
                                                                                            Animations:Button("Levitation",function()
                                                                                                local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
                                                                                                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
                                                                                                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
                                                                                                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
                                                                                                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
                                                                                                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
                                                                                                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
                                                                                                print("Pressed!")
                                                                                                end)
                                                                                                Animations:Button("Knight",function()
                                                                                                    local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                                    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
                                                                                                    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
                                                                                                    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
                                                                                                    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
                                                                                                    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
                                                                                                    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
                                                                                                    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
                                                                                                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                                    print("Pressed!")
                                                                                                    end)
                                                                                                    Animations:Button("Pirate",function()
                                                                                                        local Animate = game.Players.LocalPlayer.Character.Animate
                                                                                                        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
                                                                                                        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
                                                                                                        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
                                                                                                        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
                                                                                                        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
                                                                                                        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
                                                                                                        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
                                                                                                        game.Players.LocalPlayer.Character.Humanoid.Jump = true
                                                                                                        print("Pressed!")
                                                                                                        end)
        
                                                                                                        -- specials --
        
                                                                                                        Specials:Button("Auto Reload",function()
                                                                                                            local sucess = nil
                                                                                                            while wait(0.5) do
                                                                                                                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                                                                                                    if v:FindFirstChild("Ammo") and v.Ammo.Value ~= 0 then
                                                                                                                        v.Parent = game.Players.LocalPlayer.Character
                                                                                                                    end
                                                                                                                end
                                                                                                                for ii, vv in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                                                                                                    if vv:FindFirstChild("Ammo") and vv.Ammo.Value == 0 then
                                                                                                                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                                                                                                    end
                                                                                                                end
                                                                                                                for iii, vvv in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                                                                                                    if vvv:FindFirstChild("Ammo") and vvv.Ammo.Value ~= 0 then 
                                                                                                                        sucess = true
                                                                                                                    end
                                                                                                                end
                                                                                                                if not sucess ==  true then
                                                                                                                    for iiii, vvvv in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                                                                                                                        if vvvv:FindFirstChild("Ammo") and vvvv.Ammo.Value == 0 then
                                                                                                                            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                                                                                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(vvvv)
                                                                                                                            game.ReplicatedStorage.MainEvent:FireServer("Reload", vvvv)
                                                                                                                            repeat wait() until vvvv.Ammo.Value ~= 0
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                                sucess = nil
                                                                                                            end
                                                                                                            print("Pressed!")
                                                                                                            end)
                                                                                                            Specials:Button("Anti Boombox",function()
                                                                                                                print("Pressed!")
                                                                                                                end)
                                                                                                                Specials:Button("Boombox Freeze",function()
                                                                                                                    coroutine.wrap(function()
                                                                                                                        while wait() do
                                                                                                                            for i,v in pairs(game.Players:GetPlayers()) do
                                                                                                                                pcall(function()
                                                                                                                                    v.Character.LowerTorso:FindFirstChild("BOOMBOXSOUND").SoundId=""
                                                                                                                                end)
                                                                                                                            end
                                                                                                                        end 
                                                                                                                        end)()
                                                                                                                        coroutine.wrap(function()
                                                                                                                            while wait(.3) do
                                                                                                                                coroutine.wrap(function()
                                                                                                                                    pcall(function()
                                                                                                                                        if game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild("BOOMBOXSOUND") then
                                                                                                                                            game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild("BOOMBOXSOUND"):Destroy()
                                                                                                                                        end
                                                                                                                                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Boombox","6947054675")
                                                                                                                                        repeat wait() until game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild("BOOMBOXSOUND")
                                                                                                                                        game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild("BOOMBOXSOUND").SoundId=""
                                                                                                                                    end)
                                                                                                                                end)()
                                                                                                                            end
                                                                                                                        end)()
                                                                                                                    print("Pressed!")
                                                                                                                    end)
                                                                                                                        Specials:Button("No Recoil",function()
                                                                                                                            while wait() do
                                                                                                                                if game:GetService("Players").LocalPlayer.Character.BodyEffects.Reload.Value == true then
                                                                                                                                    game:GetService("Players").LocalPlayer.Character.BodyEffects.Reload.Value = false
                                                                                                                                end
                                                                                                                            end
                                                                                                                            print("Pressed!")
                                                                                                                            end)
                                                                                                                            Specials:Button("RLX",function()
                                                                                                                                loadstring(game:HttpGet('https://raw.githubusercontent.com/angercc/lock/main/ware.lua'))()
                                                                                                                                print("Pressed!")
                                                                                                                                end)
                                                                                                                                Specials:Button("Chatlogs",function()
                                                                                                                                    enabled = true
                                                                                                            spyOnMyself = false
                                                                                                            public = false
                                                                                                            publicItalics = true
                                                                                                            privateProperties = {
                                                                                                                Color = Color3.fromRGB(0, 255, 255),
                                                                                                                Font = Enum.Font.SourceSansBold,
                                                                                                                TextSize = 18
                                                                                                            }
                                                                                                            local StarterGui = game:GetService("StarterGui")
                                                                                                            local Players = game:GetService("Players")
                                                                                                            local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
                                                                                                            local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
                                                                                                            local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
                                                                                                            local instance = (_G.chatSpyInstance or 0) + 1
                                                                                                            _G.chatSpyInstance = instance
                                                                                                        
                                                                                                            local function onChatted(p, msg)
                                                                                                                if _G.chatSpyInstance == instance then
                                                                                                                    if p == player and msg:lower():sub(1, 4) == "/spy" then
                                                                                                                        enabled = not enabled
                                                                                                                        wait(0.3)
                                                                                                                        privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
                                                                                                                        StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                                                                                                                    elseif enabled and (spyOnMyself == true or p ~= player) then
                                                                                                                        msg = msg:gsub("[\n\r]", ""):gsub("\t", " "):gsub("[ ]+", " ")
                                                                                                                        local hidden = true
                                                                                                                        local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
                                                                                                                            if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and public == false and Players[packet.FromSpeaker].Team == player.Team)) then
                                                                                                                                hidden = false
                                                                                                                            end
                                                                                                                        end)
                                                                                                                        wait(1)
                                                                                                                        conn:Disconnect()
                                                                                                                        if hidden and enabled then
                                                                                                                            if public then
                                                                                                                                saymsg:FireServer((publicItalics and "/me " or "").."{SPY} ["..p.Name.."]: "..msg, "All")
                                                                                                                            else
                                                                                                                                privateProperties.Text = "{SPY} ["..p.Name.."]: "..msg
                                                                                                                                StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        
                                                                                                            for _, p in ipairs(Players:GetPlayers()) do
                                                                                                                p.Chatted:Connect(function(msg)
                                                                                                                    onChatted(p, msg)
                                                                                                                end)
                                                                                                            end
                                                                                                            Players.PlayerAdded:Connect(function(p)
                                                                                                                p.Chatted:Connect(function(msg)
                                                                                                                    onChatted(p, msg)
                                                                                                                end)
                                                                                                            end)
                                                                                                            privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
                                                                                                            StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                                                                                                            if not player.PlayerGui:FindFirstChild("Chat") then
                                                                                                                wait(3)
                                                                                                            end
                                                                                                            local chatFrame = player.PlayerGui.Chat.Frame
                                                                                                            chatFrame.ChatChannelParentFrame.Visible = true
                                                                                                            chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
                                                                                                                                    print("Pressed!")
                                                                                                                                    end)
                                                                                                                                    Specials:Button("Korblox",function()
                                                                                                                                        game:GetService("Players").LocalPlayer.Character.RightUpperLeg:Destroy()
                                                                                                        
                                                                                                                                        print("Pressed!")
                                                                                                                                        end)
                                                                                                                                        Specials:Button("Show Users",function()
                                                                                                                                            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                                                                                                                                if v and v.Character and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.Viewer then
                                                                                                                                                    v.Character:FindFirstChildOfClass("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                            print("Pressed!")
                                                                                                                                            end)
                                                                                                                                            Specials:Button("Burger Shield",function()
                                                                                                                                                print("Pressed!")
                                                                                                                                                end)
                                                                                                                                                Specials:Button("Burger Galaxy",function()
                                                                                                                                                    print("Pressed!")
                                                                                                                                                    end)
                                                                                                                                                Specials:Button("Play All Sounds",function()
                                                                                                                                                    print("Pressed!")
                                                                                                                                                    end)
                                                                                                                                                    Specials:Button("Dick Bat",function()
                                                                                                                                                        local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                                                                                                            local k = game.Workspace.Ignored.Shop["[Bat] - $250"]
                                                                                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
                                                                                                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
                                                                                                                wait(.2)
                                                                                                                fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
                                                                                                                toolf = game.Players.LocalPlayer.Backpack:WaitForChild("[Bat]")
                                                                                                                toolf.Parent = game.Players.LocalPlayer.Character
                                                                                                                wait()
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[Bat]")
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[Bat]").Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripForward = Vector3.new(0, -1, -0)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripUp = Vector3.new(-500000, 404, 5000000)
                                                                                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
                                                                                                            end
                                                                                                                                                        print("Pressed!")
                                                                                                                                                        end)
                                                                                                                                                        Specials:Button("Dick LMG",function()
                                                                                                                                                            local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                                                                                                            local k = game.Workspace.Ignored.Shop["[LMG] - $3750"]
                                                                                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
                                                                                                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
                                                                                                                wait(.2)
                                                                                                                fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
                                                                                                                toolf = game.Players.LocalPlayer.Backpack:WaitForChild("[LMG]")
                                                                                                                toolf.Parent = game.Players.LocalPlayer.Character
                                                                                                                wait()
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[LMG]")
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[LMG]").Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripForward = Vector3.new(0, -1, -0)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
                                                                                                                game.Players.LocalPlayer.Character:WaitForChild("[LMG]").GripUp = Vector3.new(-500000, 404, 5000000)
                                                                                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
                                                                                                            end
                                                                                                                                                            print("Pressed!")
                                                                                                                                                            end)
                                                                                                                                                            Specials:Button("Equip All",function()
                                                                                                                                                                print("Pressed!")
                                                                                                                                                                end)
                                                                                                                                                                Specials:Button("Super Taser",function()
                                                                                                                                                                    function TAZE(TARGET)
                                                                                                                                                                        local Plr = game.Players.LocalPlayer
                                                                                                                                                                        local a = {}
                                                                                                                                                                        repeat
                                                                                                                                                                            Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Taser] - $1000"].Head.CFrame
                                                                                                                                                                            wait(0.5)
                                                                                                                                                                            fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Taser] - $1000"].ClickDetector)
                                                                                                                                                                            for i, v in pairs(Plr.Backpack:GetChildren()) do
                                                                                                                                                                                if v.Name == "[Taser]" then
                                                                                                                                                                                    table.insert(a, v)
                                                                                                                                                                                    v.Parent = Plr.Character
                                                                                                                                                                                end
                                                                                                                                                                            end
                                                                                                                                                                        until #a >= 12
                                                                                                                                                                        local moooovr = Instance.new("BodyPosition", Plr.Character.LowerTorso)
                                                                                                                                                                        local gyro = Instance.new("BodyGyro", Plr.Character.LowerTorso)
                                                                                                                                                                        gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                                                                                                                                                                        moooovr.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                                                                                                                                                        moooovr.P = 1e5
                                                                                                                                                                        moooovr.Position = (TARGET.Character.UpperTorso.CFrame*CFrame.new(0, -3, -2)).p
                                                                                                                                                                        gyro.cframe = TARGET.Character.UpperTorso.CFrame
                                                                                                                                                                        local enabled = true
                                                                                                                                                                        wait(0.5)
                                                                                                                                                                        for i, v in next, a do
                                                                                                                                                                            v.GripPos = Vector3.new(2*math.cos(math.rad(i*30)), 0, 2*math.sin(math.rad(i*30)))
                                                                                                                                                                            v.Handle.ChildAdded:connect(function(c)
                                                                                                                                                                                if not enabled then return end
                                                                                                                                                                                local moov = Instance.new("BodyPosition", c)
                                                                                                                                                                                moov.P = 1e5
                                                                                                                                                                                moov.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                                                                                                                                                                while c.Parent ~= nil do
                                                                                                                                                                                    moov.Position = TARGET.Character.Head.CFrame.p
                                                                                                                                                                                    game.RunService.Stepped:wait()
                                                                                                                                                                                    setsimulationradius(math.huge^math.huge, math.huge)
                                                                                                                                                                                end
                                                                                                                                                                                moov:Destroy()
                                                                                                                                                                                v:Deactivate()
                                                                                                                                                                            end)
                                                                                                                                                                            v:Activate()
                                                                                                                                                                        end
                                                                                                                                                                        pcall(function()
                                                                                                                                                                            repeat wait() 
                                                                                                                                                                                moooovr.Position = (TARGET.Character.UpperTorso.CFrame*CFrame.new(0, 0, 2)).p
                                                                                                                                                                                gyro.cframe = TARGET.Character.UpperTorso.CFrame
                                                                                                                                                                            until game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
                                                                                                                                                                        end)
                                                                                                                                                                        gyro:Destroy()
                                                                                                                                                                        moooovr:Destroy()
                                                                                                                                                                        enabled = false
                                                                                                                                                                    end
                                                                                                                                                                    print("Pressed!")
                                                                                                                                                                    end)
                                                                                                                                                                    Specials:Button("RPG Control",function()														-- SETTINGS --
                                                                                                            local speed = 20
                                                                                                            local turnSpeed = 3
                                                                                                            --------------
                                                                                                        
                                                                                                            local plr = game.Players.LocalPlayer
                                                                                                            local Mouse = plr:GetMouse()
                                                                                                            local peniscock
                                                                                                            local movers
                                                                                                            local control = {w=false,a=false,s=false,d=false,q=false,e=false}
                                                                                                        
                                                                                                            game:GetService("RunService").Stepped:connect(function()
                                                                                                                if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
                                                                                                                    plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
                                                                                                                else
                                                                                                                    local c = plr.PlayerGui.MainScreenGui.Bar.HP
                                                                                                                    local g = c:Clone()
                                                                                                                    g.Name = "Speed"
                                                                                                                    g.Position = UDim2.new(0.5, 0, 1, -120)
                                                                                                                    g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
                                                                                                                    g.Picture.Image.Image = "rbxassetid://181035717"
                                                                                                                    g.TextLabel.Text = "Speed"
                                                                                                                    g.Parent = c.Parent
                                                                                                                end
                                                                                                                if peniscock and peniscock.Parent ~= nil then
                                                                                                                    setsimulationradius(math.huge^math.huge, math.huge)
                                                                                                                    if plr.Character.Humanoid.Sit ~= true then
                                                                                                                        peniscock = nil
                                                                                                                    end
                                                                                                                    peniscock.CFrame = CFrame.lookAt(peniscock.CFrame.p, Mouse.Hit.p)*CFrame.Angles(math.rad(90), 0, 0)
                                                                                                                end
                                                                                                                if control.q and speed > 0 then
                                                                                                                    speed = speed - 1
                                                                                                                end
                                                                                                                if control.e and speed < 100 then
                                                                                                                    speed = speed + 1
                                                                                                                end
                                                                                                            end)
                                                                                                        
                                                                                                            Mouse.KeyDown:connect(function(KEY)
                                                                                                                local key = KEY:lower()
                                                                                                                if control[key] ~= nil then
                                                                                                                    control[key]=true
                                                                                                                end
                                                                                                            end)
                                                                                                        
                                                                                                            Mouse.KeyUp:connect(function(KEY)
                                                                                                                local key = KEY:lower()
                                                                                                                if control[key] ~= nil then
                                                                                                                    control[key]=false
                                                                                                                end
                                                                                                            end)
                                                                                                        
                                                                                                            game.Workspace.Ignored.ChildAdded:connect(function(child)
                                                                                                                wait()
                                                                                                                if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
                                                                                                                    local old = game.Workspace.CurrentCamera.CameraSubject
                                                                                                                    plr.Character.Humanoid.Sit = true
                                                                                                                    game.Workspace.CurrentCamera.CameraSubject = child
                                                                                                                    peniscock = child
                                                                                                                    child:WaitForChild("BodyVelocity"):Destroy()
                                                                                                                    local e = Instance.new("BodyVelocity", child)
                                                                                                                    while peniscock and peniscock.Parent ~= nil do
                                                                                                                        game.RunService.Stepped:wait()
                                                                                                                        e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
                                                                                                                    end
                                                                                                                    wait(0.5)
                                                                                                                    game.Workspace.CurrentCamera.CameraSubject = old
                                                                                                                end
                                                                                                            end)
                                                                                                        end)
                                                                                                        Specials:Button("Fast RPG",function()
                                                                                                            -- SETTINGS --
                                                                                                            local speed = 200 -- noob
                                                                                                            --------------
                                                                                                        
                                                                                                            local plr = game.Players.LocalPlayer
                                                                                                        
                                                                                                            game.Workspace.Ignored.ChildAdded:connect(function(child)
                                                                                                                wait()
                                                                                                                if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
                                                                                                                    child:WaitForChild("BodyVelocity"):Destroy()
                                                                                                                    Instance.new("BodyVelocity", child).Velocity = (child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p
                                                                                                                    while child and child.Parent ~= nil do
                                                                                                                        game.RunService.Stepped:wait()
                                                                                                                        setsimulationradius(math.huge^math.huge, math.huge)
                                                                                                                    end
                                                                                                                end
                                                                                                            end)
                                                                                                        end)
                                                                                                        
                                                                                                        Specials:Button("RPG Ride",function()
                                                                                                                -- SETTINGS --
                                                                                                                local speed = 20
                                                                                                                local turnSpeed = 3
                                                                                                                --------------
                                                                                                            
                                                                                                                local plr = game.Players.LocalPlayer
                                                                                                                local Mouse = plr:GetMouse()
                                                                                                                local peniscock
                                                                                                                local movers
                                                                                                                local control = {w=false,a=false,s=false,d=false,q=false,e=false}
                                                                                                            
                                                                                                                game:GetService("RunService").Stepped:connect(function()
                                                                                                                    if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
                                                                                                                        plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
                                                                                                                    else
                                                                                                                        local c = plr.PlayerGui.MainScreenGui.Bar.HP
                                                                                                                        local g = c:Clone()
                                                                                                                        g.Name = "Speed"
                                                                                                                        g.Position = UDim2.new(0.5, 0, 1, -120)
                                                                                                                        g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
                                                                                                                        g.Picture.Image.Image = "rbxassetid://181035717"
                                                                                                                        g.TextLabel.Text = "Speed"
                                                                                                                        g.Parent = c.Parent
                                                                                                                    end
                                                                                                                    if peniscock and peniscock.Parent ~= nil then
                                                                                                                        setsimulationradius(math.huge^math.huge, math.huge)
                                                                                                                        if movers then
                                                                                                                            movers[1].Position = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0).p
                                                                                                                            movers[2].cframe = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0)
                                                                                                                            if plr.Character.Humanoid.Sit ~= true then
                                                                                                                                peniscock = nil
                                                                                                                            end
                                                                                                                        else
                                                                                                                            movers={}
                                                                                                                            local bp = Instance.new("BodyPosition", plr.Character.LowerTorso)
                                                                                                                            local bg = Instance.new("BodyGyro", plr.Character.LowerTorso)
                                                                                                                            bp.P = 1e5
                                                                                                                            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                                                                                                            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                                                                                                                            movers[1], movers[2] = bp, bg
                                                                                                                        end
                                                                                                                        if control.w then
                                                                                                                            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(turnSpeed), 0, 0)
                                                                                                                        end
                                                                                                                        if control.s then
                                                                                                                            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(-turnSpeed), 0, 0)
                                                                                                                        end
                                                                                                                        if control.a then
                                                                                                                            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(-turnSpeed))
                                                                                                                        end
                                                                                                                        if control.d then
                                                                                                                            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(turnSpeed))
                                                                                                                        end
                                                                                                                    end
                                                                                                                    if control.q and speed > 0 then
                                                                                                                        speed = speed - 1
                                                                                                                    end
                                                                                                                    if control.e and speed < 100 then
                                                                                                                        speed = speed + 1
                                                                                                                    end
                                                                                                                end)
                                                                                                            
                                                                                                                Mouse.KeyDown:connect(function(KEY)
                                                                                                                    local key = KEY:lower()
                                                                                                                    if control[key] ~= nil then
                                                                                                                        control[key]=true
                                                                                                                    end
                                                                                                                end)
                                                                                                            
                                                                                                                Mouse.KeyUp:connect(function(KEY)
                                                                                                                    local key = KEY:lower()
                                                                                                                    if control[key] ~= nil then
                                                                                                                        control[key]=false
                                                                                                                    end
                                                                                                                end)
                                                                                                            
                                                                                                                game.Workspace.Ignored.ChildAdded:connect(function(child)
                                                                                                                    wait()
                                                                                                                    if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
                                                                                                                        plr.Character.Humanoid.Sit = true
                                                                                                                        peniscock = child
                                                                                                                        child:WaitForChild("BodyVelocity"):Destroy()
                                                                                                                        local e = Instance.new("BodyVelocity", child)
                                                                                                                        while peniscock and peniscock.Parent ~= nil do
                                                                                                                            game.RunService.Stepped:wait()
                                                                                                                            e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
                                                                                                                        end
                                                                                                                        movers[1]:Destroy()
                                                                                                                        movers[2]:Destroy()
                                                                                                                        movers = nil
                                                                                                                    end
                                                                                                                end)
                                                                                                            print("Pressed!")
                                                                                                            end)
                                                                                                            Specials:Button("Ban Menu",function()
                                                                                                        
                                                                                                            wait()
                                                                                                            local UserInputService = game:GetService("UserInputService")
                                                                                                            local ScreenGui = Instance.new("ScreenGui", game.CoreGui) ScreenGui.Name = "Drxco's Menu"
                                                                                                            local Frame = Instance.new("Frame", ScreenGui)
                                                                                                            local Main = Instance.new("ScrollingFrame", ScreenGui)
                                                                                                            Main.Size = UDim2.new(0.3, 0, 0.4, 0)
                                                                                                            Main.Position = UDim2.new(0.65, 0, 0.2, 0)
                                                                                                            ScreenGui.Parent = nil
                                                                                                            local MainEvent = game.ReplicatedStorage.MainEvent
                                                                                                            local CurrentCamera = workspace.CurrentCamera
                                                                                                            local Plr = game.Players.LocalPlayer
                                                                                                            function enableGUI()
                                                                                                                local v5 = 0
                                                                                                                local players = game.Players:GetChildren()
                                                                                                        
                                                                                                                table.sort(players, function(p1, p2)
                                                                                                                    return p1:GetFullName() < p2:GetFullName()
                                                                                                                end)
                                                                                                        
                                                                                                                local v7, v8, v9 = pairs(players)
                                                                                                                while true do
                                                                                                                    local v10, Target = v7(v8, v9)
                                                                                                                    if not v10 then
                                                                                                                        break
                                                                                                                    end
                                                                                                                    v9 = v10
                                                                                                        
                                                                                                                    local v12 = Instance.new("TextButton")
                                                                                                                    v12.Size = UDim2.new(0.25, 0, 0, 45)
                                                                                                                    v12.Position = UDim2.new(0, 0, 0, v5 * 50)
                                                                                                                    v12.BackgroundColor3 = BrickColor.Red().Color
                                                                                                                    v12.Text = Target.Name
                                                                                                                    v12.TextScaled = true
                                                                                                                    v12.Parent = Main
                                                                                                        
                                                                                                                    local View = v12:Clone()
                                                                                                                    View.Text = "Spectate"
                                                                                                                    View.Position = UDim2.new(0.75, 0, 0, v5 * 50)
                                                                                                                    View.Size = UDim2.new(0.25, 0, 0, 45)
                                                                                                                    View.BackgroundColor3 = BrickColor.White().Color
                                                                                                                    View.Parent = Main
                                                                                                        
                                                                                                                    local v14 = v12:Clone()
                                                                                                                    v14.Size = UDim2.new(0.25, 0, 0, 45)
                                                                                                                    v14.Position = UDim2.new(0.25, 0, 0, v5 * 50)
                                                                                                                    v14.BackgroundColor3 = BrickColor.Green().Color
                                                                                                                    v14.Text = "UnBan"
                                                                                                                    v14.Parent = Main
                                                                                                        
                                                                                                                    local v15 = Instance.new("TextBox")
                                                                                                                    v15.Size = UDim2.new(0.25, 0, 0, 45)
                                                                                                                    v15.Position = UDim2.new(0.5, 0, 0, v5 * 50)
                                                                                                                    v15.Text = "Ban/UnBan Note Here"
                                                                                                                    v15.Font = v12.Font
                                                                                                                    v15.TextScaled = true
                                                                                                                    v15.Parent = Main
                                                                                                        
                                                                                                                    v5 = v5 + 1
                                                                                                                    local u4 = false
                                                                                                                    v12.MouseButton1Click:connect(function()
                                                                                                                        if u4 == false then
                                                                                                                            u4 = true
                                                                                                                            MainEvent:FireServer("BANREMOTE", Target, v15.Text)
                                                                                                                            wait(0.5)
                                                                                                                            u4 = false
                                                                                                                        end
                                                                                                                    end)
                                                                                                        
                                                                                                                    v14.MouseButton1Click:connect(function()
                                                                                                                        MainEvent:FireServer("UNBANREMOTE", Target, v15.Text)
                                                                                                                    end)
                                                                                                        
                                                                                                                    View.MouseButton1Click:connect(function()
                                                                                                                        CurrentCamera.CameraSubject = Target.Character.Humanoid
                                                                                                                    end)	
                                                                                                                end
                                                                                                                Main.CanvasSize = UDim2.new(0, 0, 0, v5 * 50)
                                                                                                                ScreenGui.Parent = game.CoreGui
                                                                                                            end
                                                                                                        
                                                                                                            enableGUI()
                                                                                                            Frame.FindServer.MouseButton1Click:connect(function()
                                                                                                                MainEvent:FireServer("FindServer", Frame.PlayerName.Text)
                                                                                                            end)
                                                                                                            Frame.JoinServer.MouseButton1Click:connect(function()
                                                                                                                MainEvent:FireServer("JoinServer", Frame.ServerId.Text)
                                                                                                            end)
                                                                                                            local u5 = false
                                                                                                            UserInputService.InputBegan:connect(function(p3, p4)
                                                                                                                if not p4 and p3.UserInputType == Enum.UserInputType.Keyboard and p3.KeyCode == Enum.KeyCode.B and u5 == false then
                                                                                                                    u5 = true
                                                                                                                    if ScreenGui.Parent == nil then
                                                                                                                        enableGUI()
                                                                                                                    else
                                                                                                                        ScreenGui.Parent = nil
                                                                                                                        for v16, v17 in pairs(Main:GetChildren()) do
                                                                                                                            v17:Destroy()
                                                                                                                        end
                                                                                                                    end
                                                                                                                    wait(0.2)
                                                                                                                    u5 = false
                                                                                                                end
                                                                                                            end)
                                                                                                            local v18 = {}
                                                                                                            while wait() do
                                                                                                                if ScreenGui.Parent == Plr.PlayerGui then
                                                                                                                    for v19 = #v18, 1, -1 do
                                                                                                                        v18[v19]:Destroy()
                                                                                                                        table.remove(v18, v19)
                                                                                                                    end
                                                                                                                    for v20, v21 in pairs(game.Players:GetChildren()) do
                                                                                                                        pcall(function()
                                                                                                                            local l__Character__22 = v21.Character
                                                                                                                            if CurrentCamera.CFrame.lookVector:Dot((l__Character__22.LowerTorso.Position - CurrentCamera.CFrame.p).unit) > 0 then
                                                                                                                                local v23 = CurrentCamera:WorldToScreenPoint(l__Character__22.UpperTorso.Position)
                                                                                                                                local v24 = Instance.new("TextLabel")
                                                                                                                                v24.Name = l__Character__22.Name
                                                                                                                                local v25 = game.Players:GetPlayerFromCharacter(l__Character__22)
                                                                                                                                v24.Text = l__Character__22.Name
                                                                                                                                v24.TextSize = 20
                                                                                                                                v24.Font = Enum.Font.ArialBold
                                                                                                                                v24.TextColor3 = (CurrentCamera.CFrame.p - l__Character__22.LowerTorso.Position).magnitude < 75 and Color3.fromRGB(137, 211, 205) or Color3.new(1, 0, 0)
                                                                                                                                v24.Position = UDim2.new(0, v23.x, 0, v23.y)
                                                                                                                                v24.Parent = ScreenGui
                                                                                                                                table.insert(v18, v24)
                                                                                                                            end
                                                                                                                        end)
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end)
                                                                                                        Specials:Button("Grenade Galaxy",function()
                                                                                                        
                                                                                                        local Plr = game.Players.LocalPlayer
                                                                                                            local lastPos = Plr.Character.HumanoidRootPart.CFrame
                                                                                                            local e = 0
                                                                                                            local p = 0
                                                                                                            local a = {}
                                                                                                            repeat
                                                                                                                Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
                                                                                                                wait(0.5)
                                                                                                                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Grenade] - $700"].ClickDetector)
                                                                                                                for i, v in pairs(Plr.Backpack:GetChildren()) do
                                                                                                                    if v.Name == "[Grenade]" then
                                                                                                                        e = 0
                                                                                                                        for i, v in pairs(a) do
                                                                                                                            e = e + 1
                                                                                                                        end
                                                                                                                        table.insert(a, v)
                                                                                                                        v.Parent = Plr.Character
                                                                                                                    end
                                                                                                                end
                                                                                                            until e >= 100
                                                                                                        
                                                                                                            for i, v in pairs(a) do
                                                                                                                local p = (i*0.01)+0.50
                                                                                                                v.GripUp = Vector3.new(0, 1, 0)
                                                                                                                if i <=e/2 then
                                                                                                                    v.GripPos = Vector3.new(((p^4)*math.cos(18.5*(math.pi*p)))*40, 0, ((p^4)*math.sin(18.5*(math.pi*p)))*40)
                                                                                                                else
                                                                                                                    v.GripPos = Vector3.new(((p^4)*math.cos(18.5*(math.pi*p)))*40, 0, ((p^4)*math.sin(18.5*(math.pi*p)))*40)
                                                                                                                end
                                                                                                            end
                                                                                                            Plr.Character.Humanoid:UnequipTools()
                                                                                                            wait(5)
                                                                                                            for _, burger in pairs(a) do
                                                                                                                burger.Parent = Plr.Character
                                                                                                            end
                                                                                                            Plr.Character.HumanoidRootPart.CFrame = lastPos
                                                                                                        end)
                                                                                                        Specials:Button("Arrest All",function()
                                                                                                        
                                                                                                        wait(0.5) if _G.AutoArrest == false or game.PlaceId ~= 2788229376 then return else repeat wait() until game.Players.LocalPlayer end
                                                                                                        
                                                                                                            wait(15)
                                                                                                            for i, v in next, game.Workspace:GetDescendants() do
                                                                                                                if v:IsA("Seat") then
                                                                                                                    v:Destroy()
                                                                                                                end
                                                                                                            end
                                                                                                            local Plr = game.Players.LocalPlayer
                                                                                                        
                                                                                                            function serverhop()
                                                                                                                print("PENIS")
                                                                                                                Plr:Destroy()
                                                                                                                local x = {}
                                                                                                                for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
                                                                                                                    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                                                                                                                        x[#x + 1] = v.id
                                                                                                                    end
                                                                                                                end
                                                                                                                if #x > 0 then
                                                                                                                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
                                                                                                                end
                                                                                                            end
                                                                                                        
                                                                                                            spawn(function()
                                                                                                                wait(300)
                                                                                                                serverhop()
                                                                                                            end)
                                                                                                        
                                                                                                            game:GetService("RunService").Stepped:connect(function()
                                                                                                                Plr.Character.Humanoid:ChangeState(11)
                                                                                                            end)
                                                                                                            Plr.CharacterAdded:Connect(function(character)
                                                                                                                repeat wait() until character:FindFirstChild("FULLY_LOADED_CHAR")
                                                                                                                e(character)
                                                                                                            end)
                                                                                                            function e(character)
                                                                                                                for i, v in pairs(game.Workspace.Ignored.ItemsDrop:GetChildren()) do
                                                                                                                    if v:FindFirstChild("[Knife]") and Plr.Character:FindFirstChild("[Knife]") == nil and Plr.Backpack:FindFirstChild("[Knife]") == nil then
                                                                                                                        Plr.Character.HumanoidRootPart.CFrame = v.CFrame
                                                                                                                        wait(1)
                                                                                                                    end
                                                                                                                end
                                                                                                                for i, v in pairs(character:GetChildren()) do
                                                                                                                    if v:FindFirstChild("LocalScript") then
                                                                                                                        v:Destroy()
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                            e(Plr.character)
                                                                                                            local target
                                                                                                            while wait() do
                                                                                                                target = nil
                                                                                                                local highest = 0
                                                                                                                for i, v in pairs(game.Players:GetPlayers()) do
                                                                                                                    if v:FindFirstChild("DataFolder") and v.Character:FindFirstChild("FULLY_LOADED_CHAR") and v.Character.BodyEffects:FindFirstChild("Defense") and tonumber(v.DataFolder.Information.Wanted.Value) > 500 and tonumber(v.DataFolder.Information.Wanted.Value) >= highest and v.Character.BodyEffects:FindFirstChild("Armor") then
                                                                                                                        target = v 
                                                                                                                        highest = tonumber(v.DataFolder.Information.Wanted.Value)
                                                                                                                    end
                                                                                                                end
                                                                                                                if not target then serverhop() end
                                                                                                                local e = true
                                                                                                                local penis = 0
                                                                                                                local bagged = false
                                                                                                                local A = false
                                                                                                                spawn(function() pcall(function()
                                                                                                                        while bagged == false do
                                                                                                                            if target and target.Character and target.Character:FindFirstChild("Christmas_Sock") == nil and penis <= 5 and Plr.Character.Humanoid.Health > 80 then
                                                                                                                                if Plr.Backpack:FindFirstChild("[BrownBag]") == nil then
                                                                                                                                    A = false
                                                                                                                                    pcall(function()
                                                                                                                                        repeat wait()
                                                                                                                                            Plr.character.HumanoidRootPart.CFrame = CFrame.new(-316.034454, 48.2788467, -723.860474, 0.983254969, -0.000297372608, -0.182234928, 0.000218386791, 0.999999881, -0.000453495246, 0.182235047, 0.000406103791, 0.98325491)
                                                                                                                                            fireclickdetector(game:GetService("Workspace").Ignored.Shop["[BrownBag] - $25"].ClickDetector)
                                                                                                                                        until Plr.Backpack:FindFirstChild("[BrownBag]") ~= nil
                                                                                                                                    end)
                                                                                                                                    A = true
                                                                                                                                end
                                                                                                                                Plr.Character.Humanoid:EquipTool(Plr.Backpack["[BrownBag]"])
                                                                                                                                Plr.Character["[BrownBag]"]:Activate()
                                                                                                                                penis = penis + 1
                                                                                                                            elseif penis >= 2 or target.Character:FindFirstChild("Christmas_Sock") or not target then
                                                                                                                                bagged = true
                                                                                                                            end
                                                                                                                            wait(3)
                                                                                                                        end
                                                                                                                    end) end)
                                                                                                                spawn(function()
                                                                                                                    while e do wait()
                                                                                                                        pcall(function()
                                                                                                                            if Plr.Character.Humanoid.Health > 80 then
                                                                                                                                if not target.Character.BodyEffects["K.O"].Value then
                                                                                                                                    if A then
                                                                                                                                        Plr.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.UpperTorso.Position + Vector3.new(0, -5, 0))
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    Plr.Character.HumanoidRootPart.CFrame = target.Character.UpperTorso.CFrame
                                                                                                                                end
                                                                                                                            else
                                                                                                                                Plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                                                                                                                                if Plr.Character:FindFirstChild("[Chicken]") == nil or Plr.Backpack:FindFirstChild("[Chicken]") == nil then
                                                                                                                                    Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Chicken] - $7"].Head.CFrame
                                                                                                                                    wait(0.5)
                                                                                                                                    fireclickdetector(game.Workspace.Ignored.Shop["[Chicken] - $7"].ClickDetector)
                                                                                                                                end
                                                                                                                                pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Chicken]"])end)
                                                                                                                                pcall(function()
                                                                                                                                    Plr.Character["[Chicken]"]:Activate()
                                                                                                                                    wait(0.1)
                                                                                                                                    Plr.Character["[Chicken]"]:Deactivate()
                                                                                                                                end)
                                                                                                                            end
                                                                                                                        end)
                                                                                                                    end
                                                                                                                end)
                                                                                                                repeat wait() until bagged
                                                                                                                pcall(function()
                                                                                                                    repeat wait()
                                                                                                                        repeat wait()
                                                                                                                            pcall(function()
                                                                                                                                if Plr.Character.Humanoid.Health > 80 then
                                                                                                                                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Knife]"])end)
                                                                                                                                    wait(0.1)
                                                                                                                                    Plr.Character["[Knife]"].GripPos = Vector3.new(0, 5, 0)
                                                                                                                                    Plr.Character["[Knife]"].Handle.Size = Vector3.new(20, 20, 20)
                                                                                                                                    Plr.Character["[Knife]"]:Activate()
                                                                                                                                    wait(2)
                                                                                                                                    Plr.Character["[Knife]"]:Deactivate()
                                                                                                                                    wait(1)
                                                                                                                                end
                                                                                                                            end)
                                                                                                                        until not target or target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
                                                                                                                        repeat wait() 
                                                                                                                            if Plr.Character.Humanoid.Health > 80 then
                                                                                                                                pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack.Cuff)end)
                                                                                                                                pcall(function()
                                                                                                                                    Plr.Character.Cuff:Activate()
                                                                                                                                    wait(0.1)
                                                                                                                                    Plr.Character.Cuff:Deactivate()
                                                                                                                                end)
                                                                                                                            end
                                                                                                                        until not target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
                                                                                                                    until tonumber(target.DataFolder.Information.Wanted.Value) == 0 or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
                                                                                                                end)
                                                                                                                e = false
                                                                                                            end
                                                                                                        end)

