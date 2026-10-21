struct Params { brightness: f32, threshold: f32, spread: f32 }

// Horizontal anamorphic streak filter across highlights
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let intensity = params.brightness / 100.0;
    let thresh = params.threshold / 100.0;
    let spread = params.spread / 100.0;
    let t = texel();

    // Sum horizontal taps across bright highlights
    var streak = 0.0;
    let streak_color = vec3<f32>(0.2, 0.6, 1.0); // Electric cinematic cyan-blue

    for (var i = 1; i <= 8; i++) {
        let off = f32(i) * t.x * spread * 20.0;
        let left = sample(uv - vec2<f32>(off, 0.0)).rgb;
        let right = sample(uv + vec2<f32>(off, 0.0)).rgb;
        let weight = 1.0 / (f32(i) * 0.8 + 1.0);

        let hl_left = max(luma(left) - thresh, 0.0);
        let hl_right = max(luma(right) - thresh, 0.0);
        streak += (hl_left + hl_right) * weight;
    }

    let out = c.rgb + streak_color * streak * intensity * 2.5;
    return vec4<f32>(out, c.a);
}
