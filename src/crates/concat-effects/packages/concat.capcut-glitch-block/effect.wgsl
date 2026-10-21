struct Params { blocks: f32, size_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let block_sz = max(params.size_val, 8.0);
    let b_amt = params.blocks / 100.0;

    let pixel_coord = uv * frame.size;
    let block_id = floor(pixel_coord / block_sz);
    let seed = floor(frame.time * 6.0) * 1000.0;
    let rnd = hash(block_id, seed);

    var sample_p = uv;
    if (rnd > (1.0 - b_amt * 0.4)) {
        // Displace block to neighbor
        let disp = vec2<f32>(hash(block_id, seed + 1.0) - 0.5, hash(block_id, seed + 2.0) - 0.5) * 0.1;
        sample_p = clamp(uv + disp, vec2<f32>(0.0), vec2<f32>(1.0));
    }

    return sample(sample_p);
}
