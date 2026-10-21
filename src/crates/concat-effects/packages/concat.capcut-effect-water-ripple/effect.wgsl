struct Params { ripple: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let r = params.ripple / 100.0 * 0.03;
    let t = frame.time * params.speed;

    let wave_x = sin(uv.y * 25.0 + t) * cos(uv.x * 20.0 - t * 0.8) * r;
    let wave_y = cos(uv.x * 30.0 + t * 1.2) * sin(uv.y * 18.0 + t * 0.5) * r;

    let p = clamp(uv + vec2<f32>(wave_x, wave_y), vec2<f32>(0.0), vec2<f32>(1.0));
    var c = sample(p);

    // Aqua blue underwater tint
    let aqua = c.rgb * vec3<f32>(0.85, 1.05, 1.15);
    return vec4<f32>(aqua, c.a);
}
