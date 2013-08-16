package lunar

import (
	"strings"
)

type Builder interface {
	Build() []string
}

func newElement(tag string) *element {
	return &element{Tag: tag}
}

type element struct {
	Attributes []string
	Elements   []Builder
	Tag        string
}

func (e element) Build() []string {
	output := make([]string, 0)
	attrs := strings.Join(e.Attributes, " ")
	output = append(output, "<", e.Tag, " ", attrs, ">")

	for _, element := range e.Elements {
		output = append(output, element.Build()...)
	}

	output = append(output, "</", e.Tag, ">")

	return output
}

func newEmptyElement(tag string) *emptyElement {
	return &emptyElement{Tag: tag}
}

type emptyElement struct {
	Attributes []string
	Tag        string
}

func (e emptyElement) Build() []string {
	attrs := strings.Join(e.Attributes, " ")

	return []string{"<", e.Tag, " ", attrs, ">"}
}
