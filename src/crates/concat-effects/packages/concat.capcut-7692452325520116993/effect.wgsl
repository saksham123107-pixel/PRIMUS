struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let l = luma(c.rgb);
    let sep = vec3<f32>(l*1.2, l*0.95, l*0.65);
    return vec4<f32>(mix(c.rgb, sep, params.amount), c.a);
}
