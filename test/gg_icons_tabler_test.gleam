import gg_icons_tabler/filled/s as filled_s
import gg_icons_tabler/outline/c as outline_c
import gleam/string
import gleeunit
import gleeunit/should
import lustre/element

pub fn main() {
  gleeunit.main()
}

pub fn outline_variant_is_stroked_test() {
  let html = element.to_string(outline_c.chevron_down([]))

  should.be_true(string.contains(html, "stroke=\"currentColor\""))
  should.be_true(string.contains(html, "fill=\"none\""))
  should.be_true(string.contains(html, "M6 9l6 6l6 -6"))
}

pub fn filled_variant_is_solid_test() {
  let html = element.to_string(filled_s.star([]))

  // The filled paint model: a solid fill, no stroke default.
  should.be_true(string.contains(html, "fill=\"currentColor\""))
  should.be_false(string.contains(html, "stroke=\"currentColor\""))
}
