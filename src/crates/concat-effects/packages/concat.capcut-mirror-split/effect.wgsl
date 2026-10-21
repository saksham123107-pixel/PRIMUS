struct Params { mode: f32, zoom: f32 }

// Symmetrical reflection and quad-split layout
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let z = max(params.zoom / 100.0, 0.1);
    var p = (uv - vec2<f32>(0.5)) / z + vec2<f32>(0.5);

    let mode_i = i32(round(params.mode));
    if (mode_i == 1) {
        // Horizontal mirror (left reflects to right)
        p.x = abs(p.x - 0.5) * 2.0;
    } else if (mode_i == 2) {
        // Vertical mirror (top reflects to bottom)
        p.y = abs(p.y - 0.5) * 2.0;
    } else {
        // Quad 4-quadrant reflection
        p.x = abs(p.x - 0.5) * 2.0;
        p.y = abs(p.y - 0.5) * 2.0;
    }

    p = clamp(p, vec2<f32>(0.0), vec2<f32>(1.0));
    return sample(p);
}
