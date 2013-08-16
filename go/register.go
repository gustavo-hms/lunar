package lunar

import (
	"fmt"
	"github.com/stevedonovan/luar"
)

var L = luar.Init()

func init() {
	set := luar.NewLuaObjectFromName(L, "setElementConstructor")
	_, err := set.Call(newElement)
	if err != nil {
		fmt.Println(err)
	}
}
