---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 400, Height = 45 },
    Text = { X = 5, Y = 12, Scale = 0.28 },
    LeftBadge = { Y = 30, Width = 37, Height = 37 },
    RightBadge = { X = 340, Y = 28.5, Width = 40, Height = 40 },
    RightText = { X = 400, Y = 18, Scale = 0.25 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "background", Y = 8, Width = 430, Height = 42 },
}

---@type table
local SettingsCheckbox = {
    Dictionary = "commonmenu", 
    Textures = {
        "shop_box_blankb", -- 1
        "shop_box_tickb", -- 2
        "shop_box_blank", -- 3
        "shop_box_tick", -- 4
        "shop_box_crossb", -- 5
        "shop_box_cross", -- 6
    },
    X = 330, 
    Y = 1.5, 
    Width = 55, 
    Height = 55
}

RageUI.CheckboxStyle = {
    Tick = 1,
    Cross = 2
}

---StyleCheckBox
---@param Selected number
---@param Checked boolean
---@param Box number
---@param BoxSelect number
---@return nil

local function StyleCheckBox(Selected, Checked, Box, BoxSelect, OffSet)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if OffSet == nil then
        OffSet = 0
    end

    if Checked then
        RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[BoxSelect], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, 20 + CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
    else
        RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[3], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, 20 + CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
    end
end

function RageUI.Checkbox(Label, Description, Checked, Style, Actions)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                ---@type number
                local Selected = CurrentMenu.Index == Option
                local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local BoxOffset = 0
                RageUI.ItemsSafeZone(CurrentMenu)

                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                RenderSprite("commonmenu", "bouton", CurrentMenu.X + 7,
                CurrentMenu.Y + 20 + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight +
                RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset - 55,
                SettingsButton.SelectedSprite.Height - 1, 0, 0, 0, 0, 100)
    
                if Selected then 
                    RenderSprite("commonmenu", "bouton", CurrentMenu.X + 7,
                    CurrentMenu.Y + 20 + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight +
                    RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset - 55,
                    SettingsButton.SelectedSprite.Height - 1, 0, Configk2rUI.Menu.CouleurBouton.R, Configk2rUI.Menu.CouleurBouton.G, Configk2rUI.Menu.CouleurBouton.B, 100)
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if Selected then
                            RenderText(Label, 10 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                        else
                            RenderText(Label, 10 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                        end
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)
                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, 21 + CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)
                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, 21 + CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = RageUI.BadgeStyle.Lock
                        ---@type number
                        local LeftBadgeOffset = ((LeftBadge == RageUI.BadgeStyle.None or LeftBadge == nil) and 0 or 27)

                        if Selected then
                            RenderText(Label, 10 +  CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 0, 0, 0, 255)
                        else
                            RenderText(Label, 10 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                        end

                        if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, 21 + CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end

                    if Style.Enabled == true or Style.Enabled == nil then
                        if Selected then
                            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then

                                RenderText(Style.RightLabel, 10 + CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, 21 + CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            end
                        else
                            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                                RenderText(Style.RightLabel, 10 + CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, 21 + CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.RightText.Scale, 255, 255, 255, 255, 2)
                                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            end
                        end
                    end

                    BoxOffset = RightBadgeOffset + BoxOffset
                    if Style.Style ~= nil then
                        if Style.Style == RageUI.CheckboxStyle.Tick then
                            StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                        elseif Style.Style == RageUI.CheckboxStyle.Cross then
                            StyleCheckBox(Selected, Checked, 5, 6, BoxOffset)
                        else
                            StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                        end
                    else
                        StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                    end

                    if Selected and (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and (Style.Enabled == true or Style.Enabled == nil) and not (isWaitingForServer) then
                        local Audio = RageUI.Settings.Audio
                        RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                        Checked = not Checked
                        if (Checked) then
                            if (Actions.onChecked ~= nil) then
                                Actions.onChecked();
                            end
                        else
                            if (Actions.onUnChecked ~= nil) then
                                Actions.onUnChecked();
                            end
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

                RageUI.ItemsDescription(CurrentMenu, Description, Selected)

                if (Actions.onSelected ~= nil) and (Selected) then
                    Actions.onSelected(Checked);
                end

            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end