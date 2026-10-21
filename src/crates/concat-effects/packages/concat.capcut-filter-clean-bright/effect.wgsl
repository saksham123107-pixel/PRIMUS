struct Params { brightness: f32, soft_glow: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let b = params.brightness / 100.0 * 0.3;
    let bloom = params.soft_glow / 100.0 * 0.2;

    let lifted = c.rgb * (1.0 + b) + vec3<f32>(b * 0.3);
    let out = screen(lifted, vec3<f32>(bloom));
    return vec4<f32>(out, c.a);
}
