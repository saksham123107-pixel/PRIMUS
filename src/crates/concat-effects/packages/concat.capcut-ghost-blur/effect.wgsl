struct Params { ghost: f32, speed: f32 }

// Expanding semi-transparent spirit layer that pulses outwards
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let ghost_amt = params.ghost / 100.0;
    let rate = max(params.speed, 0.5);

    // Expansion cycle from 1.0 to 1.35
    let phase = fract(frame.time * rate);
    let scale = 1.0 + phase * 0.25;
    let alpha = (1.0 - phase) * ghost_amt;

    let centre = vec2<f32>(0.5);
    let ghost_uv = centre + (uv - centre) / scale;

    var ghost_color = vec3<f32>(0.0);
    if (ghost_uv.x >= 0.0 && ghost_uv.x <= 1.0 && ghost_uv.y >= 0.0 && ghost_uv.y <= 1.0) {
        ghost_color = sample(ghost_uv).rgb;
    }

    let out = mix(c.rgb, ghost_color, alpha * 0.5);
    return vec4<f32>(out, c.a);
}
