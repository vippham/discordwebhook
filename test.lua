local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Kiểm tra và thiết lập http request
local http_request = syn and syn.request or http and http.request or http_request or request or httprequest

-- Tạo ScreenGui và UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local WebhookInput = Instance.new("TextBox")
local TestButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local TimerFrame = Instance.new("Frame")
local TimerLabel = Instance.new("TextLabel")
local TimerValue = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

-- UI Setup
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999999

MainFrame.Name = "WebhookTester"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 999999999

-- Tạo hiệu ứng bo góc
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 999999999

local TopBarCorner = UICorner:Clone()
TopBarCorner.Parent = TopBar

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TopBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Discord Webhook Tester"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 999999999

WebhookInput.Name = "WebhookInput"
WebhookInput.Parent = MainFrame
WebhookInput.Position = UDim2.new(0.1, 0, 0.2, 0)
WebhookInput.Size = UDim2.new(0.8, 0, 0.15, 0)
WebhookInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
WebhookInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WebhookInput.PlaceholderText = "Nhập Discord Webhook URL..."
WebhookInput.Text = ""
WebhookInput.TextWrapped = true
WebhookInput.Font = Enum.Font.Gotham
WebhookInput.TextSize = 14
WebhookInput.BorderSizePixel = 0
WebhookInput.ZIndex = 999999999

local InputCorner = UICorner:Clone()
InputCorner.Parent = WebhookInput

TestButton.Name = "TestButton"
TestButton.Parent = MainFrame
TestButton.Position = UDim2.new(0.3, 0, 0.45, 0)
TestButton.Size = UDim2.new(0.4, 0, 0.15, 0)
TestButton.BackgroundColor3 = Color3.fromRGB(59, 130, 246)
TestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TestButton.Text = "Test Webhook"
TestButton.Font = Enum.Font.GothamBold
TestButton.TextSize = 16
TestButton.BorderSizePixel = 0
TestButton.AutoButtonColor = false
TestButton.ZIndex = 999999999

local TestButtonCorner = UICorner:Clone()
TestButtonCorner.Parent = TestButton

-- Hover effect
TestButton.MouseEnter:Connect(function()
    TweenService:Create(TestButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(29, 78, 216)}):Play()
end)

TestButton.MouseLeave:Connect(function()
    TweenService:Create(TestButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(59, 130, 246)}):Play()
end)

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.Position = UDim2.new(0.1, 0, 0.65, 0)
StatusLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Status: Chờ test webhook"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.ZIndex = 999999999

TimerFrame.Name = "TimerFrame"
TimerFrame.Parent = MainFrame
TimerFrame.Position = UDim2.new(0.1, 0, 0.8, 0)
TimerFrame.Size = UDim2.new(0.8, 0, 0.15, 0)
TimerFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TimerFrame.BorderSizePixel = 0
TimerFrame.ZIndex = 999999999

local TimerCorner = UICorner:Clone()
TimerCorner.Parent = TimerFrame

TimerLabel.Name = "TimerLabel"
TimerLabel.Parent = TimerFrame
TimerLabel.Position = UDim2.new(0, 10, 0, 0)
TimerLabel.Size = UDim2.new(0.4, 0, 1, 0)
TimerLabel.BackgroundTransparency = 1
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.Text = "Thời gian còn lại:"
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.TextSize = 14
TimerLabel.TextXAlignment = Enum.TextXAlignment.Left
TimerLabel.ZIndex = 999999999

TimerValue.Name = "TimerValue"
TimerValue.Parent = TimerFrame
TimerValue.Position = UDim2.new(0.5, 0, 0, 0)
TimerValue.Size = UDim2.new(0.5, -10, 1, 0)
TimerValue.BackgroundTransparency = 1
TimerValue.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerValue.Text = "60:00"
TimerValue.Font = Enum.Font.GothamBold
TimerValue.TextSize = 14
TimerValue.TextXAlignment = Enum.TextXAlignment.Right
TimerValue.ZIndex = 999999999

-- Variables for timer
local isTimerRunning = false
local timerConnection = nil
local startTime = 0

-- Thêm biến để theo dõi tổng số
local totalXP = 0
local totalCoins = 0

