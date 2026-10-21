struct Params { feather: f32, film_tone: f32 }

// 2.39:1 anamorphic theatrical letterboxing with subtle film curve
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let t = texel();
    let feather_px = params.feather * t.y;

    // Target 2.39:1 aspect ratio bars
    let target_height = frame.size.x / 2.39;
    let bar_height = max((frame.size.y - target_height) * 0.5 / frame.size.y, 0.0);

    let top_mask = smoothstep(bar_height - feather_px, bar_height, uv.y);
    let bot_mask = smoothstep(bar_height - feather_px, bar_height, 1.0 - uv.y);
    let bar_mask = top_mask * bot_mask;

    // Subtle film contrast on picture
    let graded = s_curve(c.rgb, params.film_tone / 100.0 * 0.5);
    let out = graded * bar_mask;
    return vec4<f32>(out, c.a);
}
