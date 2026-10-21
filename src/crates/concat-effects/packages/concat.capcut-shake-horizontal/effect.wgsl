struct Params { shake: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let s = params.shake / 100.0 * 0.05;
    let jitter = sin(frame.time * params.speed * 6.28318) * s;
    let zoom = 1.0 + abs(jitter) * 0.5;
    let centre = vec2<f32>(0.5);
    let p = centre + (uv - centre + vec2<f32>(jitter, 0.0)) / zoom;
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
