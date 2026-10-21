struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let d = distance(uv, vec2<f32>(0.5));
    let dark = smoothstep(0.35, 0.85, d) * params.amount;
    return vec4<f32>(c.rgb * (1.0 - dark), c.a);
}
