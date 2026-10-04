# Ruzta Configuration

Ruzta provides settings under `ruzta/` in Project Settings.

## Color Theme

The `ruzta/theme/color_theme` setting selects between dark and light palettes. It is an enum with two values:

| Value | Description |
|-------|-------------|
| `Dark` | Dark background palette (default) |
| `Light` | Light background palette |

When you change this setting, all `ruzta/theme/highlighting/...` colors update to the corresponding preset. The editor also detects the Godot editor theme (`text_editor/theme/highlighting/background_color`) and syncs `ruzta/theme/color_theme` automatically.

### Highlighting Colors

Each color can be overridden individually in Project Settings. The full list of settings under `ruzta/theme/highlighting/`:

| Setting | Controls |
|---------|----------|
| `text_color` | Default text color |
| `engine_type_color` | Godot engine class names (`Node`, `Sprite2D`, etc.) |
| `user_type_color` | User-defined class names |
| `base_type_color` | Primitive types (`int`, `float`, `bool`, `void`, `Variant`) |
| `trait_type_color` | Trait names |
| `tuple_type_color` | Tuple type names |
| `enum_type_color` | Enum type names |
| `generics_type_color` | Generic type parameters |
| `namespace_type_color` | Namespace prefixes in qualified names |
| `keyword_color` | Language keywords (`func`, `var`, `if`, etc.) |
| `control_flow_keyword_color` | Control flow keywords (`return`, `break`, `continue`, etc.) |
| `string_color` | String literals |
| `comment_color` | Single-line and block comments |
| `doc_comment_color` | Documentation comments (`##`) |
| `function_color` | Function calls |
| `function_definition_color` | Function definitions |
| `global_function_color` | Global/builtin function calls |
| `member_color` | Member variable access |
| `symbol_color` | Operators and punctuation |
| `number_color` | Numeric literals |
| `annotation_color` | Annotations (`@export`, `@tool`, etc.) |
| `string_placeholder_color` | String placeholders (`%s`, `{name}`) |

## Keywords

Settings under `ruzta/keywords/reword/` let a project reword keywords. Each keyword has its own String setting holding a comma separated list of rewordings that all mean the same thing.

```gdscript
# With ruzta/keywords/reword/uses = "impl,implements"
trait Action:
	func act() -> void:
		pass

trait Damageable:
	func take_damage() -> void:
		pass

class Player extends RefCounted:
	impl Action          # Same as `uses Action`, but `uses` is no longer a keyword.
	implements Damageable

func test() -> void:
	var player = Player.new()
	player.act()
```

- The list **replaces** the default rather than extending it. `uses` stops working as soon as you set `ruzta/keywords/reword/uses`.
- Keep the default by listing it: `ruzta/keywords/reword/uses = "uses, impl,implements"` accepts all three.
- The value is used as written, so it may use any case. Matching is case sensitive and must be an exact match of the whole word, meaning `IMPL` and `Impl` are different keywords and neither matches `impl`.
- Editor highlighting and code completion follow the configured rewordings automatically.
- Changes apply immediately; already loaded scripts are recompiled.
- `true`, `false` and `null` are literals rather than keywords and cannot be reworded.
- Length is 2 to 32 characters per word.

