-- Leaderstats / ACT 1 --
-- Guardo el servicio Players (Como import en python)
local Players = game:GetService("Players") 

-- Escucho cuándo pasa con un objetivo
Players.PlayerAdded:Connect(function(player) 
    local miCarpeta = Instance.new("Folder")        -- Creo un objeto predefinido
    local miValor = Instance.new("IntValue")

    miCarpeta.Name = "leaderstats"                  -- Asigno un nombre al objeto (nombre variable no cambia)
    miValor.Name = "Monedas"
    miValor.Value = 0
    
    miValor.Parent = miCarpeta                      -- Meto el valor dentro de la carpeta
    miCarpeta.Parent = player                       -- Meto la carpeta dentro del jugador
end)