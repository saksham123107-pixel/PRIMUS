struct Params { punch: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let p_amt = params.punch / 100.0 * 0.2;
    let phase = fract(frame.time * max(params.speed, 0.5));
    let zoom = 1.0 + exp(-phase * 6.0) * p_amt;

    let centre = vec2<f32>(0.5);
    let p = centre + (uv - centre) / zoom;
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
