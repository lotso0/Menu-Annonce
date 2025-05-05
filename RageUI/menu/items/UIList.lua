local SettingsButton = {
    Rectangle = { Y = 0, Width = 400, Height = 45 },
    Text = { X = 5, Y = 12, Scale = 0.28 },
    LeftBadge = { Y = 30, Width = 37, Height = 37 },
    RightBadge = { X = 340, Y = 28.5, Width = 40, Height = 40 },
    RightText = { X = 400, Y = 18, Scale = 0.25 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "background", Y = 8, Width = 430, Height = 42 },
}

---@type table
local SettingsList = {
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 368, Y = 0, Width = 28, Height = 45 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 390, Y = 0, Width = 28, Height = 45 },
    Text = { X = 370, Y = 16, Scale = 0.25 },
}

function RageUI.List(Label, Items, Index, Description, Style, Enabled, Actions, Submenu, IndexColor)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = RageUI.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                RageUI.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local RightOffset = 0
                ---@type boolean
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

                ---@type boolean
                local ListText = (type(Items[Index]) == "table") and string.format("← %s →", Items[Index].Name) or string.format("← %s%s~s~ →", (IndexColor ~= nil and IndexColor or "~s~"), Items[Index]) or "NIL"

                if Enabled == true or Enabled == nil then
                    if Selected then
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                        end
                    else
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                        end
                    end
                end
                
                RightOffset = RightBadgeOffset * 1.3 + RightOffset

                if Enabled == true or Enabled == nil then
                    if Selected then
                        RenderText(Label, 10 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset - RightOffset, 21 + CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsList.Text.Scale, 255, 255, 255, 255, 2)
                    else
                        RenderText(Label, 10 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset - RightOffset, 21 + CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsList.Text.Scale, 255, 255, 255, 255, 2)
                    end
                else
                    RenderText(Label, 28 + CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, 21 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, fontIdButton, SettingsButton.Text.Scale, 255, 255, 255, 255)
                    
                    if Selected then
                        RenderText(ListText, 28 + CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset, 21 + CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsList.Text.Scale, 255, 255, 255, 255, 2)
                    else
                        RenderText(ListText, 28 + CurrentMenu.X + SettingsList.Text.X + 5 + CurrentMenu.WidthOffset, 21 + CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsList.Text.Scale, 255, 255, 255, 255, 2)
                    end
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)

                                    RenderSprite("commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end

                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)

                                    RenderSprite("commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = RageUI.BadgeStyle.Lock
                        ---@type number
                        if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite("commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                LeftArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset - RightOffset + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 2.5  + CurrentMenu.SafeZoneSize.Y , 15, 22.5)

                RightArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset + CurrentMenu.SafeZoneSize.X - RightOffset - MeasureStringWidth(ListText, 0, SettingsList.Text.Scale), CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 2.5 + CurrentMenu.SafeZoneSize.Y , 15, 22.5)
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

                RageUI.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    Index = Index - 1
                    if Index < 1 then
                        Index = #Items
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    Index = Index + 1
                    if Index > #Items then
                        Index = 1
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if (Actions.onSelected ~= nil and not isWaitingForServer) then
                        Actions.onSelected(Index, Items[Index]);
                    end

                    if Submenu ~= nil and type(Submenu) == "table" then
                        RageUI.NextMenu = Submenu[Index]
                    end
                elseif Selected then
                    if(Actions.onActive ~= nil) then
                        Actions.onActive()
                    end 
                end
            end

            RageUI.Options = RageUI.Options + 1
        end
    end
end