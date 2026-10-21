struct Params { blend: f32, sensitivity: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let t = texel();
    let sens = params.sensitivity / 100.0;
    let b = params.blend / 100.0;

    let l = luma(sample(uv - vec2<f32>(t.x, 0.0)).rgb);
    let r = luma(sample(uv + vec2<f32>(t.x, 0.0)).rgb);
    let u = luma(sample(uv - vec2<f32>(0.0, t.y)).rgb);
    let d = luma(sample(uv + vec2<f32>(0.0, t.y)).rgb);

    let edge = length(vec2<f32>(r - l, d - u));
    let line_art = vec3<f32>(1.0 - smoothstep(0.05 * sens, 0.25 * sens, edge));
    let out = mix(c.rgb, line_art, b);
    return vec4<f32>(out, c.a);
}
