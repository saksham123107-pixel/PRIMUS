struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let levels = max(2.0, 24.0 - params.amount * 22.0);
    let q = floor(c.rgb * levels) / levels;
    return vec4<f32>(q, c.a);
}
