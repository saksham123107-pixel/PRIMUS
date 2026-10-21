struct Params { amount: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
let p = smoothstep(0.0,1.0,clamp(progress,0.0,1.0));
    let amt = 1.0 + params.amount * (1.0 - p);
    let zuv = (uv - vec2<f32>(0.5)) / max(amt, 0.0001) + vec2<f32>(0.5);
    return mix(from_at(uv), to_at(zuv), p);
}
