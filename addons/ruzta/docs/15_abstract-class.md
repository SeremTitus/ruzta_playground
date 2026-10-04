# Abstract Class

Use `@abstract` to mark classes that define contracts but cannot be instantiated. Abstract methods (`@abstract func`) require subclass implementation.

## Declaring abstract classes

```abstract_class.rz
@abstract class Ability:
	@abstract func activate(target: Node) -> void

	func describe() -> String:
		return "Shared ability contract"

class Fireball extends Ability:
	func activate(target: Node) -> void:
		print("Fireball hits ", target.name)

func cast(target: Node) -> void:
	var spell := Fireball.new()
	spell.activate(target)
```

- Write `@abstract class Name:` to mark a class as non-instantiable.
- Abstract classes can still hold implemented helper methods, shared state, and inherited base types.
- Calling `.new()` or using a builder constructor on an abstract class is rejected by the analyzer.
- Use abstract bases when several concrete classes need to share one typed interface.

## Defining abstract methods

Use `@abstract func` to declare required method signatures without a body. Subclasses must implement them, or remain abstract too.

```abstract_methods.rz
@abstract class Enemy:
	@abstract func attack(target: Node) -> void

@abstract class Boss extends Enemy:
	func taunt() -> void:
		print("You cannot win.")

class SlimeBoss extends Boss:
	func attack(target: Node) -> void:
		print("Slime bash -> ", target.name)
```

- Declare an abstract method as `@abstract func name(args) -> Type` and leave off the body.
- If a class still contains unimplemented abstract methods, that class must also be marked `@abstract`.
- Abstract methods cannot be `static` and cannot define a function body.
- A subclass may inherit from another abstract class and become concrete only after implementing every required method.
