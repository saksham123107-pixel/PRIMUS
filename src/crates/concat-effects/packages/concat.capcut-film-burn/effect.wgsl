struct Params { burn: f32, speed: f32 }

// Organic moving amber light burn across frame edges
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let burn_amt = params.burn / 100.0;
    let spd = params.speed * 0.5;

    // Drifting burn blob using sines
    let t = frame.time * spd;
    let blob1 = sin(uv.x * 3.0 + t) * cos(uv.y * 2.0 - t * 0.8);
    let blob2 = sin(uv.y * 4.0 + t * 1.2) * cos(uv.x * 2.5 + t * 0.5);
    let leak = max(blob1 + blob2, 0.0) * burn_amt;

    // Amber-orange film burn tint
    let burn_color = vec3<f32>(1.0, 0.55, 0.15) * leak * 1.8;
    let out = screen(c.rgb, burn_color);
    return vec4<f32>(out, c.a);
}
