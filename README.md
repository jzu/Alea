# Alea – The Blockchain as an RNG

Instead of using an expensive oracle, [Alea](https://en.wiktionary.org/wiki/alea#Latin) allows to generate positive integer random numbers using block hashes. Two steps are required: the first one to initialize an internal structure, waiting for the current block to be built. The second step gives the random value – actually, a block hash.

`initAlea()` creates a tuple in a mapping where the transaction's current block number points to a constant placeholder. Once the block containing this transaction has been finalized, the first call to `getAlea()` using that initialization block number as a key sets the value to this block's hash and reveals it. Later calls to `getAlea()` with this same block number will reuse the same value. Polymorphism allows to call `getAlea()` with or without a `bound` parameter. Without a bound, the outcome will fall within the full range of an `uint256`.

Risk assesment: none at the moment. Use this for small stakes only. 
