struct Params { glint: f32, threshold: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let thresh = params.threshold / 100.0;
    let glint_amt = params.glint / 100.0;
    let t = texel();

    // 4-point cross star sampling
    var star = 0.0;
    for (var i = 1; i <= 6; i++) {
        let d = f32(i) * 5.0;
        let w = 1.0 / (f32(i) + 0.5);
        let h1 = max(luma(sample(uv + vec2<f32>(d * t.x, 0.0)).rgb) - thresh, 0.0);
        let h2 = max(luma(sample(uv - vec2<f32>(d * t.x, 0.0)).rgb) - thresh, 0.0);
        let v1 = max(luma(sample(uv + vec2<f32>(0.0, d * t.y)).rgb) - thresh, 0.0);
        let v2 = max(luma(sample(uv - vec2<f32>(0.0, d * t.y)).rgb) - thresh, 0.0);
        star += (h1 + h2 + v1 + v2) * w;
    }

    let star_tint = vec3<f32>(1.0, 0.95, 0.85);
    let out = c.rgb + star_tint * star * glint_amt * 2.0;
    return vec4<f32>(out, c.a);
}
