element.new "div"
element.newempty "br"

component = div {
	id = property.name,
	class = "um dois";

	property.title,

	div {
		class = "três";

		"Olá!"
	},

	br
}

comp = component {
	name = "componente-1",
	title = "Um componente"
}

c = comp "table"
