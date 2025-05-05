local ESX = exports['es_extended']:getSharedObject()

local menuOpen = false
local mainMenu = RageUI.CreateMenu("Annonces", "Menu des annonces")
local customMessage = ""
local customImage = "ton logo"
local customTitle = ""

-- IMAGES PAR MÉTIER
local jobImages = {
    police = {
        {label = "Mort de ace", imgUrl = "https://www.japanfm.fr/wp-content/uploads/2023/06/one-piece-mort-d-ace.png", selected = false},
    },
    wine = {
        {label = "Luffy qui mange", imgUrl = "https://gifsec.com/wp-content/uploads/2023/01/luffy-gif-1.gif", selected = false},
    },
    mechanic = {
        {label = "Combat épique", imgUrl = "https://i.gifer.com/DaF.gif", selected = false},
    }
}

-- ANNONCES PRÉDÉFINIES
local predefined = {
    {label = "Redémarrage serveur imminent", msg = "⚠️ Le serveur va redémarrer dans 5 minutes, pensez à vous déconnecter proprement."},
    {label = "Recrutement ouvert", msg = "📌 Le recrutement est actuellement ouvert, postulez via notre Discord !"},
    {label = "Événement en cours", msg = "🎉 Un événement est en cours ! Rejoignez-nous au point indiqué sur votre carte."}
}

-- OUVERTURE DU MENU D'ANNONCE
function OpenAnnonceMenu()
    if menuOpen then return end
    menuOpen = true
    RageUI.Visible(mainMenu, true)

    -- récupérer les images correspondant au job
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job and playerData.job.name or nil
    local playerGroup = playerData.group -- Récupère le groupe du joueur

    if not playerJob or playerJob == "unemployed" then
        -- Notifie le joueur qu'il n'a pas de job ou qu'il est au chômage
        exports['DoliStore_Notify']:_DOLI_CL_SHOW_NOTIFICATION('Vous n\'avez pas un job valide!', 5000)
        menuOpen = false
        return
    end

    local jobImageList = jobImages[playerJob] or {}

    Citizen.CreateThread(function()
        while menuOpen do
            if not RageUI.Visible(mainMenu) then
                menuOpen = false
                break
            end

            RageUI.IsVisible(mainMenu, function()
                -- Message perso
                RageUI.Separator("Annonce personnalisée")
                RageUI.Button("✏️ Saisir le message", customMessage ~= "" and customMessage or "Aucun message", {}, true, {
                    onSelected = function()
                        local result = KeyboardInput("Message de l'annonce", "", 200)
                        if result then
                            customMessage = result
                            customTitle = "Job: " .. playerJob
                        end
                    end
                })

                RageUI.Button("📤 Envoyer l'annonce", nil, {}, customMessage ~= "", {
                    onSelected = function()
                        TriggerServerEvent('lotso:envoyerAnnonceJob', customMessage, customImage)
                        customMessage = ""
                    end
                })

                -- Images du job
                RageUI.Separator("Images")
                for i, item in ipairs(jobImageList) do
                    RageUI.Checkbox(item.label, nil, item.selected, {}, {
                        onChecked = function()
                            for j, other in ipairs(jobImageList) do
                                other.selected = (i == j)
                            end
                            customImage = item.imgUrl
                            TriggerServerEvent('lotso:setCustomNotificationImage', customImage)
                        end,
                        onUnChecked = function()
                            item.selected = false
                            customImage = "https://r2.fivemanage.com/T3bxojrbPNM4Qfv2MCgUy/logo_gif.gif"
                        end
                    })
                end

                -- Annonces prédéfinies
                RageUI.Separator("Annonces prédéfinies")
                for index, item in pairs(predefined) do
                    -- Vérifie si l'annonce est "Redémarrage serveur imminent" et si le joueur est admin
                    if item.label == "Redémarrage serveur imminent" then
                        if playerGroup == "admin" then
                            RageUI.Button(item.label, nil, {}, true, {
                                onSelected = function()
                                    -- Demander la durée avant le redémarrage
                                    local result = KeyboardInput("Temps avant redémarrage (en minutes)", "", 3)
                                    if result and tonumber(result) then
                                        local duration = tonumber(result)
                                        TriggerServerEvent('lotso:envoyerAnnoncePredifiee', index, duration) -- Passe l'index et la durée
                                    else
                                        exports['DoliStore_Notify']:_DOLI_CL_SHOW_NOTIFICATION('~r~Format invalide~s~', 5000)
                                    end
                                end
                            })
                        end
                    else
                        -- Affiche les autres annonces pour tous les joueurs
                        RageUI.Button(item.label, nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('lotso:envoyerAnnoncePredifiee', index) -- Passe l'index de l'annonce prédéfinie
                            end
                        })
                    end
                end

            end)
            Wait(0)
        end
    end)
end

RegisterCommand("lotsoo", function()
    OpenAnnonceMenu()
end, false)

-- INPUT CLAVIER
function KeyboardInput(entryTitle, defaultText, maxLength)
    AddTextEntry("FMMC_KEY_TIP1", entryTitle)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", defaultText, "", "", "", maxLength)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        DisableAllControlActions(0) -- Empêche de bouger pendant l'écriture
        Wait(0)
    end

    EnableAllControlActions(0) -- Réactive les contrôles après
    if UpdateOnscreenKeyboard() == 1 then
        local result = GetOnscreenKeyboardResult()
        if result and result:match("%S") then -- Vérifie qu'on n'a pas que des espaces
            return result
        end
    end
    return nil -- Si cancel ou vide
end

-- Enregistrement de la commande pour ouvrir le menu
RegisterCommand("lotso", function()
    OpenAnnonceMenu()
end, false)

-- Lier la commande "lotsoo" à la touche F9
RegisterKeyMapping("lotso", "Ouvrir le menu des annonces", "keyboard", "F9")