struct Params { zoom_speed: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let s = params.zoom_speed / 100.0;

    if (progress < 0.5) {
        let f = progress * 2.0;
        let zoom = 1.0 + f * f * s * 4.0;
        return from_at(clamp(centre + d / zoom, vec2<f32>(0.0), vec2<f32>(1.0)));
    } else {
        let f = (1.0 - progress) * 2.0;
        let zoom = 1.0 + f * f * s * 4.0;
        return to_at(clamp(centre + d / zoom, vec2<f32>(0.0), vec2<f32>(1.0)));
    }
}
