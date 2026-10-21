struct Params { angle_val: f32, radius_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let r = length(d);
    let max_r = params.radius_val / 100.0 * 0.7071;

    var p = uv;
    if (r < max_r) {
        let percent = (max_r - r) / max_r;
        let theta = percent * percent * (params.angle_val * 0.01745329);
        let s = sin(theta);
        let c_val = cos(theta);
        p = centre + vec2<f32>(d.x * c_val - d.y * s, d.x * s + d.y * c_val);
    }

    return sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0)));
}
