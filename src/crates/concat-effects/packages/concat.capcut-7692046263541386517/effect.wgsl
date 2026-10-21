struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let a = params.amount;
    let g = (c.rgb - vec3<f32>(0.5)) * (1.0 + a) + vec3<f32>(0.5);
    return vec4<f32>(clamp(g, vec3<f32>(0.0), vec3<f32>(1.0)), c.a);
}
