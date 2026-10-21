struct Params { flare_width: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let base = mix(from_at(uv), to_at(uv), progress);
    let beam_center = progress * 1.4 - 0.2;
    let dist = abs(uv.x - beam_center);
    let beam_w = params.flare_width / 100.0 * 0.3;

    let flare = smoothstep(beam_w, 0.0, dist);
    let flare_color = vec3<f32>(1.0, 0.75, 0.3) * flare * 1.8;

    return vec4<f32>(base.rgb + flare_color, base.a);
}
