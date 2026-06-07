//// Internal — shared per-variant constants for the generated Tabler shards.
//// Tabler ships two variants: `outline` (stroke) and `filled` (solid). Both are
//// 24×24. Not part of the public surface.

/// Tabler's canvas. Both variants are 24×24.
pub const view_box = "0 0 24 24"

/// Baked onto every `outline` `<svg>`: a stroked glyph in the current text
/// colour.
pub const outline_defaults = [
  #("fill", "none"),
  #("stroke", "currentColor"),
  #("stroke-width", "2"),
  #("stroke-linecap", "round"),
  #("stroke-linejoin", "round"),
]

/// Baked onto every `filled` `<svg>`: a solid glyph in the current text colour,
/// no stroke. This is the line that makes `gg_icon.svg`'s `defaults` genericity
/// earn its keep — a different paint model from `outline`.
pub const filled_defaults = [#("fill", "currentColor")]
