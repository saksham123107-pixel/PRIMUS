struct Params { leak: f32, angle: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let leak_amt = params.leak / 100.0;
    let rad = params.angle * 0.01745329;
    let dir = vec2<f32>(cos(rad), sin(rad));

    let proj = dot(uv, dir);
    let spectrum = sin(vec3<f32>(proj * 8.0) + vec3<f32>(0.0, 2.0, 4.0)) * 0.5 + 0.5;
    let flare = smoothstep(0.2, 0.8, sin(proj * 4.0 + frame.time * 0.5)) * leak_amt;

    let out = screen(c.rgb, spectrum * flare * 1.5);
    return vec4<f32>(out, c.a);
}
