struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let hi = smoothstep(0.55, 1.0, luma(c.rgb)) * params.amount;
    return vec4<f32>(c.rgb + vec3<f32>(hi), c.a);
}