### Keyword Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `ruzta/keywords/reword/break` | `break` | Exit a loop or a `match`. |
| `ruzta/keywords/reword/continue` | `continue` | Skip to the next loop iteration. |
| `ruzta/keywords/reword/elif` | `elif` | `else if` branch. |
| `ruzta/keywords/reword/else` | `else` | Fallback branch. |
| `ruzta/keywords/reword/for` | `for` | Loop. |
| `ruzta/keywords/reword/if` | `if` | Conditional. |
| `ruzta/keywords/reword/match` | `match` | Pattern matching. |
| `ruzta/keywords/reword/pass` | `pass` | No-op statement. |
| `ruzta/keywords/reword/return` | `return` | Return from a function. |
| `ruzta/keywords/reword/when` | `when` | Pattern guard inside `match`. |
| `ruzta/keywords/reword/while` | `while` | Loop. |
| `ruzta/keywords/reword/class` | `class` | Inner class declaration. |
| `ruzta/keywords/reword/class_name` | `class_name` | Register a global class. |
| `ruzta/keywords/reword/const` | `const` | Constant declaration. |
| `ruzta/keywords/reword/enum` | `enum` | Enum declaration. |
| `ruzta/keywords/reword/extends` | `extends` | Base class. |
| `ruzta/keywords/reword/func` | `func` | Function declaration. |
| `ruzta/keywords/reword/namespace` | `namespace` | Namespace declaration. |
| `ruzta/keywords/reword/signal` | `signal` | Signal declaration. |
| `ruzta/keywords/reword/static` | `static` | Static member. |
| `ruzta/keywords/reword/trait` | `trait` | Trait declaration. |
| `ruzta/keywords/reword/trait_name` | `trait_name` | Register a global trait. |
| `ruzta/keywords/reword/tuple` | `tuple` | Tuple type. |
| `ruzta/keywords/reword/uses` | `uses` | Make class apply trait. |
| `ruzta/keywords/reword/using` | `using` | Bring a namespace into scope. |
| `ruzta/keywords/reword/var` | `var` | Variable declaration. |
| `ruzta/keywords/reword/await` | `await` | Await a signal or coroutine. |
| `ruzta/keywords/reword/breakpoint` | `breakpoint` | Editor breakpoint. |
| `ruzta/keywords/reword/self` | `self` | Current instance. |
| `ruzta/keywords/reword/super` | `super` | Base class implementation. |
| `ruzta/keywords/reword/yield` | `yield` | Reserved for potential future use. |
| `ruzta/keywords/reword/and` | `and` | Logical and. |
| `ruzta/keywords/reword/as` | `as` | Type cast. |
| `ruzta/keywords/reword/in` | `in` | Membership test. |
| `ruzta/keywords/reword/is` | `is` | Type check. |
| `ruzta/keywords/reword/not` | `not` | Logical not. |
| `ruzta/keywords/reword/or` | `or` | Logical or. |
| `ruzta/keywords/reword/inf` | `INF` | Infinity constant. |
| `ruzta/keywords/reword/nan` | `NAN` | Not-a-number constant. |
| `ruzta/keywords/reword/pi` | `PI` | Pi constant. |
| `ruzta/keywords/reword/tau` | `TAU` | Tau constant. |
| `ruzta/keywords/reword/assert` | `assert` | Assert a condition. |
| `ruzta/keywords/reword/preload` | `preload` | Load a resource at parse time. |
| `ruzta/keywords/reword/void` | `void` | No return type. |

The four constants keep their uppercase default. Setting names are always lowercase, but values are used exactly as written; nothing you type is lowercased.

## Debug Settings

Settings under `ruzta/debug/settings/` control runtime debugging behavior.

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `ruzta/debug/settings/max_call_stack` | int | `1024` | Maximum call stack depth (range: 512 to `MAX_CALL_DEPTH - 1`). |
| `ruzta/debug/settings/always_track_call_stacks` | bool | `false` | Always record the call stack, even when the debugger is not attached. |
| `ruzta/debug/settings/always_track_local_variables` | bool | `false` | Always record local variable names. Enabled automatically when the debugger is attached. |

## Warnings

Settings under `ruzta/debug/warnings/` control the static analysis warning system.

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `ruzta/debug/warnings/enable` | bool | `true` | Master switch for all Ruzta warnings. |
| `ruzta/debug/warnings/directory_rules` | Dictionary | `{"res://addons": Exclude}` | Per-directory warning rules. Keys are directory paths (`res://`-prefixed), values are `Exclude` (0) or `Include` (1). Deepest matching rule wins. |

### Individual Warning Levels

Each warning can be set to one of three levels:

| Value | Behavior |
|-------|----------|
| `Ignore` | Warning is suppressed. |
| `Warn` | Warning is emitted as a non-fatal message. |
| `Error` | Warning is emitted as a compile-time error. |

All individual warning settings live under `ruzta/debug/warnings/<name>`:

