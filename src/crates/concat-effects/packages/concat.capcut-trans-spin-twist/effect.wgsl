struct Params { rotations: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let angle = progress * 3.14159265 * 2.0 * params.rotations;
    let s = sin(angle);
    let c = cos(angle);
    let rot_d = vec2<f32>(d.x * c - d.y * s, d.x * s + d.y * c);

    let from_p = clamp(centre + rot_d * (1.0 + progress * 0.5), vec2<f32>(0.0), vec2<f32>(1.0));
    let to_p = clamp(centre + rot_d * (1.5 - progress * 0.5), vec2<f32>(0.0), vec2<f32>(1.0));

    return mix(from_at(from_p), to_at(to_p), smoothstep(0.3, 0.7, progress));
}
