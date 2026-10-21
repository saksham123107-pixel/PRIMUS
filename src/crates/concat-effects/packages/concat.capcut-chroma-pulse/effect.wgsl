struct Params { pulse: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let p_amt = params.pulse / 100.0 * 0.05;
    let phase = fract(frame.time * max(params.speed, 0.5));
    let kick = exp(-phase * 8.0) * p_amt;

    let centre = vec2<f32>(0.5);
    let d = uv - centre;

    let r_uv = centre + d * (1.0 - kick);
    let b_uv = centre + d * (1.0 + kick);

    let red = sample(clamp(r_uv, vec2<f32>(0.0), vec2<f32>(1.0))).r;
    let green = sample(uv).g;
    let blue = sample(clamp(b_uv, vec2<f32>(0.0), vec2<f32>(1.0))).b;

    return vec4<f32>(red, green, blue, sample(uv).a);
}
