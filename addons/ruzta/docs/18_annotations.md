# Annotations

Annotations start with `@` and modify the next declaration. Common ones: `@export`, `@onready`, `@tool`. Ruzta adds scoped annotation blocks, `@feature`/`@feature_any` for platform gating, and `@warning_ignore`.

## Common annotations you will use first

```annotations.rz
@tool
extends Node2D

@export_group("Movement")
@export var speed := 240.0
@export var jump_force := 420.0

@onready var sprite = $Sprite2D
```

- Use `@export` to make a property editable in the Inspector.
- Use `@export_group`, `@export_subgroup`, or `@export_category` to keep Inspector-heavy scripts readable.
- Use `@onready` for node lookups or values that should initialize after the node enters the scene tree.
- Use `@tool` when a script should also run in the editor.



## Scoped annotation blocks

Some annotations can open an indented block with `:` and apply to every compatible declaration or statement inside. This is useful when several consecutive lines should share the same export, warning, or feature behavior.

```scoped_annotations.rz
extends Node

@export:
	var grouped_a := 1
	var grouped_b := 2

func test() -> void:
	@warning_ignore("unused_variable"):
		var cached = grouped_a
		print(cached)
```

- Put `:` after the annotation, then start the affected block on the next line.
- Use scoped blocks to avoid repeating the same annotation on several consecutive declarations.
- Class-level scoped blocks work well for grouped `@export` members, while statement-level blocks are useful for warnings or feature-gated code regions.
- Only annotations that support the target inside the block are applied; incompatible targets still raise normal errors.

## @feature and @feature_any for gated declarations and blocks

`@feature(...)` and `@feature_any(...)` are the annotation forms of `OS.has_feature(...)` checks. They can gate a single declaration or an entire scoped block: `@feature(...)` combines names with logical AND, while `@feature_any(...)` combines them with logical OR.

```feature_annotation.rz
@feature("windows")
var windows_only = "win"

@feature_any("web_android", "web_ios")
var mobile_web = true

func test() -> void:
	@feature("windows", "editor"):
		print(windows_only)

	@feature("editor")
	@feature_any("windows", "linux"):
		print("Editor helper for desktop platforms.")

	@feature("web"):
		print("Only present when the web feature exists.")
```

- Use string literals only: `@feature("windows")`, `@feature("windows", "editor")`, or `@feature_any("web_android", "web_ios")`.
- Apply either annotation directly to variables, constants, functions, classes, traits, enums, signals, statements, or to a scoped annotation block.
- Code can only use a gated declaration from the same or a stricter feature context, so an ungated access to a gated variable is an analysis error.
- Inactive feature blocks are removed before runtime code generation; editor builds still analyze them so mistakes inside false blocks are caught early.

### References

- [OS.has_feature](https://docs.godotengine.org/en/stable/classes/class_os.html#class-os-method-has-feature) :: Feature tags exposed by the current editor or export target

## Warnings and advanced annotations

Ruzta also supports annotations that affect warnings or class behavior. These are useful once you are tuning editor feedback or expressing more specialized intent.

```warning_ignore.rz
@warning_ignore("unused_parameter")
func _process(_delta: float) -> void:
	pass
```

- Use `@warning_ignore(...)` when a specific warning is noisy and you are intentionally keeping the code as written.
- Use warning ignores narrowly; they should document a conscious exception, not hide sloppy code.
- Other annotations such as `@abstract` or `@static_unload` are more specialized and should be introduced only when their behavior is needed.
