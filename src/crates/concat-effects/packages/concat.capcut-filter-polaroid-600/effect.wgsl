struct Params { polaroid: f32, fade_amt: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let p = params.polaroid / 100.0;
    let f = params.fade_amt / 100.0 * 0.2;

    // Olive yellow Polaroid tint
    let tinted = c.rgb * vec3<f32>(1.08, 1.05, 0.88);
    let faded = fade(tinted, f);
    let desat = saturation(faded, 0.85);
    let out = mix(c.rgb, desat, p);
    return vec4<f32>(out, c.a);
}
