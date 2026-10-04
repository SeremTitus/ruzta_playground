# Constructors

Ruzta adds `builder constructor` for inline node tree construction with control flow and automatic `add_child()` calls.

## Instantiating with `new()`

```constructor_new.rz
class Projectile:
	var speed := 300.0

func test() -> void:
	var projectile := Projectile.new()
	var marker := Node2D.new()
	print(projectile.speed)
	marker.free()
```

- Call `TypeName.new()` for native engine classes such as `Node`, `Label`, or `Timer`, and `MyScript.new()` for script classes.

## Using builder constructor

Builder constructor constructs the instance first, then runs a builder body inside `{ ... }` for setup, control flow, and optional nested child builders.

```builder_constructor.rz
func make_pause_menu(show_debug: bool, entries: Array[String]) -> VBoxContainer:
	return VBoxContainer {
		name = "PauseMenu"
		alignment = BoxContainer.ALIGNMENT_CENTER

		if show_debug:
			name = "PauseMenuDebug"
		else:
			name = "PauseMenuRelease"

		while get_child_count() < entries.size():
			if get_child_count() >= 4:
				break
			Button {
				text = entries[get_child_count()]
			}

		for label in ["Paused", "", "Resume"]:
			if label == "":
				continue
			Button {
				text = label
			}
	}
```

- Use `TypePath { ... }` when the target can be constructed without arguments.
- Use `TypePath(arg1, arg2) { ... }` when `_init()` needs constructor arguments before the builder body runs.
- Builder bodies support receiver-relative assignments/calls, nested builders, and control flow (`if` / `for` / `while`, including `break` and `continue`).
- Inside builder control expressions, bare names resolve receiver-first; if no receiver member matches, normal scope/global lookup is used.
- `await` and `return` are not allowed inside builder constructors.
- The closing `}` only needs to appear as the next structural terminator; it does not need to align with prior indentation.
- Nested builder_constructor children call `add_child(child)` automatically when the current receiver exposes a compatible `add_child()` parameter.


## Releasing objects with `free()`

When you manually construct engine objects and they are not being kept alive by scene ownership or reference counting, release them explicitly with `free()`.

```object_free.rz
func test() -> void:
	var node := Node.new()
	node.name = "Temporary"
	node.free()
```

- Use `free()` on objects such as `Node` instances you created yourself and no longer need.
- Do not keep using an object after calling `free()` on it; the instance is gone immediately.
- Ref-counted types usually die when references disappear, but `Object` and scene objects often need explicit lifetime handling.