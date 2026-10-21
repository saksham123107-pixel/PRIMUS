struct Params { tear: f32, speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let tear_amt = params.tear / 100.0;
    let bar_y = fract(frame.time * params.speed * 0.2);
    let dist_to_bar = abs(uv.y - bar_y);

    var offset_x = 0.0;
    if (dist_to_bar < 0.06) {
        let f = (0.06 - dist_to_bar) / 0.06;
        offset_x = sin(uv.y * 120.0 + frame.time * 20.0) * f * 0.05 * tear_amt;
    }

    let p = vec2<f32>(clamp(uv.x + offset_x, 0.0, 1.0), uv.y);
    var c = sample(p);

    if (dist_to_bar < 0.02) {
        let noise = hash(uv * 100.0, frame.time);
        c = mix(c, vec4<f32>(vec3<f32>(noise), c.a), tear_amt * 0.7);
    }
    return c;
}
