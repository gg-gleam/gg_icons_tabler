//// Tabler · outline · shard "c". GENERATED. Upstream: tabler/tabler-icons
//// (MIT). Do not hand-edit.

import gg_icon/icon
import gg_icons_tabler/internal
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/svg

/// `chevron-down` (outline)
pub fn chevron_down(attrs: List(Attribute(msg))) -> Element(msg) {
  icon.svg(
    view_box: internal.view_box,
    defaults: internal.outline_defaults,
    attrs: attrs,
    children: [svg.path([attribute.attribute("d", "M6 9l6 6l6 -6")])],
  )
}
