struct Params { streak: f32, brightness: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let s = params.streak * texel();
    let boost = params.brightness / 100.0 * 0.5;

    var acc = vec3<f32>(0.0);
    for (var i = -4; i <= 4; i++) {
        let f = f32(i);
        let h = sample(uv + vec2<f32>(f * s.x, 0.0)).rgb;
        let v = sample(uv + vec2<f32>(0.0, f * s.y)).rgb;
        acc += (h + v) * 0.5;
    }
    acc = acc / 9.0;
    let out = mix(c.rgb, acc, 0.6) + acc * boost;
    return vec4<f32>(out, c.a);
}
