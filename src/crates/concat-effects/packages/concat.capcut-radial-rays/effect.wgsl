struct Params { rays: f32, decay: f32 }

// Radial light accumulation along rays towards centre
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let ray_amt = params.rays / 100.0;
    let decay_factor = params.decay / 100.0;

    let centre = vec2<f32>(0.5);
    let delta = (uv - centre) * (1.0 / 8.0);
    var cur = uv;
    var acc = vec3<f32>(0.0);
    var weight = 1.0;

    for (var i = 0; i < 8; i++) {
        cur -= delta;
        let s = sample(clamp(cur, vec2<f32>(0.0), vec2<f32>(1.0))).rgb;
        let bright = max(s - vec3<f32>(0.6), vec3<f32>(0.0));
        acc += bright * weight;
        weight *= decay_factor;
    }

    let out = c.rgb + acc * ray_amt * 1.5;
    return vec4<f32>(out, c.a);
}