-- Function để gửi webhook
local function SendWebhook(url)
    if not url or url == "" then
        StatusLabel.Text = "Status: URL không hợp lệ!"
        return false
    end
    
    local elapsedTime = os.time() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60
    
    local data = {
        content = "",
        embeds = {
            {
                title = "📊 Webhook Status Report",
                description = "✅ Webhook đang hoạt động bình thường!",
                color = tonumber("0x4287f5"),
                fields = {
                    {
                        name = "⏰ Thời Gian Đã Treo",
                        value = string.format("%02d giờ %02d phút %02d giây", hours, minutes, seconds),
                        inline = true
                    },
                    {
                        name = "👤 Người Dùng",
                        value = Players.LocalPlayer.Name,
                        inline = true
                    },
                    {
                        name = "🎮 Game ID",
                        value = game.PlaceId,
                        inline = true
                    },
                    {
                        name = "📈 XP Nhận Được",
                        value = "```+1,200 XP\nTổng: " .. totalXP .. " XP```",
                        inline = true
                    },
                    {
                        name = "💰 Coins Nhận Được",
                        value = "```+1,200 Coins\nTổng: " .. totalCoins .. " Coins```",
                        inline = true
                    }
                },
                footer = {
                    text = "Webhook Tester | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }
    
    local success, response = pcall(function()
        return http_request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })
    end)
    
    if success then
        StatusLabel.Text = "Status: Webhook gửi thành công!"
        return true
    else
        StatusLabel.Text = "Status: Lỗi khi gửi webhook!"
        return false
    end
end

-- Thêm labels để hiển thị tổng số
local TotalStatsFrame = Instance.new("Frame")
TotalStatsFrame.Name = "TotalStatsFrame"
TotalStatsFrame.Parent = MainFrame
TotalStatsFrame.Position = UDim2.new(0.1, 0, 0.7, 0)  -- Điều chỉnh vị trí phù hợp
TotalStatsFrame.Size = UDim2.new(0.8, 0, 0.1, 0)
TotalStatsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TotalStatsFrame.BorderSizePixel = 0
TotalStatsFrame.ZIndex = 999999999

local TotalStatsCorner = UICorner:Clone()
TotalStatsCorner.Parent = TotalStatsFrame

local TotalXPLabel = Instance.new("TextLabel")
TotalXPLabel.Parent = TotalStatsFrame
TotalXPLabel.Position = UDim2.new(0, 10, 0, 0)
TotalXPLabel.Size = UDim2.new(0.5, -10, 1, 0)
TotalXPLabel.BackgroundTransparency = 1
TotalXPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalXPLabel.Text = "Tổng XP: 0"
TotalXPLabel.Font = Enum.Font.Gotham
TotalXPLabel.TextSize = 14
TotalXPLabel.TextXAlignment = Enum.TextXAlignment.Left
TotalXPLabel.ZIndex = 999999999

local TotalCoinsLabel = Instance.new("TextLabel")
TotalCoinsLabel.Parent = TotalStatsFrame
TotalCoinsLabel.Position = UDim2.new(0.5, 0, 0, 0)
TotalCoinsLabel.Size = UDim2.new(0.5, -10, 1, 0)
TotalCoinsLabel.BackgroundTransparency = 1
TotalCoinsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalCoinsLabel.Text = "Tổng Coins: 0"
TotalCoinsLabel.Font = Enum.Font.Gotham
TotalCoinsLabel.TextSize = 14
TotalCoinsLabel.TextXAlignment = Enum.TextXAlignment.Right
TotalCoinsLabel.ZIndex = 999999999

-- Sửa hàm UpdateTimer để cập nhật tổng số
local function UpdateTimer()
    local minutes = 60
    local seconds = 0
    
    while isTimerRunning do
        if seconds == 0 then
            if minutes == 0 then
                -- Cập nhật tổng số mỗi giờ
                totalXP = totalXP + 1200
                totalCoins = totalCoins + 1200
                
                -- Cập nhật labels
                TotalXPLabel.Text = "Tổng XP: " .. totalXP
                TotalCoinsLabel.Text = "Tổng Coins: " .. totalCoins
                
                local url = WebhookInput.Text
                if url and url ~= "" then
                    SendWebhook(url)
                end
                minutes = 60
                seconds = 0
            else
                minutes = minutes - 1
                seconds = 59
            end
        else
            seconds = seconds - 1
        end
        
        TimerValue.Text = string.format("%02d:%02d", minutes, seconds)
        wait(1)
    end
end

-- Test button click handler
TestButton.MouseButton1Click:Connect(function()
    -- Stop existing timer if running
    if isTimerRunning then
        isTimerRunning = false
        if timerConnection then
            timerConnection:Disconnect()
        end
    end
    
    -- Start new timer
    isTimerRunning = true
    startTime = os.time()
    
    -- Send initial webhook
    local url = WebhookInput.Text
    SendWebhook(url)
    
    -- Start timer in new thread
    timerConnection = spawn(UpdateTimer)
end)

-- Close button
CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.ZIndex = 999999999

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if isTimerRunning then
        isTimerRunning = false
        if timerConnection then
            timerConnection:Disconnect()
        end
    end
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)