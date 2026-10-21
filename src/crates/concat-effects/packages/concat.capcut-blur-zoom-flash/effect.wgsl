struct Params { zoom_amt: f32, bloom: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let z = params.zoom_amt / 100.0 * 0.15;
    let bl = params.bloom / 100.0 * 0.5;
    let centre = vec2<f32>(0.5);
    let dir = uv - centre;

    var acc = vec3<f32>(0.0);
    for (var i = 0; i < 6; i++) {
        let scale = 1.0 - f32(i) / 5.0 * z;
        acc += sample(clamp(centre + dir * scale, vec2<f32>(0.0), vec2<f32>(1.0))).rgb;
    }
    acc = acc / 6.0;
    let out = mix(acc, vec3<f32>(1.0), bl * luma(acc));
    return vec4<f32>(out, sample(uv).a);
}
