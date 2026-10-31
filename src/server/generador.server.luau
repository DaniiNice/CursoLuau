-- Generador de Cubos principal --
local botonGenerador = workspace.Map.BotonCentral:WaitForChild("BotonGenerador")
local clickdetector = botonGenerador:WaitForChild("ClickDetector")
local spawner = workspace.Map.Spawner:WaitForChild("SpawnPoint")
local sonidoError = botonGenerador:WaitForChild("SonidoError")
local sonidoClick = botonGenerador:WaitForChild("SonidoClick")
local cubosActivos = 0
local debounce = false


clickdetector.MouseClick:Connect(function(jugador)
    if debounce then return end

    if jugador then
        debounce = true
        local guiError = jugador.PlayerGui:WaitForChild("ErrorBlocks")

        if cubosActivos <= 5 then
            -- Creo el nuevo bloque con los valores por defecto y lo muevo a una carpeta con la ubicacion del spawner
            local block = Instance.new("Part")
            block.Size = Vector3.new(4, 4, 4)
            block.Position = spawner.Position
            block.Anchored = false
            block.CanCollide = true
            block:SetAttribute("Estado", "MateriaPrima")
            block.Parent = workspace.Map.Cubos
            sonidoClick:Play()
            cubosActivos += 1

            task.wait(0.2)

            debounce = false
        else if cubosActivos >= 5 then
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
    end
end)