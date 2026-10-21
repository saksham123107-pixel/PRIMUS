struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let n = max(4.0, 128.0 - params.amount * 120.0);
    let cell = floor(uv * n) / n + vec2<f32>(0.5) / n;
    return sample(cell);
}
