-- Configuracion Materiales --
local ConfigMateriales = {}

-- Diccionario principal de materiales del juego
ConfigMateriales.Tipos = {
	MateriaPrima = {
		Nombre = "Materia Prima",
		Color = Color3.fromRGB(163, 162, 165),
		Material = Enum.Material.Plastic,
		PrecioVenta = 2,
		Peso = 0.2
	},
	Hierro = {
		Nombre = "Hierro Fundido",
		Color = Color3.fromRGB(150, 150, 150),
		Material = Enum.Material.Metal,
		PrecioVenta = 15,
		Peso = 0.5
	},
	Oro = {
		Nombre = "Oro Fundido",
		Color = Color3.fromRGB(255, 215, 0),
		Material = Enum.Material.Metal,
		PrecioVenta = 50,
		Peso = 0.8
	}
}

-- Tabla de probabilidades para el Spawneo (Gacha)
-- La suma total debe dar 100
ConfigMateriales.ProbabilidadesSpawneo = {
	{ Material = "MateriaPrima", 	Probabilidad = 85 },			-- Equivale al rango 1 al 85
	{ Material = "Hierro",			Probabilidad = 15 }				-- Equivale al rango 1 al 15... etc
}

return ConfigMateriales