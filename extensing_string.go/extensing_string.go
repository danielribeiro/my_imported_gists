package main

import (
	"fmt"
)

type MyString string

func (s MyString) plusa() MyString {
	return s + "a"
}


func main() {
	s := MyString("text")
	fmt.Println(s)
	fmt.Println(s.plusa())
}