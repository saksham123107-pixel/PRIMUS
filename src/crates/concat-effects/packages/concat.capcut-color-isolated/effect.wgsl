struct Params { target_hue: f32, range: f32 }

// Retain target hue range and desaturate remaining pixels
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let lum = luma(c.rgb);
    let grey = vec3<f32>(lum);

    // RGB to Hue
    let mx = max(max(c.r, c.g), c.b);
    let mn = min(min(c.r, c.g), c.b);
    let delta = mx - mn;

    var h = 0.0;
    if (delta > 0.01) {
        if (mx == c.r) {
            h = (c.g - c.b) / delta;
        } else if (mx == c.g) {
            h = 2.0 + (c.b - c.r) / delta;
        } else {
            h = 4.0 + (c.r - c.g) / delta;
        }
        h = fract(h / 6.0) * 360.0;
    }

    // Distance to target hue on circular ring
    let diff = abs(h - params.target_hue);
    let hue_dist = min(diff, 360.0 - diff);
    let keep_mask = 1.0 - smoothstep(params.range * 0.7, params.range, hue_dist);

    let out = mix(grey, c.rgb, keep_mask);
    return vec4<f32>(out, c.a);
}
