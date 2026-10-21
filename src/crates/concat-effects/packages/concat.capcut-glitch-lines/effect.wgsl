struct Params { density: f32, flicker: f32 }

// Cyberpunk scanline grating + signal noise lines
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let density_val = max(params.density / 100.0 * 4.0, 1.0);
    let noise_amt = params.flicker / 100.0;

    // Scanline grating
    let scan = 0.5 + 0.5 * sin(uv.y * frame.size.y * density_val * 0.5);

    // Random signal glitch pulses
    let seed = floor(frame.time * 12.0);
    let row_noise = hash(vec2<f32>(floor(uv.y * 30.0), seed), 17.0);
    var glitch_bar = 0.0;
    if (row_noise > 0.88) {
        glitch_bar = (row_noise - 0.88) * noise_amt * 2.0;
    }

    let out = c.rgb * (0.8 + 0.2 * scan) + vec3<f32>(glitch_bar * 0.4, glitch_bar, glitch_bar * 0.9);
    return vec4<f32>(out, c.a);
}
