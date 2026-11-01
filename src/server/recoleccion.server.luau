-- Recoleccion --
local arbol = workspace.Map.Arboles:WaitForChild("ArbolMadera")
local clickDetector = arbol:WaitForChild("ClickDetector")
local sonidoGolpe = arbol:WaitForChild("SonidoGolpe")
local sonidoRomper = arbol:WaitForChild("SonidoRomper")
local debounce = false
local golpesRestantes = 5


clickDetector.MouseClick:Connect(function(jugador)
    if debounce then return end
     
    if jugador then
        debounce = true
        golpesRestantes -= 1
        sonidoGolpe:Play()
        local dineroJugador = jugador.leaderstats.Monedas

        -- Recoleccion despawn/spawn
        if golpesRestantes <= 0 then
            dineroJugador.Value += 1000
            arbol.CanCollide = false
            clickDetector.MaxActivationDistance = 0

            -- Animacion simple de recoleccion
            sonidoRomper:Play()
            for i = 1, 10 do                             
                arbol.Transparency += 0.1
                task.wait(0.1)
            end

            task.wait(5)

            arbol.Transparency = 0
            arbol.CanCollide = true
            clickDetector.MaxActivationDistance = 32
            golpesRestantes = 5
            debounce = false
        else
            task.wait(0.2)
            debounce = false
        end
    end
end)