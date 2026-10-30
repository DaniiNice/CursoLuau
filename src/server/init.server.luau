-- Leaderstats | MODULO 1 / RETO 1-3 --
-- Guardo el servicio Players (Como import en python)
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local miBancoDeDatos = DataStoreService:GetDataStore("ProgresoMonedas")


-- Escucho cuándo pasa con un objetivo
Players.PlayerAdded:Connect(function(player) 
    local miCarpeta = Instance.new("Folder")        -- Creo un objeto predefinido
    local miValor = Instance.new("IntValue")

    miCarpeta.Name = "leaderstats"                  -- Asigno un nombre al objeto (nombre variable no cambia)
    miValor.Name = "Monedas"
    miValor.Value = 0                               -- Asigno valor por defecto

    local clave = "Jugador_" .. player.UserId       -- Asigno la clave primaria
    local datosGuardados = nil                      -- Creo la tabla de datos con nil (nulo/desconocido)

    -- Leo la base de datos (pcall que mantiene vivo la funcion tras un fallo)
    pcall(function()
        datosGuardados = miBancoDeDatos:GetAsync(clave)
    end)

    -- Si hay datos del pasado, se lo asigno. Si no, se queda el valor por defecto
    if datosGuardados then
        miValor.Value = datosGuardados
    end

    miValor.Parent = miCarpeta                      -- Meto el valor dentro de la carpeta
    miCarpeta.Parent = player                       -- Meto la carpeta dentro del jugador

    -- Bucle de autodinero de forma periodica
    while true do
        task.wait(1)
        miValor.Value += 1
    end
end)


Players.PlayerRemoving:Connect(function(player)
    local clave = "Jugador_" .. player.UserId
    local monedasActuales = player.leaderstats.Monedas.Value        -- Conecto el valor actual de la moneda ya creada

    -- Lo guardo en la nube
    pcall(function()
        miBancoDeDatos:SetAsync(clave, monedasActuales)
    end)
end)