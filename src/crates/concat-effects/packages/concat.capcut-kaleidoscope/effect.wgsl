struct Params { segments: f32, rotation: f32 }

// N-fold polar angular symmetry reflection
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let r = length(d);
    var theta = atan2(d.y, d.x) + frame.time * (params.rotation / 100.0);

    let seg_angle = 6.283185307 / max(params.segments, 4.0);
    theta = abs(fract(theta / seg_angle) * seg_angle - seg_angle * 0.5);

    let sample_p = centre + vec2<f32>(cos(theta), sin(theta)) * r;
    return sample(clamp(sample_p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
