-- Zona de Ventas --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConfigMateriales = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ConfigMateriales"))
local zonaVenta = workspace.Map.Ventas.TouchZone:WaitForChild("ZonaVenta")
local efectoVenta = zonaVenta.Attachment:WaitForChild("ChispasVenta")
local sonidoVenta = zonaVenta:WaitForChild("SonidoMonedas")
local Players = game:GetService("Players")
debounce = false


while true do
    if debounce == false then
        local cubosEncontrados = workspace:GetPartsInPart(zonaVenta)
        local cubosActivos = workspace:GetAttribute("CubosActivos")

        for i, cubo in ipairs(cubosEncontrados) do
            if not cubo or cubo.Parent == nil then continue end                 -- Evito que crashe al leer un cubo destruyendose

            local estadoActual = cubo:GetAttribute("Estado")
            local creador = cubo:GetAttribute("Creador")

            if creador ~= nil then                                              -- Evito que crashe al leer un atributo destruyendose
                local jugadorReal = Players:FindFirstChild(creador)
                local datosDelMaterial = ConfigMateriales.Tipos[estadoActual]       -- Guardo el resultado entero del objeto del material consultado en el ModuleScript

                if datosDelMaterial and jugadorReal then                            -- Compruebo si el material es valido y tiene creador
                    local precio = datosDelMaterial.PrecioVenta

                    -- Leemos si esta el atributo especial de bonificacion y la aplicamos
                    if cubo:GetAttribute("MultiplicadorTamanio") then
                        precio *= cubo:GetAttribute("MultiplicadorTamanio")
                    end

                    efectoVenta:Emit(15)                                            -- Activo el efecto de forma explosiva
                    sonidoVenta:Play()
                    jugadorReal.leaderstats.Monedas.Value += precio                 -- Suma el dinero al creador
                    workspace:SetAttribute("CubosActivos", cubosActivos - 1)        -- Le resto el valor compartido
                    cubo:Destroy()
                end
            end
        end
    end
    task.wait(0.2)
end