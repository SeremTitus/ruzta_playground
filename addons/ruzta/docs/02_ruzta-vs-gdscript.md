# Ruzta vs GDScript

Ruzta uses the same Godot scripting model as GDScript but adds tuples, generics, traits, function overloading, payload enums, and builder Constructor. Files use `.rz` instead of `.gd`.

## What stays the same

Most scripting works the same: indentation rules, `extends`, `class_name`, type hints, signals, annotations, collections, control flow, and the general Godot scripting model.

```shared_shape.rz
class_name Door
extends Node2D

@export var is_open := false

func toggle() -> void:
	is_open = not is_open
```

- If you can read [GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), you can read most Ruzta immediately.
- Static typing uses the same mental model: optional type hints, typed arrays, typed dictionaries, return annotations, `is`, and `as`.
- Scene callbacks such as `_ready()`, `_process()`, `_physics_process()`, and signal handlers look the same.
- Inspector workflows built around `@export`, `@onready`, and autoload singletons carry over as well.

### References

- [Static typing guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html) :: Typed variables, parameters, arrays, and dictionaries

## What changes in practice

The biggest differences are distribution and release timing, not everyday syntax. Ruzta scripts use `.rz`, and this project ships the language runtime as a [GDExtension](https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/what_is_gdextension.html) rather than baking it into the editor build.

- Use `.rz` instead of `.gd` for source files.
- Official [Godot pages](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html) often talk about GDScript by name; for syntax and most patterns, those pages are still relevant to Ruzta.
- For edge cases, prefer testing against the actual Ruzta runtime because language ports can move on a different release cadence than upstream Godot.
- If a guide mentions a GDScript builtin or annotation, assume it is conceptually relevant, then confirm the exact behavior in Ruzta when it matters.
- Ruzta uses compact range syntax (`start..end`, `start..=end`, `start..end:step`) instead of `range(start, end)` — steps and reverse direction are inferred from bounds.
- Postfix `value++` and `value--` are supported for compact mutation; GDScript requires `value += 1`.
- Annotation blocks can be scoped with `@annotation:` followed by an indented block, applying to every compatible declaration inside.
- Variadic functions use `...args: Array` syntax instead of GDScript's `args: Array = []`.

## What Ruzta adds

Beyond the shared [GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) model, Ruzta introduces several features that have no direct equivalent in GDScript. These are entirely new tools you can reach for when a pattern or architecture calls for them.

```ruzta_additions.rz
tuple Vec2(x: float, y: float)

trait Damageable:
	func take_damage(amount: int) -> void

@generic(T)
class Wrapper:
	var value: T

	func _init(v: T):
		value = v
```

- [Tuples](#topic-aggregate-types-tuple) define lightweight, fixed-size aggregate types with named or positional fields, destructuring, and match patterns — useful for small data carriers without a full class.
- [Generics](#section-generics) with `@generic(T)` let you write reusable classes and functions parameterized over types, backed by call-site inference and constraints.
- [Traits](#section-traits) (declared with `trait` and applied with `uses`) provide interface-plus-mixin capabilities that decouple shared behavior from inheritance.
- [Function overloading](#topic-functions-function-overloading) allows multiple definitions sharing one name when their parameter types differ, resolved by best signature fit.
- [Payload enums](#topic-enums-payload-enums-tagged-unions) act as tagged unions — each case can carry its own structured data while still being a single enum type.
- [Builder constructors](#topic-constructors-using-builder-constructor) (`TypeName { ... }`) let you construct and configure a node subtree inline with control flow and automatic `add_child()` calls.
- [`@feature` / `@feature_any`](#topic-annotations-feature-and-feature-any-for-gated-declarations-and-blocks) gate declarations and blocks behind platform or editor feature flags, stripped at runtime when inactive.
- Named argument calls use `fn(param: value)` or `fn(value, param=value)`.

## Ruzta - GDScript Interoperability

To use GDScript classes in a Ruzta script you will want to use
`load("<gdscript file path>")` syntax, same applies in GDScript.


```modify_style.rz

func change_error_btn_color():
	load("res://addons/gdss/gdss.gd").set_prop_override(error_toggle_btn, "font_color", Color.RED)

```
