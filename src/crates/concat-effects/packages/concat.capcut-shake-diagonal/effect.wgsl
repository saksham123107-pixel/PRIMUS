struct Params { shake: f32, frequency: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let f = params.shake / 100.0 * 0.04;
    let wave = sin(frame.time * params.frequency * 6.28318);
    let offset = vec2<f32>(wave * f, wave * f * 0.7071);
    let zoom = 1.0 + abs(wave) * f;
    let centre = vec2<f32>(0.5);
    let p = centre + (uv - centre + offset) / zoom;
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
