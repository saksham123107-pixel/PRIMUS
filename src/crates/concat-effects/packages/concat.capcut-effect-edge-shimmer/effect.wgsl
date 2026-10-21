struct Params { shimmer: f32, cycle_speed: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let t = texel();
    let sh = params.shimmer / 100.0;

    let l = luma(sample(uv - vec2<f32>(t.x, 0.0)).rgb);
    let r = luma(sample(uv + vec2<f32>(t.x, 0.0)).rgb);
    let u = luma(sample(uv - vec2<f32>(0.0, t.y)).rgb);
    let d = luma(sample(uv + vec2<f32>(0.0, t.y)).rgb);

    let edge = smoothstep(0.1, 0.35, length(vec2<f32>(r - l, d - u)));
    let phase = uv.x * 4.0 + uv.y * 3.0 + frame.time * params.cycle_speed;
    let rainbow = sin(vec3<f32>(phase) + vec3<f32>(0.0, 2.094, 4.188)) * 0.5 + 0.5;

    let out = c.rgb + rainbow * edge * sh * 2.0;
    return vec4<f32>(out, c.a);
}
