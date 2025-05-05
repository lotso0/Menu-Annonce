---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 430, Height = 35 },
    Text = { X = 0, Y = 4, Scale = 0.40 },
}

function RageUI.Separator(Label)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            -- Initialisation des valeurs par défaut si elles sont nil
            CurrentMenu.X = CurrentMenu.X or 0
            CurrentMenu.Y = CurrentMenu.Y or 0
            RageUI.ItemOffset = RageUI.ItemOffset or 0

            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    RenderText(Label, SettingsButton.Text.X, 
                        20 + SettingsButton.Text.Y + RageUI.ItemOffset, 
                        13, SettingsButton.Text.Scale, 
                        255, 255, 255, 255)
                end
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    else
        print("Erreur : CurrentMenu est nil.")
    end
end

---@type table
local SettingsTitle = {
    Text = { X = 0, Y = 4, Scale = 0.25 },
}

function RageUI.Title(Label)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            -- Initialisation des valeurs par défaut si elles sont nil
            CurrentMenu.X = CurrentMenu.X or 0
            CurrentMenu.Y = CurrentMenu.Y or 0

            if (Label ~= nil) then
                RenderText(Label, CurrentMenu.X, CurrentMenu.Y, 255, SettingsTitle.Text.Scale, 255, 255, 255, 255)
            end
        end
    else
        print("Erreur : CurrentMenu est nil.")
    end
end