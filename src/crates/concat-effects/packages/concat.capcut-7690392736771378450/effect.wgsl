struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let a = params.amount;
    let l = luma(c.rgb);
    let tone = mix(vec3<f32>(0.85,0.45,0.15), vec3<f32>(0.0,0.5,0.6), smoothstep(0.25,0.75,l));
    return vec4<f32>(mix(c.rgb, c.rgb*0.7 + tone*0.3, a), c.a);
}
