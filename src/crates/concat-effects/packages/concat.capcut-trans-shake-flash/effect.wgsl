struct Params { shake: f32, flash: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let p = clamp(progress, 0.0, 1.0);
    // shake amplitude ramps up into the cut and decays out of it
    let amp = (params.shake / 100.0) * 0.05 * (4.0 * p * (1.0 - p));
    let jitter = vec2<f32>(sin(p * 61.0), cos(p * 53.0)) * amp;
    let a = from_at(uv + jitter);
    let b = to_at(uv - jitter);
    let cross = mix(a, b, smoothstep(0.0, 1.0, p));
    // white strobe peaking at the middle of the cut
    let flash = sin(p * 3.14159265) * (params.flash / 100.0);
    let out = mix(cross.rgb, vec3<f32>(1.0), flash);
    return vec4<f32>(out, cross.a);
}
