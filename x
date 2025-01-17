local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(name)
    local RustBeta = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local TabList = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("Frame")
    local UIPadding = Instance.new("UIPadding")
    local Shadow = Instance.new("ImageLabel")

    RustBeta.Name = "RustBeta"
    RustBeta.Parent = game.CoreGui
    RustBeta.ResetOnSpawn = false

    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 47, 1, 47)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    Main.Name = "Main"
    Main.Parent = RustBeta
    Main.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -150, 0.5, -200)
    Main.Size = UDim2.new(0, 300, 0, 400)
    Main.ClipsDescendants = true

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(0, 130, 246)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = TopBar

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.028, 0, 0, 0)
    Title.Size = UDim2.new(0.972, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.Size = UDim2.new(1, 0, 0, 25)

    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    })
    UIGradient.Parent = TabHolder

    TabList.Parent = TabHolder
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left

    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 0, 0, 55)
    ContentContainer.Size = UDim2.new(1, 0, 1, -55)

    UIPadding.Parent = ContentContainer
    UIPadding.PaddingBottom = UDim.new(0, 10)
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.PaddingTop = UDim.new(0, 10)

    -- Enhance the window dragging:
    local dragSpeed = 0.06
    local dragStart, startPos = nil, nil
    local dragging = false

    local dragConnection
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            if dragConnection then
                dragConnection:Disconnect()
            end
            
            dragConnection = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            local targetPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            
            -- Smooth dragging animation
            TweenService:Create(Main, TweenInfo.new(dragSpeed, Enum.EasingStyle.Sine), {
                Position = targetPos
            }):Play()
        end
    end)

    local Window = {}
    local Tabs = {}
    local SelectedTab = nil
    local TabButtons = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local Content = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local TabIndicator = Instance.new("Frame")
        local UICorner_Tab = Instance.new("UICorner")
        
        Tab.Name = name
        Tab.Parent = TabHolder
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(0, 73, 1, 0)
        Tab.Font = Enum.Font.GothamMedium
        Tab.Text = name
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 14
        Tab.AutoButtonColor = false

        TabIndicator.Name = "Indicator"
        TabIndicator.Parent = Tab
        TabIndicator.BackgroundColor3 = Color3.fromRGB(0, 130, 246)
        TabIndicator.Position = UDim2.new(0, 0, 1, -2)
        TabIndicator.Size = UDim2.new(1, 0, 0, 2)
        TabIndicator.BackgroundTransparency = 1

        Content.Name = name.."Content"
        Content.Parent = ContentContainer
        Content.BackgroundTransparency = 1
        Content.Size = UDim2.new(1, -20, 1, -20)
        Content.Position = UDim2.new(0, 10, 0, 10)
        Content.ScrollBarThickness = 2
        Content.Visible = false
        Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Content.ScrollingDirection = Enum.ScrollingDirection.Y
        Content.BackgroundTransparency = 1

        UIListLayout.Parent = Content
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        -- Tab switching animation
        Tab.MouseButton1Click:Connect(function()
            if SelectedTab == Content then return end
            
            -- Fade out old tab indicator
            if SelectedTab then
                local oldTab = TabButtons[SelectedTab]
                if oldTab then
                    local oldIndicator = oldTab:FindFirstChild("Indicator")
                    if oldIndicator then
                        TweenService:Create(oldIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end
                SelectedTab.Visible = false
            end

            -- Fade in new tab indicator
            TweenService:Create(TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()

            Content.Visible = true
            SelectedTab = Content
            TabButtons[Content] = Tab
        end)

        -- Set up initial tab
        if #Tabs == 0 then
            Content.Visible = true
            SelectedTab = Content
            TabButtons[Content] = Tab
            TabIndicator.BackgroundTransparency = 0
        else
            TabIndicator.BackgroundTransparency = 1
        end
        
        table.insert(Tabs, Tab)
        
        local TabContent = {}

        function TabContent:CreateToggle(name, default, callback)
            local Toggle = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Label = Instance.new("TextLabel")
            local Switch = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local Indicator = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            
            Toggle.Name = name
            Toggle.Parent = Content
            Toggle.BackgroundTransparency = 1
            Toggle.Size = UDim2.new(1, 0, 0, 35)

            Background.Name = "Background"
            Background.Parent = Toggle
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Background

            Label.Parent = Background
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            Switch.Name = "Switch"
            Switch.Parent = Background
            Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Switch.Position = UDim2.new(1, -45, 0.5, -10)
            Switch.Size = UDim2.new(0, 35, 0, 20)

            UICorner_2.CornerRadius = UDim.new(1, 0)
            UICorner_2.Parent = Switch

            Indicator.Name = "Indicator"
            Indicator.Parent = Switch
            Indicator.AnchorPoint = Vector2.new(0, 0.5)
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.Position = UDim2.new(0, 2, 0.5, 0)
            Indicator.Size = UDim2.new(0, 16, 0, 16)

            UICorner_3.CornerRadius = UDim.new(1, 0)
            UICorner_3.Parent = Indicator

            local enabled = default
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
            
            local function updateToggle()
                local pos = enabled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                local color = enabled and Color3.fromRGB(0, 130, 246) or Color3.fromRGB(40, 40, 40)
                
                TweenService:Create(Indicator, tweenInfo, {Position = pos}):Play()
                TweenService:Create(Switch, tweenInfo, {BackgroundColor3 = color}):Play()
            end

            Background.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    enabled = not enabled
                    updateToggle()
                    if callback then callback(enabled) end
                end
            end)

            updateToggle()
        end

        function TabContent:CreateSlider(name, min, max, default, callback)
            local Slider = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Label = Instance.new("TextLabel")
            local SliderBar = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local SliderFill = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local Value = Instance.new("TextLabel")

            Slider.Name = name
            Slider.Parent = Content
            Slider.BackgroundTransparency = 1
            Slider.Size = UDim2.new(1, 0, 0, 45)

            Background.Name = "Background"
            Background.Parent = Slider
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Background

            Label.Parent = Background
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -60, 0, 20)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            SliderBar.Parent = Background
            SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderBar.Position = UDim2.new(0, 10, 0, 25)
            SliderBar.Size = UDim2.new(1, -20, 0, 6)

            UICorner_2.CornerRadius = UDim.new(1, 0)
            UICorner_2.Parent = SliderBar

            SliderFill.Parent = SliderBar
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 130, 246)
            SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)

            UICorner_3.CornerRadius = UDim.new(1, 0)
            UICorner_3.Parent = SliderFill

            Value.Parent = Background
            Value.BackgroundTransparency = 1
            Value.Position = UDim2.new(1, -50, 0, 0)
            Value.Size = UDim2.new(0, 40, 0, 20)
            Value.Font = Enum.Font.GothamBold
            Value.Text = tostring(default)
            Value.TextColor3 = Color3.fromRGB(255, 255, 255)
            Value.TextSize = 14

            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + ((max - min) * pos))
                
                TweenService:Create(SliderFill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                Value.Text = tostring(value)
                if callback then callback(value) end
            end

            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input)
                    local connection
                    connection = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if connection then connection:Disconnect() end
                        end
                    end)
                end
            end)
        end

        function TabContent:CreateButton(name, callback)
            local Button = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local ButtonLabel = Instance.new("TextButton")
            
            Button.Name = name
            Button.Parent = Content
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0, 0, 35)

            Background.Name = "Background"
            Background.Parent = Button
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Background

            ButtonLabel.Name = "ButtonLabel"
            ButtonLabel.Parent = Background
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
            ButtonLabel.Font = Enum.Font.GothamBold
            ButtonLabel.Text = name
            ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonLabel.TextSize = 14

            -- Hover and click effects
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
            
            ButtonLabel.MouseEnter:Connect(function()
                TweenService:Create(Background, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
            end)

            ButtonLabel.MouseLeave:Connect(function()
                TweenService:Create(Background, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                }):Play()
            end)

            ButtonLabel.MouseButton1Down:Connect(function()
                TweenService:Create(Background, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
            end)

            ButtonLabel.MouseButton1Up:Connect(function()
                TweenService:Create(Background, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
                if callback then callback() end
            end)
        end

        function TabContent:CreateDropdown(name, options, default, callback)
            local Dropdown = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Label = Instance.new("TextLabel")
            local DropdownButton = Instance.new("TextButton")
            local OptionsFrame = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local UICorner_2 = Instance.new("UICorner")
            
            Dropdown.Name = name
            Dropdown.Parent = Content
            Dropdown.BackgroundTransparency = 1
            Dropdown.Size = UDim2.new(1, 0, 0, 35)

            Background.Name = "Background"
            Background.Parent = Dropdown
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Background

            Label.Parent = Background
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(0.5, -10, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            DropdownButton.Name = "DropdownButton"
            DropdownButton.Parent = Background
            DropdownButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            DropdownButton.Position = UDim2.new(1, -110, 0.5, -12)
            DropdownButton.Size = UDim2.new(0, 100, 0, 24)
            DropdownButton.Font = Enum.Font.GothamBold
            DropdownButton.Text = default or options[1]
            DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.TextSize = 12
            DropdownButton.AutoButtonColor = false

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = DropdownButton

            OptionsFrame.Name = "OptionsFrame"
            OptionsFrame.Parent = Background
            OptionsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            OptionsFrame.Position = UDim2.new(1, -110, 0, 35)
            OptionsFrame.Size = UDim2.new(0, 100, 0, 0)
            OptionsFrame.Visible = false
            OptionsFrame.ZIndex = 5
            OptionsFrame.ClipsDescendants = true

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = OptionsFrame

            UIListLayout.Parent = OptionsFrame
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 2)

            local isOpen = false
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)

            local function createOption(optionName)
                local Option = Instance.new("TextButton")
                Option.Name = optionName
                Option.Parent = OptionsFrame
                Option.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Option.Size = UDim2.new(1, 0, 0, 24)
                Option.Font = Enum.Font.GothamMedium
                Option.Text = optionName
                Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                Option.TextSize = 12
                Option.ZIndex = 5
                Option.AutoButtonColor = false

                Option.MouseEnter:Connect(function()
                    TweenService:Create(Option, tweenInfo, {
                        BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    }):Play()
                end)

                Option.MouseLeave:Connect(function()
                    TweenService:Create(Option, tweenInfo, {
                        BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    }):Play()
                end)

                Option.MouseButton1Click:Connect(function()
                    DropdownButton.Text = optionName
                    if callback then callback(optionName) end
                    
                    isOpen = false
                    TweenService:Create(OptionsFrame, tweenInfo, {
                        Size = UDim2.new(0, 100, 0, 0)
                    }):Play()
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                end)

                return Option
            end

            -- Create all options
            for _, optionName in ipairs(options) do
                createOption(optionName)
            end

            DropdownButton.MouseEnter:Connect(function()
                TweenService:Create(DropdownButton, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                }):Play()
            end)

            DropdownButton.MouseLeave:Connect(function()
                TweenService:Create(DropdownButton, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                }):Play()
            end)

            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    OptionsFrame.Size = UDim2.new(0, 100, 0, 0)
                    OptionsFrame.Visible = true
                    TweenService:Create(OptionsFrame, tweenInfo, {
                        Size = UDim2.new(0, 100, 0, #options * 26)
                    }):Play()
                else
                    TweenService:Create(OptionsFrame, tweenInfo, {
                        Size = UDim2.new(0, 100, 0, 0)
                    }):Play()
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                end
            end)

            return {
                GetSelection = function()
                    return DropdownButton.Text
                end
            }
        end

        function TabContent:CreateKeybind(name, default, callback)
            local Keybind = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Label = Instance.new("TextLabel")
            local KeyLabel = Instance.new("TextButton")
            local UIStroke = Instance.new("UIStroke")
            
            Keybind.Name = name
            Keybind.Parent = Content
            Keybind.BackgroundTransparency = 1
            Keybind.Size = UDim2.new(1, 0, 0, 35)

            Background.Name = "Background"
            Background.Parent = Keybind
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Background

            Label.Parent = Background
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -110, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            KeyLabel.Name = "KeyLabel"
            KeyLabel.Parent = Background
            KeyLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            KeyLabel.Position = UDim2.new(1, -100, 0.5, -12)
            KeyLabel.Size = UDim2.new(0, 90, 0, 24)
            KeyLabel.Font = Enum.Font.GothamBold
            KeyLabel.Text = default and default.Name or "None"
            KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeyLabel.TextSize = 12
            KeyLabel.AutoButtonColor = false

            UIStroke.Parent = KeyLabel
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            UIStroke.Color = Color3.fromRGB(60, 60, 60)
            UIStroke.Thickness = 1

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = KeyLabel

            local binding = false
            local currentKey = default
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)

            KeyLabel.MouseEnter:Connect(function()
                TweenService:Create(KeyLabel, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                }):Play()
            end)

            KeyLabel.MouseLeave:Connect(function()
                TweenService:Create(KeyLabel, tweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                }):Play()
            end)

            KeyLabel.MouseButton1Click:Connect(function()
                if binding then return end
                binding = true
                KeyLabel.Text = "..."

                local connection
                connection = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        KeyLabel.Text = currentKey.Name
                        if callback then callback(currentKey) end
                        binding = false
                        connection:Disconnect()
                    end
                end)
            end)

            return {
                GetKey = function()
                    return currentKey
                end
            }
        end

        function TabContent:CreateColorPicker(name, default, callback)
            -- Main Container Setup
            local ColorPicker = Instance.new("Frame")
            local Background = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local ColorButton = Instance.new("TextButton") -- Changed to TextButton for better input handling
            
            ColorPicker.Name = name
            ColorPicker.Parent = Content
            ColorPicker.BackgroundTransparency = 1
            ColorPicker.Size = UDim2.new(1, 0, 0, 35)

            Background.Name = "Background"
            Background.Parent = ColorPicker
            Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Background.Size = UDim2.new(1, -20, 1, -5)
            Background.Position = UDim2.new(0, 10, 0, 0)
            Instance.new("UICorner", Background).CornerRadius = UDim.new(0, 4)

            Label.Parent = Background
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            ColorButton.Name = "ColorButton"
            ColorButton.Parent = Background
            ColorButton.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
            ColorButton.Position = UDim2.new(1, -40, 0.5, -8)
            ColorButton.Size = UDim2.new(0, 30, 0, 16)
            ColorButton.BorderSizePixel = 0
            ColorButton.Text = ""
            ColorButton.AutoButtonColor = false
            Instance.new("UICorner", ColorButton).CornerRadius = UDim.new(0, 4)

            -- Color Picker Window
            local PickerFrame = Instance.new("Frame")
            PickerFrame.Name = "PickerFrame"
            PickerFrame.Size = UDim2.new(0, 200, 0, 220)
            PickerFrame.Position = UDim2.new(0.5, -100, 0.5, -110)
            PickerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            PickerFrame.BorderSizePixel = 0
            PickerFrame.Visible = false
            PickerFrame.ZIndex = 100
            PickerFrame.Parent = ColorPicker
            Instance.new("UICorner", PickerFrame).CornerRadius = UDim.new(0, 6)

            -- Color Area
            local ColorArea = Instance.new("ImageButton") -- Changed to ImageButton for better input handling
            ColorArea.Name = "ColorArea"
            ColorArea.Size = UDim2.new(1, -20, 0, 150)
            ColorArea.Position = UDim2.new(0, 10, 0, 10)
            ColorArea.Image = "rbxassetid://4155801252"
            ColorArea.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            ColorArea.ZIndex = 101
            ColorArea.Parent = PickerFrame
            ColorArea.AutoButtonColor = false
            Instance.new("UICorner", ColorArea).CornerRadius = UDim.new(0, 4)

            -- Hue Slider
            local HueSlider = Instance.new("TextButton") -- Changed to TextButton for better input handling
            HueSlider.Name = "HueSlider"
            HueSlider.Size = UDim2.new(1, -20, 0, 20)
            HueSlider.Position = UDim2.new(0, 10, 0, 170)
            HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSlider.ZIndex = 101
            HueSlider.Text = ""
            HueSlider.AutoButtonColor = false
            HueSlider.Parent = PickerFrame
            Instance.new("UICorner", HueSlider).CornerRadius = UDim.new(0, 4)

            local HueGradient = Instance.new("UIGradient")
            HueGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
            })
            HueGradient.Parent = HueSlider

            -- Buttons
            local ButtonsHolder = Instance.new("Frame")
            ButtonsHolder.Name = "ButtonsHolder"
            ButtonsHolder.Size = UDim2.new(1, -20, 0, 25)
            ButtonsHolder.Position = UDim2.new(0, 10, 1, -35)
            ButtonsHolder.BackgroundTransparency = 1
            ButtonsHolder.ZIndex = 101
            ButtonsHolder.Parent = PickerFrame

            local function CreateButton(name, position)
                local button = Instance.new("TextButton")
                button.Name = name
                button.Size = UDim2.new(0.5, -5, 1, 0)
                button.Position = position
                button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                button.Text = name
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Font = Enum.Font.GothamBold
                button.TextSize = 14
                button.ZIndex = 101
                button.AutoButtonColor = false
                button.Parent = ButtonsHolder
                Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
                return button
            end

            local ConfirmButton = CreateButton("Confirm", UDim2.new(0, 0, 0, 0))
            local CancelButton = CreateButton("Cancel", UDim2.new(0.5, 5, 0, 0))

            -- Variables and Color Logic
            local pickerOpen = false
            local hue, sat, val = 0, 1, 1
            local selectedColor = default or Color3.fromRGB(255, 255, 255)
            local originalColor = selectedColor

            -- Color Selection Logic
            local function updateColor()
                selectedColor = Color3.fromHSV(hue, sat, val)
                ColorButton.BackgroundColor3 = selectedColor
            end

            -- Color Area Input Handler
            local function handleColorAreaInput(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local function update()
                        local mouse = UserInputService:GetMouseLocation()
                        local relative = Vector2.new(
                            math.clamp((mouse.X - ColorArea.AbsolutePosition.X) / ColorArea.AbsoluteSize.X, 0, 1),
                            math.clamp((mouse.Y - ColorArea.AbsolutePosition.Y) / ColorArea.AbsoluteSize.Y, 0, 1)
                        )
                        sat = relative.X
                        val = 1 - relative.Y
                        updateColor()
                    end

                    local connection
                    connection = RunService.RenderStepped:Connect(update)
                    update() -- Update immediately

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            if connection then connection:Disconnect() end
                        end
                    end)
                end
            end

            -- Hue Slider Input Handler
            local function handleHueInput(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local function update()
                        local mouse = UserInputService:GetMouseLocation()
                        local relative = math.clamp(
                            (mouse.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X,
                            0, 1
                        )
                        hue = relative
                        ColorArea.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                        updateColor()
                    end

                    local connection
                    connection = RunService.RenderStepped:Connect(update)
                    update() -- Update immediately

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            if connection then connection:Disconnect() end
                        end
                    end)
                end
            end

            -- Connect Input Handlers
            ColorArea.InputBegan:Connect(handleColorAreaInput)
            HueSlider.InputBegan:Connect(handleHueInput)

            -- Button Handlers
            ColorButton.MouseButton1Click:Connect(function()
                pickerOpen = not pickerOpen
                PickerFrame.Visible = pickerOpen
                if pickerOpen then
                    originalColor = ColorButton.BackgroundColor3
                end
            end)

            ConfirmButton.MouseButton1Click:Connect(function()
                if callback then 
                    callback(selectedColor)
                end
                pickerOpen = false
                PickerFrame.Visible = false
            end)

            CancelButton.MouseButton1Click:Connect(function()
                ColorButton.BackgroundColor3 = originalColor
                selectedColor = originalColor
                pickerOpen = false
                PickerFrame.Visible = false
            end)

            -- Button Hover Effects
            local function addButtonEffect(button)
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    }):Play()
                end)

                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    }):Play()
                end)
            end

            addButtonEffect(ConfirmButton)
            addButtonEffect(CancelButton)

            return ColorPicker
        end

        Tab.MouseButton1Click:Connect(function()
            if SelectedTab == Content then return end
            if SelectedTab then SelectedTab.Visible = false end
            Content.Visible = true
            SelectedTab = Content
        end)

        if #Tabs == 0 then
            Content.Visible = true
            SelectedTab = Content
        end
        
        table.insert(Tabs, Tab)
        return TabContent
    end

    function Window:AddMenuKeybind(default)
        local keybind = Enum.KeyCode[default] or Enum.KeyCode.RightShift
        
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == keybind then
                MenuToggled = not MenuToggled
                
                -- Animate the menu
                TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Position = MenuToggled and UDim2.new(0.5, -150, 0.5, -200) or UDim2.new(0.5, -150, 1.5, 0)
                }):Play()
            end
        end)
    end

    function Window:CreateConfigSystem()
        -- Add this to your last tab
        local ConfigTab = self:CreateTab("Config")
        
        ConfigTab:CreateButton("Save Config", function()
            local config = {}
            -- Add your config saving logic here
            writefile("config.txt", game:GetService("HttpService"):JSONEncode(config))
        end)
        
        ConfigTab:CreateButton("Load Config", function()
            if isfile("config.txt") then
                local config = game:GetService("HttpService"):JSONDecode(readfile("config.txt"))
                -- Add your config loading logic here
            end
        end)
    end

    function Window:AddDestroyButton()
        local DestroyButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        
        DestroyButton.Name = "DestroyButton"
        DestroyButton.Parent = TopBar
        DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        DestroyButton.Position = UDim2.new(1, -25, 0.5, -8)
        DestroyButton.Size = UDim2.new(0, 16, 0, 16)
        DestroyButton.Font = Enum.Font.GothamBold
        DestroyButton.Text = "X"
        DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DestroyButton.TextSize = 12
        DestroyButton.AutoButtonColor = false

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = DestroyButton

        -- Hover and click effects
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
        
        DestroyButton.MouseEnter:Connect(function()
            TweenService:Create(DestroyButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            }):Play()
        end)

        DestroyButton.MouseLeave:Connect(function()
            TweenService:Create(DestroyButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            }):Play()
        end)

        DestroyButton.MouseButton1Click:Connect(function()
            RustBeta:Destroy()
        end)
    end

    return Window
end
return Library
