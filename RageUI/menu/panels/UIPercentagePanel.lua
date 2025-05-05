local Percentage = {
    Background = { Dictionary = "galaxia", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 65 },
    Bar = { X = 32, Y = 60, Width = 360, Height = 10 },
    Text = {
        Left = { X = 45, Y = 30, Scale = 0.30 },
        Middle = { X = 215.5, Y = 30, Scale = 0.30 },
        Right = { X = 385, Y = 30, Scale = 0.30 },
    },
}

---PercentagePanel
---@param Percent number
---@param HeaderText string
---@param MinText string
---@param MaxText string
---@param Callback function
---@param Index number
---@return nil
---@public

function RageUI.PercentagePanel(Percent, HeaderText, MinText, MaxText, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu

    if CurrentMenu ~= nil then
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

            ---@type boolean
            local Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + Percentage.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 4, Percentage.Bar.Width + CurrentMenu.WidthOffset, Percentage.Bar.Height + 8)

            ---@type boolean
            local Selected = false

            ---@type number
            local Progress = Percentage.Bar.Width

            if Percent < 0.0 then
                Percent = 0.0
            elseif Percent > 1.0 then
                Percent = 1.0
            end

            Progress = Progress * Percent
            
            RenderRectangle(28 + CurrentMenu.X, 16 + CurrentMenu.Y + Percentage.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percentage.Background.Width + CurrentMenu.WidthOffset - 55, Percentage.Background.Height, 0, 0, 0, 100)
            -- RenderRectangle(28 + CurrentMenu.X, 16 + CurrentMenu.Y + Percentage.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 60, Percentage.Background.Width + CurrentMenu.WidthOffset - 55, Percentage.Background.Height, 18, 18, 18, 255)

            RenderRectangle(4 + CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percentage.Bar.Width, Percentage.Bar.Height, 0, 0, 0, 100)
            RenderRectangle(4 + CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Progress, Percentage.Bar.Height, 133, 133, 133, 255)

            RenderText(HeaderText or "Opacity", CurrentMenu.X + Percentage.Text.Middle.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Middle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Percentage.Text.Middle.Scale, 255, 255, 255, 255, 1)
            RenderText(MinText or "0%", CurrentMenu.X + Percentage.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Percentage.Text.Left.Scale, 255, 255, 255, 255, 1)
            RenderText(MaxText or "100%", CurrentMenu.X + Percentage.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Percentage.Text.Right.Scale, 255, 255, 255, 255, 1)

            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true

                    Progress = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2))

                    if Progress < 0 then
                        Progress = 0
                    elseif Progress > (Percentage.Bar.Width) then
                        Progress = Percentage.Bar.Width
                    end

                    Percent = math.round(Progress / Percentage.Bar.Width, 2)
                    if (Action.onProgressChange ~= nil) then
                        Action.onProgressChange(Percent)
                    end
                end
            end

            RageUI.ItemOffset = RageUI.ItemOffset + Percentage.Background.Height + Percentage.Background.Y

            if Hovered and Selected then
                local Audio = RageUI.Settings.Audio
                RageUI.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                if (Action.onSelected ~= nil) then
                    Action.onSelected(Percent)
                end
            end
        end
    end
end
