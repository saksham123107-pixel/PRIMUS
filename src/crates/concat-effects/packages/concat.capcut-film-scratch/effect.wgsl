struct Params { scratches: f32, jitter: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let j_amt = params.jitter / 100.0 * 0.006;
    let s_amt = params.scratches / 100.0;

    let time_step = floor(frame.time * 16.0);
    let jitter_y = (hash(vec2<f32>(time_step, 0.0), 11.0) - 0.5) * j_amt;
    let p = vec2<f32>(uv.x, clamp(uv.y + jitter_y, 0.0, 1.0));
    var c = sample(p);

    // Scratch line at randomized horizontal positions
    let scratch_pos = hash(vec2<f32>(time_step, 45.0), 99.0);
    let dist = abs(uv.x - scratch_pos);
    if (dist < 0.0015 * s_amt && hash(vec2<f32>(time_step, 88.0), 3.0) > 0.4) {
        c = vec4<f32>(vec3<f32>(0.85), c.a);
    }
    return c;
}
