-- Procesador Inicial --
local procesadorNivel1 = workspace.Map.Procesador.TouchZone:WaitForChild("ProcesadorNivel1")
local sonidoFundir = procesadorNivel1:WaitForChild("SonidoFundir")
local maquinaOcupada = false


while true do
    -- Si la maquina esta ocupada, no busca por rendimiento, si no fuera asi, busca cubos
    if maquinaOcupada == false then
        local cubosEncontrados = workspace:GetPartsInPart(procesadorNivel1)         -- Obtengo todas los cubos en una lista de la zona de fundicion para ponerlo en cola

        for i, cubo in ipairs(cubosEncontrados) do                                  -- Recorro cada cubo encontrado en la lista creada
            local estadoActual = cubo:GetAttribute("Estado")

            -- Compruebo que el objeto tiene el estado correspondiente
            if estadoActual == "MateriaPrima" then
                maquinaOcupada = true                          -- Cierro la maquina para el bucle for
                cubo:SetAttribute("Procesando", true)          -- Activo el cerrojo solo para este cubo especifico para los demas sistemas lo detecten
                task.wait(0.5)                                 -- Mini cooldown para no congelar el bloque nada mas toca el borde del procesador
                cubo.Anchored = true
                sonidoFundir:Play()

                task.wait(10)                                  -- Tiempo de fundicion

                sonidoFundir:Stop()
                cubo:SetAttribute("Estado", "Hierro")
                cubo.Color = Color3.fromRGB(150, 150, 150)
                cubo.Material = Enum.Material.Metal                                        -- Cambio el material (el material me cambia a una masa pesada)
                cubo.CustomPhysicalProperties = PhysicalProperties.new(0.5, 0.3, 0.5)      -- Cambio la densidad para que el usuario lo pueda empujar
                cubo.Anchored = false
                cubo:SetAttribute("Procesando", nil)
                maquinaOcupada = false
                break                                                                      -- Rompemos el bucle for actual para volver a escanear por si cambio la lista
            end
        end
    end
    task.wait(0.1)
end