struct Params { blur_depth: f32, focus_pos: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let pos_y = params.focus_pos / 100.0;
    let dist = abs(uv.y - pos_y);
    let blur_factor = smoothstep(0.1, 0.4, dist) * params.blur_depth * texel().y;

    if (blur_factor < 0.001) {
        return sample(uv);
    }

    var acc = vec4<f32>(0.0);
    for (var i = -3; i <= 3; i++) {
        let off = f32(i) * blur_factor;
        acc += sample(uv + vec2<f32>(0.0, off));
    }
    return acc / 7.0;
}
