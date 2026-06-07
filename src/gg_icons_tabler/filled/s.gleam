//// Tabler · filled · shard "s". GENERATED. Upstream: tabler/tabler-icons
//// (MIT). Do not hand-edit.

import gg_icon/icon
import gg_icons_tabler/internal
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/svg

/// `star` (filled) — a solid glyph, so it exercises `filled_defaults`
/// (`fill=currentColor`, no stroke) rather than the outline paint model.
pub fn star(attrs: List(Attribute(msg))) -> Element(msg) {
  icon.svg(
    view_box: internal.view_box,
    defaults: internal.filled_defaults,
    attrs: attrs,
    children: [
      svg.path([
        attribute.attribute(
          "d",
          "M12 17.27 18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z",
        ),
      ]),
    ],
  )
}
