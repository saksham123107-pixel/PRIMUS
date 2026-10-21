struct Params { warmth: f32, saturation_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let w = params.warmth / 100.0;
    let sat = params.saturation_val / 100.0;

    let golden = c.rgb * vec3<f32>(1.12, 1.02, 0.82);
    let graded = split_tone(golden, vec3<f32>(0.9, 0.5, 0.2), vec3<f32>(1.0, 0.85, 0.5), w * 0.4);
    let out = saturation(graded, sat);
    return vec4<f32>(out, c.a);
}
