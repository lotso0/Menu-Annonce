local ESX = exports['es_extended']:getSharedObject()

local DISCORD_WEBHOOK_URL = "ton webhook discord" -- Remplacez par votre URL de Webhook Discord

-- Fonction pour envoyer un message au Webhook Discord
local function sendToDiscord(title, message, imageUrl, playerName, playerLicense, playerIP, playerJob, playerGrade, date)
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = 3447003, -- Couleur de l'embed (bleu)
            ["fields"] = {
                {["name"] = "Joueur", ["value"] = playerName, ["inline"] = true},
                {["name"] = "License", ["value"] = playerLicense, ["inline"] = true},
                {["name"] = "IP", ["value"] = playerIP, ["inline"] = true},
                {["name"] = "Job", ["value"] = playerJob, ["inline"] = true},
                {["name"] = "Grade", ["value"] = playerGrade, ["inline"] = true},
                {["name"] = "Date", ["value"] = date, ["inline"] = true}
            },
            ["image"] = {
                ["url"] = imageUrl or "ton logo"
            },
            ["footer"] = {
                ["text"] = "Système d'annonces",
                ["icon_url"] = "https://example.com/footer_icon.png"
            }
        }
    }

    PerformHttpRequest(DISCORD_WEBHOOK_URL, function(err, text, headers)
        if err ~= 200 then
            print("Erreur lors de l'envoi au Webhook Discord : " .. tostring(err))
        end
    end, "POST", json.encode({embeds = embed}), {["Content-Type"] = "application/json"})
end

-- Modification de l'événement 'lotso:envoyerAnnonceJob'
RegisterServerEvent('lotso:envoyerAnnonceJob')
AddEventHandler('lotso:envoyerAnnonceJob', function(message, imageUrl, duration)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        print("Joueur introuvable.")
        return
    end

    local job = xPlayer.getJob()
    if not job or not job.label then
        print("Le job du joueur est introuvable ou incorrect.")
        return
    end

    local playerName = xPlayer.getName()
    local playerLicense = xPlayer.identifier
    local playerIP = GetPlayerEndpoint(source) or "IP introuvable"
    local playerJob = job.label or "Job inconnu"
    local playerGrade = job.grade_label or "Grade inconnu"
    local date = os.date("%Y-%m-%d %H:%M:%S")
    local image = imageUrl or "https://r2.fivemanage.com/T3bxojrbPNM4Qfv2MCgUy/logo_gif.gif"
    local title = "Annonce " .. playerJob
    local subtitle = 'Annonce Métier'

    -- Envoi de la notification en jeu
    TriggerClientEvent('_DOLIRHUME:NOTIF:BULLETIN:SHOW:ADVANCED', -1, image, title, subtitle, message, duration)

    -- Envoi au Webhook Discord
    sendToDiscord(title, message, image, playerName, playerLicense, playerIP, playerJob, playerGrade, date)
end)

-- Modification de l'événement 'lotso:envoyerAnnoncePredifiee'
RegisterServerEvent('lotso:envoyerAnnoncePredifiee')
AddEventHandler('lotso:envoyerAnnoncePredifiee', function(index, duration)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        print("Joueur introuvable.")
        return
    end

    local job = xPlayer.getJob()
    if not job or not job.label then
        print("Le job du joueur est introuvable ou incorrect.")
        return
    end

    local playerName = xPlayer.getName()
    local playerLicense = xPlayer.identifier
    local playerIP = GetPlayerEndpoint(source) or "IP introuvable"
    local playerJob = job.label or "Job inconnu"
    local playerGrade = job.grade_label or "Grade inconnu"
    local date = os.date("%Y-%m-%d %H:%M:%S")
    local predefined = {
        {label = "Redémarrage serveur imminent", msg = "⚠️ Le serveur va redémarrer dans %d minutes, pensez à vous déconnecter proprement."},
        {label = "Recrutement ouvert", msg = "📌 Le recrutement est actuellement ouvert, postulez via notre Discord !"},
        {label = "Événement en cours", msg = "🎉 Un événement est en cours ! Rejoignez-nous au point indiqué sur votre carte."}
    }

    local predefinedAnnouncement = predefined[index]
    if not predefinedAnnouncement then
        print("Annonce prédéfinie introuvable.")
        return
    end

    -- Définir le titre sans le job pour "Redémarrage serveur imminent"
    local title
    if predefinedAnnouncement.label == "Redémarrage serveur imminent" then
        title = predefinedAnnouncement.label
        predefinedAnnouncement.msg = string.format(predefinedAnnouncement.msg, duration or 3) -- Utilise la durée choisie
    else
        title = predefinedAnnouncement.label .. " - " .. playerJob
    end

    local image = "https://r2.fivemanage.com/T3bxojrbPNM4Qfv2MCgUy/logo_gif.gif"
    local subtitle = 'Annonce'
    local message = predefinedAnnouncement.msg
    local notifDuration = 7000

    -- Envoi de la notification en jeu
    TriggerClientEvent('_DOLIRHUME:NOTIF:BULLETIN:SHOW:ADVANCED', -1, image, title, subtitle, message, notifDuration)

    -- Envoi au Webhook Discord
    sendToDiscord(title, message, image, playerName, playerLicense, playerIP, playerJob, playerGrade, date)
end)