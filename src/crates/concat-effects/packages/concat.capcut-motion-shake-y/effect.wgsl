struct Params { bounce: f32, frequency: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let bounce_amt = params.bounce / 100.0 * 0.04;
    let freq = params.frequency;
    let offset_y = abs(sin(frame.time * freq * 3.14159)) * bounce_amt;
    let p = vec2<f32>(uv.x, clamp(uv.y + offset_y, 0.0, 1.0));
    return sample(p);
}
