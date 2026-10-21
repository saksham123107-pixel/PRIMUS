struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let t = params.amount * 0.03;
    var s = sample(uv) * 0.25;
    s += sample(uv + vec2<f32>(t, 0.0)) * 0.1875;
    s += sample(uv - vec2<f32>(t, 0.0)) * 0.1875;
    s += sample(uv + vec2<f32>(0.0, t)) * 0.1875;
    s += sample(uv - vec2<f32>(0.0, t)) * 0.1875;
    return s;
}
