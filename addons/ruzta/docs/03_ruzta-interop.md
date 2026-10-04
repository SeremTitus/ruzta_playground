# Ruzta - non-Ruzta script (e.g gdscript) Interoperability

Ruzta and GDScript can be used together in the same project. Scripts reference each
other by path, and a Ruzta script can inherit from a GDScript base class so both
languages share methods and state on the same object.

## Load a non-Ruzta script into a Ruzta *.rz

To use a GDScript class from a Ruzta script, load it by path:

```modify_style.rz

func change_error_btn_color():
	load("res://addons/gdss/gdss.gd").set_prop_override(error_toggle_btn, "font_color", Color.RED)

```

`load()` returns the script, and you call its static methods or access its constants
directly. The same `load()` call works from GDScript to reference a Ruzta script.

## Extend a GDScript base (`extends`)

A Ruzta script can inherit from a GDScript (`*.gd`) base, just as it inherits from a
Ruzta base. Point `extends` at the external script path:

```child.rz
extends  "res://addons/gut/test.gd"       # also  can be uid://...

func test_pass():
	assert_true(true, "this should pass")

func test_math():
	assert_eq(2 + 2, 4, "basic math")

func test_string():
	assert_eq("hello".length(), 5, "string length")
```
