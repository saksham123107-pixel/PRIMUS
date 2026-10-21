struct Params { step_force: f32, fps: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let force = params.step_force / 100.0 * 0.04;
    let step_time = floor(frame.time * params.fps);
    let rnd_x = (hash(vec2<f32>(step_time, 0.0), 7.0) - 0.5) * force;
    let rnd_y = (hash(vec2<f32>(step_time, 1.0), 13.0) - 0.5) * force;
    let centre = vec2<f32>(0.5);
    let p = centre + (uv - centre + vec2<f32>(rnd_x, rnd_y)) / (1.0 + force);
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
