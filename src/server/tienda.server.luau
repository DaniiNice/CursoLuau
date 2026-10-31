-- Tienda | MODULO 2 / RETO 4 --
-- Espero a que carge el boton y me conecto a el
local boton = workspace.BotonInicial:WaitForChild("BotonVelocidad")
local Players = game:GetService("Players")
debounce = false                                                  -- Añado un cooldown para evitar multigastos


boton.Touched:Connect(function(objetoQueToco)
    -- Si esta en cooldown, sale de la funcion
    if debounce then
        return
    end

    local avatar = objetoQueToco.Parent                           -- Guardo el modelo del usuario
    local jugador = Players:GetPlayerFromCharacter(avatar)        -- Busco el usuario usando el modelo

    if jugador then
        local dineroJugador = jugador.leaderstats.Monedas         -- Localizo el dinero (objeto) del jugador

        if dineroJugador.Value >= 50 then                         -- Evito dinero negativo
            debounce = true

            avatar.Humanoid.WalkSpeed = 32                        -- Modifico la velocidad de forma permanente hasta respawn
            dineroJugador.Value -= 50

            task.wait(3)
            debounce = false
        end
    end
end)