Config = {}

-- URL par défaut pour les images
Config.DefaultImageUrl = "ton logo"

-- Durée par défaut des notifications (en millisecondes)
Config.DefaultNotificationDuration = 7000

-- URL du Webhook Discord
Config.DiscordWebhookUrl = "ton webhook discord"

-- Fonction de notification (modifiable par l'utilisateur)
-- Remplacez cette fonction par votre propre système de notification
Config.Notify = function(message, duration)
    -- Exemple avec DoliStore_Notify
    exports['DoliStore_Notify']:_DOLI_CL_SHOW_NOTIFICATION(message, duration or Config.DefaultNotificationDuration)

    -- Exemple avec un autre système (décommentez et remplacez si nécessaire)
    -- exports['my_custom_notify']:ShowNotification(message, duration or Config.DefaultNotificationDuration)
end

-- IMAGES PAR MÉTIER
Config.JobImages = {
    police = {
        {label = "Mort de Ace", imgUrl = "https://www.japanfm.fr/wp-content/uploads/2023/06/one-piece-mort-d-ace.png", selected = false},
        {label = "Badge Police", imgUrl = "https://example.com/police_badge.png", selected = false},
    },
    wine = {
        {label = "Luffy qui mange", imgUrl = "https://gifsec.com/wp-content/uploads/2023/01/luffy-gif-1.gif", selected = false},
        {label = "Unicorn Logo", imgUrl = "https://example.com/unicorn_logo.png", selected = false},
    },
    mechanic = {
        {label = "Combat épique", imgUrl = "https://i.gifer.com/DaF.gif", selected = false},
        {label = "Clé à molette", imgUrl = "https://example.com/wrench.png", selected = false},
    }
}

-- ANNONCES PRÉDÉFINIES
Config.PredefinedAnnouncements = {
    {label = "Redémarrage serveur imminent", msg = "⚠️ Le serveur va redémarrer dans 5 minutes, pensez à vous déconnecter proprement."},
    {label = "Recrutement ouvert", msg = "📌 Le recrutement est actuellement ouvert, postulez via notre Discord !"},
    {label = "Événement en cours", msg = "🎉 Un événement est en cours ! Rejoignez-nous au point indiqué sur votre carte."},
    {label = "Maintenance prévue", msg = "🔧 Une maintenance est prévue demain à 10h. Merci de votre compréhension."},
    {label = "Mise à jour disponible", msg = "✨ Une nouvelle mise à jour est disponible. Redémarrez votre jeu pour en profiter !"}
}