struct Params { tear_offset: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let t = texel();
    let peak = sin(progress * 3.14159265);
    let off = params.tear_offset * t.x * peak;

    let r_p = clamp(uv + vec2<f32>(off, 0.0), vec2<f32>(0.0), vec2<f32>(1.0));
    let b_p = clamp(uv - vec2<f32>(off, 0.0), vec2<f32>(0.0), vec2<f32>(1.0));

    let a_rgb = vec3<f32>(from_at(r_p).r, from_at(uv).g, from_at(b_p).b);
    let b_rgb = vec3<f32>(to_at(r_p).r, to_at(uv).g, to_at(b_p).b);

    return vec4<f32>(mix(a_rgb, b_rgb, progress), mix(from_at(uv).a, to_at(uv).a, progress));
}
