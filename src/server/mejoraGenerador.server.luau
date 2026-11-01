-- Mejoras Generador --
local modeloBoton = workspace.Map.Botones:WaitForChild("MejoraGenerador")
local botonUpgrade = modeloBoton:WaitForChild("BotonUpgrade") 
local botonGenerador = workspace.Map.BotonCentral:WaitForChild("BotonGenerador")
local sonidoCompra = botonUpgrade:WaitForChild("SonidoCompra")
local Players = game:GetService("Players")
local debounce = false


botonUpgrade.Touched:Connect(function(objetoQueToco)
    if debounce then return end

    local avatar = objetoQueToco.Parent
    local jugador = Players:GetPlayerFromCharacter(avatar)

    if jugador then
        debounce = true
        local dineroJugador = jugador.leaderstats.Monedas

        if dineroJugador.Value >= 100 then
            botonGenerador:SetAttribute("CantidadPorClick", 2)           -- Cambio el valor compartido para la mejora
            dineroJugador.Value -= 100
            sonidoCompra:Play()
            botonUpgrade.Transparency = 1
            modeloBoton.part.Transparency = 1
            botonUpgrade.CanCollide = false
            modeloBoton.part.CanCollide = false
            task.wait(2)                                                 -- Tiempo para que termine el sonido y se pueda destruir
            modeloBoton:Destroy()
            debounce = false
        else
            task.wait(0.2)
            debounce = false
        end
    end
end)