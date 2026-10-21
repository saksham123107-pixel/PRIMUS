struct Params { spin: f32, radius_falloff: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let r = length(d);
    let hold = params.radius_falloff / 100.0 * 0.5;
    let factor = smoothstep(hold, 0.7071, r) * (params.spin * 0.01745329);

    var acc = vec4<f32>(0.0);
    for (var i = -3; i <= 3; i++) {
        let theta = f32(i) / 3.0 * factor;
        let s = sin(theta);
        let c = cos(theta);
        let rot_d = vec2<f32>(d.x * c - d.y * s, d.x * s + d.y * c);
        acc += sample(clamp(centre + rot_d, vec2<f32>(0.0), vec2<f32>(1.0)));
    }
    return acc / 7.0;
}
