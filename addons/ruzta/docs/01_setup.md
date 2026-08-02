# Setup

Ruzta is a GDExtension for Godot. Download the archive or itch.io or godot asset store, extract it into your project, and attach `.rz` scripts to nodes just like GDScript.

## Download and enable Ruzta

Ruzta scripts live in `.rz` files, but the language itself is delivered as a [Godot GDExtension](https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/what_is_gdextension.html).

```hello_world.rz
extends Node

func _ready() -> void:
	print("Hello from Ruzta")
```

- Download the current [build archive](/downloads), then unzip it before opening the project in Godot.
- A Ruzta source file uses the `.rz` extension
- If Godot does not recognize the language immediately, reopen the project so the extension reloads cleanly.

### References

- [Downloads](/downloads) :: Grab the current archive from this site

## First `.rz` script

If you already know [Godot scenes](https://docs.godotengine.org/en/stable/getting_started/step_by_step/scenes.html), verify your setup works by attaching a `.rz` script to a node and printing from `_ready()`.

```player.rz
class_name Player
extends CharacterBody2D

@export var speed := 220.0

func _ready() -> void:
	print("Player ready")

func _process(delta: float) -> void:
	position.x += speed * delta
```

- Create a new script file with the `.rz` extension.
- Use `extends` exactly the way you would in GDScript.
- Attach the script to a node, run the scene, and check the output panel for the printed line.
- From there, add `@export` properties and callbacks such as `_process()` or `_input()` the same way you would in a regular Godot workflow.

### References

- [First script tutorial](https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_first_script.html) :: Small end-to-end example in Godot
- [GDScript basics](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) :: Core syntax, declarations, statements, and patterns

## Learn more

Ruzta is intentionally close to [GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html), so the quickest way to learn is to combine this site with the official Godot scripting references and a couple of practice-oriented guides.

- Keep this Ruzta guide open for the repo-specific differences: `.rz` files, language packaging, and how this port is positioned.
- If you want a guided path instead of a reference manual, start with [GDQuest's beginner material](https://school.gdquest.com/courses/learn_2d_gamedev_godot_4/learn_gdscript/learn_gdscript_app) and cross-check syntax here.

### References

- [Learn X in Y Minutes](https://learnxinyminutes.com/gdscript/) :: Fast syntax refresher
