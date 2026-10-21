struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let d = params.amount * 0.02;
    let r = sample(uv + vec2<f32>(d, 0.0)).r;
    let g = sample(uv).g;
    let b = sample(uv - vec2<f32>(d, 0.0)).b;
    let a = sample(uv).a;
    return vec4<f32>(r, g, b, a);
}
