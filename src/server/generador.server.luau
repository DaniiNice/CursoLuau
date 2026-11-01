-- Generador de Cubos principal --
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
            -- Creo el nuevo bloque con los valores por defecto y lo muevo a una carpeta con la ubicacion del spawner
            local block = Instance.new("Part")
            block.Size = Vector3.new(4, 4, 4)
            block.Position = spawner.Position
            block.Anchored = false
            block.CanCollide = true
            block:SetAttribute("Estado", "MateriaPrima")                        -- Creo el estado inicial del material
            block:SetAttribute("Creador", jugador.Name)                         -- Guardo el creador en un atributo
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