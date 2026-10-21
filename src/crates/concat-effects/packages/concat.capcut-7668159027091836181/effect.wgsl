struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let t = 0.002;
    let c = sample(uv);
    let near = (sample(uv + vec2<f32>(t,0.0)) + sample(uv - vec2<f32>(t,0.0)) + sample(uv + vec2<f32>(0.0,t)) + sample(uv - vec2<f32>(0.0,t))) * 0.25;
    let edge = c.rgb - near.rgb;
    return vec4<f32>(c.rgb + edge * params.amount * 2.0, c.a);
}
