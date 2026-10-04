# Configuration

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