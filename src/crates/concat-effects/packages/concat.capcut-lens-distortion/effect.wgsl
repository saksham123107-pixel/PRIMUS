struct Params { warp: f32, fringe: f32 }

// Barrel / pincushion lens distortion with chromatic separation
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let k = params.warp / 100.0 * 0.4;
    let fringe_amt = params.fringe * texel().x;

    let centre = vec2<f32>(0.5);
    let d = uv - centre;
    let r2 = dot(d, d);

    let p = centre + d * (1.0 + k * r2);
    let pr = centre + d * (1.0 + (k + fringe_amt) * r2);
    let pb = centre + d * (1.0 + (k - fringe_amt) * r2);

    let red = sample(clamp(pr, vec2<f32>(0.0), vec2<f32>(1.0))).r;
    let green = sample(clamp(p, vec2<f32>(0.0), vec2<f32>(1.0))).g;
    let blue = sample(clamp(pb, vec2<f32>(0.0), vec2<f32>(1.0))).b;
    let alpha = sample(uv).a;

    return vec4<f32>(red, green, blue, alpha);
}
