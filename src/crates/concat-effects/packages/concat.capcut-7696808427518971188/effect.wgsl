struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let l = luma(c.rgb);
    return vec4<f32>(mix(c.rgb, vec3<f32>(l), params.amount), c.a);
}
