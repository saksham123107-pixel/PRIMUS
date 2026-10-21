struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let a = params.amount;
    // lift the shadows and compress the range: out = c*(1-k) + lift
    let contrast = 1.0 - 0.18 * a;
    let lift = 0.06 * a;
    var out = c.rgb * contrast + vec3<f32>(lift);
    // ease saturation a touch as it fades
    let l = luma(out);
    out = mix(out, vec3<f32>(l), 0.2 * a);
    return vec4<f32>(out, c.a);
}
