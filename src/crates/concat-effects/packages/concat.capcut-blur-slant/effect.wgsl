struct Params { blur_len: f32, angle: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let rad = params.angle * 0.01745329;
    let dir = vec2<f32>(cos(rad), sin(rad)) * texel() * params.blur_len;
    var acc = vec4<f32>(0.0);
    for (var i = -4; i <= 4; i++) {
        let f = f32(i) / 4.0;
        acc += sample(uv + dir * f);
    }
    return acc / 9.0;
}
