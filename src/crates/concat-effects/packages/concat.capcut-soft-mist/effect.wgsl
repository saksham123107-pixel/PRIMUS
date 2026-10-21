struct Params { mist: f32, lift: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let mist_amt = params.mist / 100.0;
    let t = texel() * 4.0;

    let diffuse = (sample(uv + vec2<f32>(t.x, t.y)).rgb +
                   sample(uv - vec2<f32>(t.x, t.y)).rgb +
                   sample(uv + vec2<f32>(-t.x, t.y)).rgb +
                   sample(uv + vec2<f32>(t.x, -t.y)).rgb) * 0.25;

    let hazey = mix(c.rgb, diffuse, mist_amt * 0.6);
    let lifted = fade(hazey, params.lift / 100.0 * 0.25);
    return vec4<f32>(lifted, c.a);
}
