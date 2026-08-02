# Traits

Traits provide interface-plus-mixin capabilities. Declare with `trait`, apply with `uses`. Traits can have required methods, default implementations, and support `is`/`as` checks.

## Declaring traits

A trait can declare required methods like an interface, include implemented members like a mixin, or do both in one place.

```declaring_traits.rz
trait Damageable:
	signal damaged(amount: int)
	const HIT_FLASH_TIME := 0.08

	func apply_damage(amount: int) -> void

	func report_damage(amount: int) -> void:
		damaged.emit(amount)
```

- Declare a local trait with `trait Name:` inside a script, or make a top-level global trait with `trait_name Name`.
- A trait may declare constants, variables, signals, enums, and functions.
- Leave a function body off to make that function a required contract for every class that uses the trait.
- Write a normal function body when the trait should provide default behavior that gets copied into the using class.

## Using traits in classes

Use `uses TraitName` inside a class to pull the trait into that class. Implemented members become part of the class scope, and bodyless functions become requirements the class must satisfy.

```using_traits.rz
trait Interactable:
	signal interacted(by: Node)
	func interact(by: Node) -> void

	func announce(by: Node) -> void:
		interacted.emit(by)

class Door extends Node:
	uses Interactable

	func interact(by: Node) -> void:
		announce(by)
		print("Door opened by ", by.name)
```

- Write `uses TraitName` near the top of the class body.
- If the trait declares a bodyless function signature, the class must implement that exact signature.
- If the trait defines fields, constants, signals, or helper methods, those members are added to the using class.
- A trait can also declare an `extends` requirement so only classes with a compatible base type may use it.
- A class can add extra overloads with the same function name as long as required trait signatures are still present.

## Overriding trait behavior

A class may override an implemented trait function to customize behavior, but the override still has to honor the trait's declared shape. This gives you default behavior without losing per-class specialization.

```trait_overrides.rz
trait Highlightable:
	func outline_color() -> Color:
		return Color.YELLOW

class Chest:
	uses Highlightable

	func outline_color() -> Color:
		return Color.ORANGE_RED

func debug_color(target: Chest) -> void:
	print(target.outline_color())
```

## Testing and casting with traits

Traits participate in `is` checks and `as` casts, so code can check what an object supports instead of forcing one concrete type.

```trait_test_cast.rz
trait Lootable:
	func collect() -> void

func try_collect(target: Variant) -> void:
	if target is Lootable:
		var lootable = target as Lootable
		lootable.collect()
	else:
		print("Nothing to collect")
```

- Use `value is TraitName` when you need a boolean capability test.
- Use `value as TraitName` when you want the matching typed value or `null` on failure.
- The runtime validates trait membership against the script attached to the object, not just the native Godot class.
- Prefer checking a trait when several unrelated classes can answer the same behavior contract.

## Trait-typed variables, collections, and APIs

Traits can be used anywhere you would normally use a type annotation: variables, parameters, returns, signals, arrays, and dictionaries.

```trait_typed_apis.rz
trait Command:
	func run() -> void

signal queued(command: Command)

var current: Command
var history: Array[Command] = []
var named: Dictionary[String, Command] = {}

func submit(command: Command) -> Command:
	queued.emit(command)
	history.append(command)
	named["last"] = command
	current = command
	return command
```

- Annotate variables as `var actor: Moveable` when any compatible implementation is acceptable.
- Use `Array[TraitName]` and `Dictionary[String, TraitName]` for typed containers of capabilities.
- Signals, parameters, and return types can all name a trait directly.
- Container checks validate each stored element against the trait, not just the array or dictionary shell.
- This is the main way to keep plugin-style or component-style gameplay code typed without introducing a deep inheritance tree.

### References

- [PHP Traits](https://www.php.net/manual/en/language.oop5.traits.php) :: Traits in PHP, a similar mixin mechanism
