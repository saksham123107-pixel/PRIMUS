struct Params { direction: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let p_smooth = smoothstep(0.0, 1.0, progress);
    let dir = select(1.0, -1.0, params.direction > 1.5);

    let from_uv = uv + vec2<f32>(dir * p_smooth, 0.0);
    let to_uv = uv - vec2<f32>(dir * (1.0 - p_smooth), 0.0);

    if (from_uv.x >= 0.0 && from_uv.x <= 1.0) {
        return from_at(from_uv);
    }
    return to_at(clamp(to_uv, vec2<f32>(0.0), vec2<f32>(1.0)));
}
