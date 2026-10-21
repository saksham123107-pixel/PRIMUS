struct Params { wave: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let wave_amt = params.wave / 100.0 * 0.04;
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let r = length(d);

    let ripple = sin(r * 40.0 - frame.time * params.speed * 3.14159) * wave_amt;
    let p = centre + d * (1.0 + ripple / max(r, 0.05));
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
