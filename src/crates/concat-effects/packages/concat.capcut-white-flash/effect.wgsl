struct Params { speed: f32, burst: f32 }

// Rhythmic high-impact white flash with exponential decay per cycle
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let speed = max(params.speed, 0.5);
    let burst_amt = params.burst / 100.0;

    // Cycle phase from 0 to 1
    let phase = fract(frame.time * speed);
    // Exponential flash decay: sharp burst at onset, fast falloff
    let flash = exp(-phase * 6.0) * burst_amt;

    // Additive screen blend over layer
    let flash_rgb = mix(c.rgb, vec3<f32>(1.0), flash);
    return vec4<f32>(flash_rgb, c.a);
}
