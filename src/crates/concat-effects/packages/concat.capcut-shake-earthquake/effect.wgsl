struct Params { rumble: f32, blur_amt: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let r = params.rumble / 100.0 * 0.035;
    let t = frame.time * 25.0;
    let ox = (sin(t) + sin(t * 1.7) * 0.5) * r;
    let oy = (cos(t * 1.3) + cos(t * 2.1) * 0.5) * r;
    let centre = vec2<f32>(0.5);
    let p = centre + (uv - centre + vec2<f32>(ox, oy)) / (1.0 + r);
    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
