struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let w = vec2<f32>(sin(uv.y * 40.0 + frame.time * 3.0), cos(uv.x * 36.0 + frame.time * 2.0)) * params.amount * 0.02;
    return sample(uv + w);
}
