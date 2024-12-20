# Alea – The Blockchain as an RNG

Instead of using an expensive oracle, [Alea](https://en.wiktionary.org/wiki/alea#Latin) allows to obtain random positive integers using block hashes. Two steps are required: the first one initializes an internal structure, waiting for a block to be built; the second step gives the random value – actually, this block's hash or a derived value. The use of a future block hash when the initialization is called guarantees the randomness.

`initAlea()` creates a tuple in a mapping where the transaction's current block number, or a future block number if it is called with a parameter, is the key to a constant value, `0xaddeda1ea`. Once the block containing this transaction has been finalized, the first call to `getAlea()` using that block number as a key sets the value to this block's hash and reveals it. Later calls to `getAlea()` with this same block number will reuse the same value. `getAlea()` may be called with or without a `bound` parameter limiting the range of the return value. 

To sum up, there are three possible states for a tuple when `getAlea()` is called in a transaction:
- `alea[bn] == 0` → Not found, uninitialized, error.
- `alea[bn] == 0xaddeda1ea` → Initalized, the hash replaces the default value if the block is in the past, and is used.
- `alea[bn] != 0 && alea[bn] != 0xaddeda1ea` → The value is used.

`initAlea()` returns and emits the block number. `getAlea()` returns and emits the hash, or the modulo of this hash if called with the `bound` parameter.

Risk assesment: none at the moment. Proceed with caution. Use this for small stakes only. 

<sub><sup>Buy me a coffee: 0x75b885aDb09823bfb1ef8227f5943801EA9853C2</sup></sub>
