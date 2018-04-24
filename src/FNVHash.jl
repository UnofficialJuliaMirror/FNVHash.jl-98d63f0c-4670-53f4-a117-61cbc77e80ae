__precompile__()


module FNVHash

export fnv32, fnv16

if VERSION < v"0.6.0" const xor = $ end # FIXME

# References:
#   http://www.isthe.com/chongo/tech/comp/fnv/#FNV-1a
#   https://en.wikipedia.org/wiki/Fowler–Noll–Vo_hash_function
#   http://tools.ietf.org/html/draft-eastlake-fnv-03

function fnv32(data::Vector{UInt8})
    hash = 0x811C9DC5
    for c in data
        hash = xor(hash, c) * 0x01000193
    end
    return hash
end

fnv32(s) = fnv32(Vector{UInt8}(s))


fnv16(hash::UInt32) = UInt16(hash >>> 16) $ UInt16(hash) & 0xFFFF
fnv16(data) = fnv16(fnv32(data))


end # module FNVHash
