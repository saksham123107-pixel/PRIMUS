struct Params { speed: f32, drop: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let speed = max(params.speed, 0.5);
    let drop_amt = params.drop / 100.0;
    let phase = fract(frame.time * speed);
    let dip = exp(-phase * 7.0) * drop_amt;
    let out = mix(c.rgb, vec3<f32>(0.0), dip);
    return vec4<f32>(out, c.a);
}
