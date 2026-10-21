struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    return vec4<f32>(vibrance(c.rgb, 1.0 + params.amount), c.a);
}
