-- Generador de Cubos principal --
local replicatedStorage = game:GetService("ReplicatedStorage")
local configMateriales = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("ConfigMateriales"))
local botonGenerador = workspace.Map.BotonCentral:WaitForChild("BotonGenerador")
local clickdetector = botonGenerador:WaitForChild("ClickDetector")
local spawner = workspace.Map.Spawner:WaitForChild("SpawnPoint")
local sonidoError = botonGenerador:WaitForChild("SonidoError")
local sonidoClick = botonGenerador:WaitForChild("SonidoClick")
workspace:SetAttribute("CubosActivos", 0)                                   -- Creo un valor compartido
botonGenerador:SetAttribute("CantidadPorClick", 1)
local debounce = false


clickdetector.MouseClick:Connect(function(jugador)
    if debounce then return end

    if jugador then
        debounce = true
        local guiError = jugador.PlayerGui:WaitForChild("ErrorBlocks")
        local cubosActivos = workspace:GetAttribute("CubosActivos")
        local cantidad = botonGenerador:GetAttribute("CantidadPorClick")

        for i = 1, cantidad do
            if cubosActivos >= 5 then break end                                 -- Compruebo cada creacion para no pasarme

            local materialElegido = "MateriaPrima"                              -- Valor por defecto
            local dado = math.random(1, 100)                                    -- Valor aleatorio para el gacha
            local acumulado = 0

            -- GACHA --
            -- Recorro la lista de posibilidades y guardo el resultado
            for i, info in ipairs(configMateriales.ProbabilidadesSpawneo) do
                acumulado += info.Probabilidad                                  -- Sumo la probabilidad actual (total 100)

                --[[ Uso el acumulado como referencia a la probabilidad en rango
                (Ej: dado = 54 acumulado = 60 seria True porque al descartar
                opciones de la lista aumenta la probabilidad del siguiente
                de la tabla restante) ]]
                if dado <= acumulado then
                    materialElegido = info.Material                             -- Guardo el material actual de la tabla ProbabilidadesSpawneo
                    break
                end
            end
            -- == --

            -- BIG --
            local dadoTamanio = math.random(1, 100)
            local multiplicador = 1
            local tamanioBloque = Vector3.new(4, 4, 4)

            if dadoTamanio <= 10 then                                           -- 10% de ser grande (de momento hasta que sea una mejora escalable)
                multiplicador = 2                                               -- Multiplicador de valor (de momento hasta que sea una mejora escalable)
                tamanioBloque = Vector3.new(6, 6, 6)
            end
            -- == --

            -- Creo el nuevo bloque con los valores por defecto y lo muevo a una carpeta con la ubicacion del spawner
            local datosDelMaterial = configMateriales.Tipos[materialElegido]    -- Uso los datos del modulescript para la creacion del cubo
            local block = Instance.new("Part")
            block.Size = tamanioBloque
            block.Color = datosDelMaterial.Color
            block.Material = datosDelMaterial.Material
            block.Position = spawner.Position
            block.Anchored = false
            block.CanCollide = true
            block:SetAttribute("Estado", materialElegido)                       -- Creo el estado con el material elegido
            block:SetAttribute("Creador", jugador.Name)                         -- Guardo el creador en un atributo
            block:SetAttribute("MultiplicadorTamanio", multiplicador)           -- Guardo el multiplicador que tiene
            block.CustomPhysicalProperties = PhysicalProperties.new(0.5, 0.3, 0.5)
            block.Parent = workspace.Map.Cubos
            sonidoClick:Play()
            cubosActivos += 1                                                   -- Actualizo de forma local para que funcione correctamente
            workspace:SetAttribute("CubosActivos", cubosActivos)                -- Actualizo directamente en el valor compartido
        end

            task.wait(0.2)

            debounce = false

        if cubosActivos >= 5 then
            -- Pongo visible un sencillo label para el error
            sonidoError:Play()
            guiError.Enabled = true

            task.wait(2)

            guiError.Enabled = false
            debounce = false
        else
            debounce = false
        end
    end
end)