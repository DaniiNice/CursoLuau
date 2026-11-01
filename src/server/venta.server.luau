-- Zona de Ventas --
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
            local estadoActual = cubo:GetAttribute("Estado")
            local creador = cubo:GetAttribute("Creador")
            local jugadorReal = Players:FindFirstChild(creador)

            if estadoActual == "Hierro" and jugadorReal then
                efectoVenta:Emit(20)                                            -- Activo el efecto de forma explosiva
                sonidoVenta:Play()
                jugadorReal.leaderstats.Monedas.Value += 15                     -- Suma el dinero al creador
                workspace:SetAttribute("CubosActivos", cubosActivos - 1)        -- Le resto el valor compartido sin sustituirlo
                cubo:Destroy()
            end
        end
    end
    task.wait(0.2)
end