struct Params { grain_amt: f32, size_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let g = params.grain_amt / 100.0 * 0.18;
    let sz = max(params.size_val, 1.0);
    let pixel = floor(uv * frame.size / sz);
    let noise = hash(pixel, floor(frame.time * 24.0)) - 0.5;
    let out = c.rgb + vec3<f32>(noise * g);
    return vec4<f32>(out, c.a);
}
