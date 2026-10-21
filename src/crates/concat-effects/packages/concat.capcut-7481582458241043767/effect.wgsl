struct Params { amount: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
let p = smoothstep(0.0,1.0,clamp(progress,0.0,1.0));
    let edge = p * 1.2 - 0.1;
    let m = smoothstep(uv.x - 0.1, uv.x + 0.1, edge);
    return mix(from_at(uv), to_at(uv), m);
}
