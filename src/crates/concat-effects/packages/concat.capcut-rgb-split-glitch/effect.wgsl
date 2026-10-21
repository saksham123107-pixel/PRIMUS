struct Params { split: f32, wave: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let t = texel();
    let split_px = params.split * t.x;
    let wave_amt = params.wave / 100.0 * 0.02;
    let wave_y = sin(uv.y * 30.0 + frame.time * 10.0) * wave_amt;

    let p = uv + vec2<f32>(wave_y, 0.0);
    let red = sample(p - vec2<f32>(split_px, 0.0)).r;
    let green = sample(p).g;
    let blue = sample(p + vec2<f32>(split_px, 0.0)).b;

    return vec4<f32>(red, green, blue, sample(uv).a);
}
