html = element {}
div = element {}

component = div {
	id = property.name,
	class = "um dois";

	property.title,
	div {
		class = "três";

		"Olá!"
	}
}

comp = component {
	name = "componente-1",
	title = "Um componente"
}

c = comp "table"
