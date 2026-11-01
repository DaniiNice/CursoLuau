-- Leaderstats --
-- Guardo el servicio Players (Como import en python)
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local miBancoDeDatos = DataStoreService:GetDataStore("ProgresoFabricaV1")


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
        miValor.Value = datosGuardados.Monedas or 0

        -- Si el jugador ya tenía una potencia guardada, se la aplicamos
        if datosGuardados.PotenciaGenerador then
            local botonCentral = workspace.Map.BotonCentral:WaitForChild("BotonGenerador")
            botonCentral:SetAttribute("CantidadPorClick", datosGuardados.PotenciaGenerador)
        end

        -- Si es de nivel 2, eliminamos el boton
        if datosGuardados.PotenciaGenerador == 2 then
            workspace.Map.Botones.MejoraGenerador:Destroy()
        end
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
    local monedasActuales = player.leaderstats.Monedas.Value                            -- Conecto el valor actual de la moneda ya creada
    local botonCentral = workspace.Map.BotonCentral:WaitForChild("BotonGenerador")
    local potenciaActual = botonCentral:GetAttribute("CantidadPorClick") or 1
    local datosGuardados = {                                                            -- Creo la tabla de datos compuesta para las monedas y mejoras
        Monedas = monedasActuales,
        PotenciaGenerador = potenciaActual
        -- En un futuro se añadiran mas guardados aqui
    }

    -- Lo guardo en la nube
    pcall(function()
        miBancoDeDatos:SetAsync(clave, datosGuardados)
    end)
end)