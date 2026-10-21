struct Params { pulse: f32, thickness: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let t = texel() * max(params.thickness, 1.0);
    let left = luma(sample(uv - vec2<f32>(t.x, 0.0)).rgb);
    let right = luma(sample(uv + vec2<f32>(t.x, 0.0)).rgb);
    let up = luma(sample(uv - vec2<f32>(0.0, t.y)).rgb);
    let down = luma(sample(uv + vec2<f32>(0.0, t.y)).rgb);

    let edge = length(vec2<f32>(right - left, down - up));
    let pulse_factor = 0.5 + 0.5 * sin(frame.time * params.pulse * 6.28318);

    let neon_color = vec3<f32>(0.1, 0.9, 1.0); // Cyan electric
    let out = c.rgb + neon_color * smoothstep(0.1, 0.35, edge) * pulse_factor * 2.0;
    return vec4<f32>(out, c.a);
}
