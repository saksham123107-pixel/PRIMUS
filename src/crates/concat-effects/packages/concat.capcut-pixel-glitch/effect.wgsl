struct Params { mosh: f32, slices: f32 }

// Horizontal digital slice displacement and block tears
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let mosh_amt = params.mosh / 100.0;
    let n_slices = max(params.slices, 5.0);

    let row = floor(uv.y * n_slices);
    let seed = floor(frame.time * 8.0) * 100.0 + row;
    let rnd = hash(vec2<f32>(row, seed), 42.0);

    var offset_x = 0.0;
    if (rnd > 0.65) {
        offset_x = (rnd - 0.65) * 0.2 * mosh_amt;
    }

    let p = vec2<f32>(clamp(uv.x + offset_x, 0.0, 1.0), uv.y);
    return sample(p);
}
