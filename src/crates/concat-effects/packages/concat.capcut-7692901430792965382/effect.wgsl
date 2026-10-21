struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let a = params.amount;
    return vec4<f32>(c.rgb * vec3<f32>(1.0 - 0.12*a, 1.0 + 0.02*a, 1.0 + 0.15*a), c.a);
}
