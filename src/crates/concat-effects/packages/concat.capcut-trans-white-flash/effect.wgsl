struct Params { brightness: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let a = from_at(uv);
    let b = to_at(uv);
    let flash = sin(progress * 3.14159265) * (params.brightness / 100.0);
    let cross = mix(a, b, progress);
    let out = mix(cross.rgb, vec3<f32>(1.0), flash);
    return vec4<f32>(out, cross.a);
}
