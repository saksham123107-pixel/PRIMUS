struct Params { purple_amt: f32, saturation_boost: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let p = params.purple_amt / 100.0;
    let sat = params.saturation_boost / 100.0;

    let uv_tint = vec3<f32>(0.65, 0.1, 0.95);
    let out = mix(c.rgb, c.rgb * uv_tint * 1.5, p * 0.6);
    return vec4<f32>(saturation(out, sat), c.a);
}
