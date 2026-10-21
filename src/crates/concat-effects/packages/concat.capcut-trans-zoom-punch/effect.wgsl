struct Params { punch: f32 }

fn zoom_uv(uv: vec2<f32>, amount: f32) -> vec2<f32> {
    return (uv - vec2<f32>(0.5)) / max(amount, 0.0001) + vec2<f32>(0.5);
}

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let p = smoothstep(0.0, 1.0, clamp(progress, 0.0, 1.0));
    let amount = 1.0 + (params.punch / 100.0) * 1.2;
    // incoming starts over-zoomed (amount) and settles to 1.0; outgoing holds
    let in_scale = mix(amount, 1.0, p);
    let a = from_at(uv);
    let b = to_at(zoom_uv(uv, in_scale));
    return mix(a, b, p);
}
