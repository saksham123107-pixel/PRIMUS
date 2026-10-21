struct Params { amount: f32, solarize: f32 }

// Color inversion with solarization threshold
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let amt = params.amount / 100.0;
    let sol = params.solarize / 100.0;

    // Invert
    var inv = vec3<f32>(1.0) - c.rgb;
    // Solarize thresholding
    let mask = step(vec3<f32>(sol), c.rgb);
    inv = mix(inv, c.rgb, mask * 0.5);

    let out = mix(c.rgb, inv, amt);
    return vec4<f32>(out, c.a);
}
