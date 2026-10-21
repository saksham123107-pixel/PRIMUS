struct Params { vivid: f32, boost: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let sat = params.boost / 100.0;
    let saturated = saturation(c.rgb, sat);
    let curved = s_curve(saturated, 0.4);
    return vec4<f32>(curved, c.a);
}
