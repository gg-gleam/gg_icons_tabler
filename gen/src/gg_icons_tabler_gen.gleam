//// Dev-only generator for gg_icons_tabler. Run from this `gen/` project:
////
////     cd gen && gleam run
////
//// Reads the pinned upstream SVGs under `vendor/tabler/`, bakes them through the
//// shared `gg_icon_gen` engine, and writes the sharded modules + `internal.gleam`
//// into `../src/gg_icons_tabler`, plus `../icons.json`. Never shipped.
////
//// Tabler ships two variants: `outline` (stroked, the default) and `filled`
//// (solid glyph). Both are 24×24. Outline SVGs (and some filled ones) open with
//// a transparent bounding rect — `M0 0h24v24H0z` with `fill="none"` — that the
//// `clean` hook strips so it never lands in the baked output.

import gg_icon_gen.{type Config, Config, Variant}
import gg_icon_gen/svg
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  case gg_icon_gen.generate(config()) {
    Ok(_) -> io.println("✓ generated gg_icons_tabler")
    Error(e) -> io.println("✗ " <> string.inspect(e))
  }
}

fn config() -> Config {
  Config(
    set: "tabler",
    module_prefix: "gg_icons_tabler",
    out_src: "../src/gg_icons_tabler",
    out_manifest: "../icons.json",
    variants: [
      // outline — the default variant: a stroked glyph, 2px round caps.
      Variant(
        name: "outline",
        is_default: True,
        view_box: "0 0 24 24",
        defaults: [
          #("fill", "none"),
          #("stroke", "currentColor"),
          #("stroke-width", "2"),
          #("stroke-linecap", "round"),
          #("stroke-linejoin", "round"),
        ],
        source_dir: "vendor/tabler/outline",
      ),
      // filled — a solid glyph, no stroke.
      Variant(
        name: "filled",
        is_default: False,
        view_box: "0 0 24 24",
        defaults: [#("fill", "currentColor")],
        source_dir: "vendor/tabler/filled",
      ),
    ],
    // Drop Tabler's transparent bounding rect: a top-level path whose `d` is
    // exactly `M0 0h24v24H0z`. Safe for both variants.
    clean: drop_bounding_rect,
  )
}

const bounding_rect_d = "M0 0h24v24H0z"

fn drop_bounding_rect(nodes: List(svg.Node)) -> List(svg.Node) {
  list.filter(nodes, fn(node) { !is_bounding_rect(node) })
}

fn is_bounding_rect(node: svg.Node) -> Bool {
  case node {
    svg.Element(tag: "path", attrs: attrs, ..) ->
      list.any(attrs, fn(pair) { pair.0 == "d" && pair.1 == bounding_rect_d })
    _ -> False
  }
}
