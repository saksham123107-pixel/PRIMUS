struct Params { clarity: f32, vibrance_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let cl = params.clarity / 100.0;
    let vib = params.vibrance_val / 100.0;
    let t = texel() * 2.0;

    let blurred = (sample(uv + vec2<f32>(t.x, 0.0)).rgb +
                   sample(uv - vec2<f32>(t.x, 0.0)).rgb +
                   sample(uv + vec2<f32>(0.0, t.y)).rgb +
                   sample(uv - vec2<f32>(0.0, t.y)).rgb) * 0.25;

    // Unsharp micro-contrast mask
    let sharp = c.rgb + (c.rgb - blurred) * cl * 0.8;
    let graded = s_curve(sharp, cl * 0.35);
    let out = vibrance(graded, vib * 0.6);
    return vec4<f32>(out, c.a);
}
