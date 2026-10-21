struct Params { strength: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let pulse = 0.5 + 0.5 * sin(frame.time * params.speed * 6.28318531);
    let highlight = smoothstep(0.6, 1.0, luma(c.rgb));
    let glow = highlight * pulse * params.strength;
    let out = c.rgb + vec3<f32>(glow);
    return vec4<f32>(out, c.a);
}
