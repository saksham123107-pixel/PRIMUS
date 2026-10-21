struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let a = params.amount;
    var out = c.rgb * (1.0 - 0.18*a) + vec3<f32>(0.06*a);
    let l = luma(out);
    out = mix(out, vec3<f32>(l), 0.2*a);
    return vec4<f32>(out, c.a);
}
