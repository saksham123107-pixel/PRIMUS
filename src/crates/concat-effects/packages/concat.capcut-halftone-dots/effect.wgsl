struct Params { dots: f32, contrast: f32 }

// Pop-art comic halftone screen rasterization
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let cell_size = max(params.dots / 100.0 * 20.0, 4.0);
    let cont = params.contrast / 100.0;

    let pixel_pos = uv * frame.size;
    let cell_center = (floor(pixel_pos / cell_size) + vec2<f32>(0.5)) * cell_size;
    let sampled_color = sample(cell_center / frame.size);

    var lum = luma(sampled_color.rgb);
    lum = clamp((lum - 0.5) * cont + 0.5, 0.0, 1.0);

    let d = length(pixel_pos - cell_center);
    let max_radius = cell_size * 0.7071;
    let dot_radius = (1.0 - lum) * max_radius;

    let dot_mask = step(dot_radius, d);
    let out = mix(sampled_color.rgb, vec3<f32>(1.0), dot_mask);
    return vec4<f32>(out, c.a);
}
