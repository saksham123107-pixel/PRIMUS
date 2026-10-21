struct Params { shake: f32, speed: f32, split: f32 }

// Dynamic camera shake displacement with chromatic separation
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let shake_amt = params.shake / 100.0;
    let speed = params.speed;
    let t = texel();

    // High-frequency oscillating camera jitter
    let jitter_x = sin(frame.time * speed * 6.28318) * 0.02 * shake_amt;
    let jitter_y = cos(frame.time * speed * 7.53982) * 0.015 * shake_amt;
    let base_uv = uv + vec2<f32>(jitter_x, jitter_y);

    // Chromatic offset in pixels
    let split_off = vec2<f32>(params.split * t.x * shake_amt, 0.0);

    let red = sample(base_uv - split_off).r;
    let green = sample(base_uv).g;
    let blue = sample(base_uv + split_off).b;
    let alpha = sample(base_uv).a;

    return vec4<f32>(red, green, blue, alpha);
}
