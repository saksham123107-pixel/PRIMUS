struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let a = params.amount;
    let l = luma(c.rgb);
    // teal in the highlights, orange in the shadows
    let teal = vec3<f32>(0.0, 0.5, 0.6);
    let orange = vec3<f32>(0.85, 0.45, 0.15);
    let tone = mix(orange, teal, smoothstep(0.25, 0.75, l));
    let graded = mix(c.rgb, c.rgb * 0.7 + tone * 0.3, a);
    let boosted = vibrance(graded, 1.0 + 0.3 * a);
    return vec4<f32>(boosted, c.a);
}
