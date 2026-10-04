# Class and Global

Use `class_name` for global identifiers, `extends` for inheritance, and autoload singletons for project-wide services.

## Unnamed scripts and `class_name`

Every `.rz` file defines a script class. Adding `class_name` gives the class a [global identifier](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) you can reference directly.

```classes.rz
class_name Projectile
extends Area2D

const EnemyScript = preload("res://enemy.rz")
func spawn_enemy() -> void:
	var enemy = EnemyScript.new()
	add_child(enemy)
```

- Use `class_name` when the script should be easy to instantiate or reference across the project.
- Unnamed scripts still work fine; load or preload them and instantiate them through the returned script resource.
- Use `extends` at the top level to bind the script to a native or script base class.

### References

- [First script tutorial](https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_first_script.html) :: Small end-to-end example in Godot

## Inner classes

A Ruzta script can also declare inner classes. They are useful when a helper type belongs tightly to one script and does not need its own global file or `class_name`.

```inner_class.rz
class Entry:
	var id: String
	var count: int

func make_entry(id: String, count: int) -> Entry:
	var entry := Entry.new()
	entry.id = id
	entry.count = count
	return entry
```

- Inner classes help keep small data carriers and helper objects local to the script that owns them.
- They can extend other classes and participate in typed code just like top-level classes.
- Use them when splitting files further would make the code harder, not easier, to navigate.

## Globals and singletons

[Autoload singletons](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html) are the usual Godot answer for project-wide services and state. Once registered in Project Settings, they are available by name from any Ruzta script.

```singletons.rz
func _ready() -> void:
	if SaveGame.has_profile():
		print(SaveGame.current_slot)
		SaveGame.mark_seen("intro")
```

- Use an autoload for save systems, settings, audio routers, quest state, or other cross-scene services.
- A singleton name behaves like a global entry point, but the underlying implementation is still just a script or node you own.