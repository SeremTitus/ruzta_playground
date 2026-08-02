# Ruzta v1.0.0-Beta3

* Downgraded non-exhaustive enum matches from errors to warnings (not worth the squeeze).
* Added language documentation to the addon (`docs/*.md`).
* Added an extensible, simplified MCP server, shipping with one tool for Ruzta script validation.
* Improved syntax highlighting with distinct colors for user-defined classes, traits, tuples, enums, and generic types, making code easier to read and differentiate.
* Named arguments now support both `=` (Python-like: `foo(w = 3, h = 9)`) and `:` (Swift-like: `foo(w: 3, h: 9)`) syntax.
* Added a GDScript-to-Ruzta conversion tool.
* Improved builder constructor parsing.
* Website updates: versioned documentation and a new playground for testing Ruzta language scripts.
* Exposed `validate` and `complete_code` methods through the `RuztaLanguage` singleton class.
* Improved tuple stability.
* Fixed various bugs, including scoped annotations and null values incorrectly satisfying trait type checks.