| Setting | Default | Description |
|---------|---------|-------------|
| `ruzta/debug/warnings/unassigned_variable` | Warn | Variable used but never assigned. |
| `ruzta/debug/warnings/unassigned_variable_op_assign` | Warn | Variable never assigned but used in `+=`, `*=`, etc. |
| `ruzta/debug/warnings/unused_variable` | Warn | Local variable declared but never used. |
| `ruzta/debug/warnings/unused_local_constant` | Warn | Local constant declared but never used. |
| `ruzta/debug/warnings/unused_private_class_variable` | Warn | Class variable with `_` prefix never used in the class. |
| `ruzta/debug/warnings/unused_parameter` | Warn | Function parameter never used. |
| `ruzta/debug/warnings/unused_signal` | Warn | Signal defined but never connected/emitted in the class. |
| `ruzta/debug/warnings/shadowed_variable` | Warn | Local variable shadows a class member. |
| `ruzta/debug/warnings/shadowed_variable_base_class` | Warn | Local variable shadows a base class member. |
| `ruzta/debug/warnings/shadowed_global_identifier` | Warn | Variable has the same name as a global class or function. |
| `ruzta/debug/warnings/unreachable_code` | Warn | Code after a `return` statement. |
| `ruzta/debug/warnings/unreachable_pattern` | Warn | Match pattern after a catch-all pattern. |
| `ruzta/debug/warnings/standalone_expression` | Warn | Expression result not assigned to a variable. |
| `ruzta/debug/warnings/standalone_ternary` | Warn | Ternary expression result is discarded. |
| `ruzta/debug/warnings/incompatible_ternary` | Warn | Ternary branches return incompatible types. |
| `ruzta/debug/warnings/untyped_declaration` | Warn | No static type specified or inferred. |
| `ruzta/debug/warnings/inferred_declaration` | Warn | Type is implicitly inferred rather than explicitly specified. |
| `ruzta/debug/warnings/unsafe_property_access` | Warn | Property not found in detected type (may exist in subtypes). |
| `ruzta/debug/warnings/unsafe_method_access` | Warn | Method not found in detected type (may exist in subtypes). |
| `ruzta/debug/warnings/unsafe_cast` | Warn | Casting a `Variant` to a non-`Variant` type. |
| `ruzta/debug/warnings/unsafe_call_argument` | Warn | Argument type is a supertype of the required type. |
| `ruzta/debug/warnings/unsafe_void_return` | Warn | Returning a call to a function whose return type cannot be checked. |
| `ruzta/debug/warnings/return_value_discarded` | Warn | Function return value is not used. |
| `ruzta/debug/warnings/static_called_on_instance` | Warn | Static method called on an instance instead of on the class. |
| `ruzta/debug/warnings/missing_tool` | Warn | Base class has `@tool` but this script does not. |
| `ruzta/debug/warnings/redundant_static_unload` | Warn | `@static_unload` used but class has no static data. |
| `ruzta/debug/warnings/redundant_await` | Warn | `await` used on a synchronous expression. |
| `ruzta/debug/warnings/missing_await` | Warn | `await` not used but expression is a coroutine. |
| `ruzta/debug/warnings/assert_always_true` | Warn | `assert()` argument is always true. |
| `ruzta/debug/warnings/assert_always_false` | Warn | `assert()` argument is always false. |
| `ruzta/debug/warnings/integer_division` | Warn | Integer division discards the decimal part. |
| `ruzta/debug/warnings/narrowing_conversion` | Warn | Float value assigned to an integer slot. |
| `ruzta/debug/warnings/int_as_enum_without_cast` | Warn | Integer used as enum without explicit cast. |
| `ruzta/debug/warnings/int_as_enum_without_match` | Warn | Integer used as enum without matching a member. |
| `ruzta/debug/warnings/enum_variable_without_default` | Warn | Enum-typed variable has no default value. |
| `ruzta/debug/warnings/empty_file` | Warn | Script file is empty. |
| `ruzta/debug/warnings/deprecated_keyword` | Warn | Deprecated keyword in use. |
| `ruzta/debug/warnings/confusable_identifier` | Warn | Identifier contains visually misleading characters (e.g. Cyrillic "e" vs Latin "e"). |
| `ruzta/debug/warnings/confusable_local_declaration` | Warn | Parent block declares an identifier with the same name below. |
| `ruzta/debug/warnings/confusable_local_usage` | Warn | Identifier will be shadowed later in the block. |
| `ruzta/debug/warnings/confusable_capture_reassignment` | Warn | Reassigning a lambda capture does not modify the outer variable. |
| `ruzta/debug/warnings/confusable_temporary_modification` | Warn | Modifying a temporary value in a complex expression. |
| `ruzta/debug/warnings/inference_on_variant` | Warn | Type inference on a `Variant`-typed value. |
| `ruzta/debug/warnings/native_method_override` | Warn | Script method overrides a native method. |
| `ruzta/debug/warnings/get_node_default_without_onready` | Warn | `get_node()` / `$` used as default without `@onready`. |
| `ruzta/debug/warnings/onready_with_export` | Warn | `@onready` sets value after `@export`, likely unintended. |
| `ruzta/debug/warnings/property_used_as_function` | Warn | Function not found; a property with the same name exists. (Deprecated) |
| `ruzta/debug/warnings/constant_used_as_function` | Warn | Function not found; a constant with the same name exists. (Deprecated) |
| `ruzta/debug/warnings/function_used_as_property` | Warn | Property not found; a function with the same name exists. (Deprecated) |
| `ruzta/debug/warnings/non_exhaustive_match` | Warn | Match on an enum type does not cover all cases. |
| `ruzta/debug/warnings/unsafe_signal_connection` | Warn | Signal connection callable parameter is a subtype of the signal type. |
| `ruzta/debug/warnings/signal_connect_argument_count_mismatch` | Warn | Signal connection argument count doesn't match callable signature. |
| `ruzta/debug/warnings/signal_connect_argument_type_mismatch` | Warn | Signal connection argument type doesn't match callable signature. |
| `ruzta/debug/warnings/signal_emit_argument_count_mismatch` | Warn | Signal emit argument count doesn't match signal signature. |
| `ruzta/debug/warnings/signal_emit_argument_type_mismatch` | Warn | Signal emit argument type doesn't match signal signature. |
