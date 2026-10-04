# Namespaces

Declare a file under a `namespace` to prefix the global names it registers, and pull another namespace into scope with `using`. Namespaces keep same-named classes from different plugins apart and group related code under one prefix.

## Declaring a namespace

```namespace_declaration.rz
namespace Gameplay.Enemies

class_name Goblin
extends CharacterBody2D

const SPEED := 90.0

func patrol() -> void:
	print("goblin patrol")
```

- Write `namespace Name` at the top of the file, before `class_name`, `trait_name`, and `extends`. Leading annotations such as `@tool` may come before it but will only affect the class/trait.
- Dotted names nest, so `namespace Gameplay.Enemies` registers the class as `Gameplay.Enemies.Goblin`.
- Only one `namespace` per file.
- A namespace is a name prefix, not a type: `var g: Gameplay` is an error, and outside its namespace the class is reachable only as `Gameplay.Enemies.Goblin`.
- `namespace` and `using` are reserved keywords.

## Using a namespace

```using_namespace.rz
extends Node
using Gameplay
using Gameplay.Enemies, UI

func spawn() -> Gameplay.Player:
	var goblin := Goblin.new()
	goblin.patrol()
	var hud := HUD.new()
	hud.show()
	return Gameplay.Player.new()
```

- `using X` imports every name registered in namespace `X`, so its classes, traits, enums, and tuples become usable by their bare names.
- Accepts a nested path (`using Gameplay.Enemies`), several namespaces on one line separated by commas, and as many `using` lines as needed.
- Imports are class-scoped: a file-level `using` also applies to inner classes, and an inner class can declare its own `using`.
- Local variables and class members win over imported names, so an import never shadows something declared in the file.
- `using` always imports a whole namespace; there is no alias or single-symbol form yet.

## What a namespace exposes

```namespace_members.rz
namespace Gameplay.Data

enum Element {
	FIRE,
	WATER,
}

tuple Spawn(x: int, y: int)

class Stats:
	var health := 10

trait Damageable:
	func apply(amount: int) -> void
```

- A file with `class_name` or `trait_name` contributes that one name to its namespace; a file without one contributes its enums, tuples, and inner classes and traits.
- Top-level `var` and `func` belong to the file's class, not to the namespace, and are reached through the class.
- From other files, reach namespace members through their full path: `Gameplay.Data.Element.FIRE`, `Gameplay.Data.Spawn(1, 2)`, `Gameplay.Data.Stats.new()`.
- Enum and tuple names are valid values too, so `Gameplay.Data.Element` is the enum type rather than `null`.
- A file that declares `namespace X` can also use X's other entries by bare name, so files sharing a namespace see each other without an import.