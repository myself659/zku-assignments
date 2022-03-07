
# Installing the circom ecosystem

## install rust

```
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```

## Installing circom

```
git clone https://github.com/iden3/circom.git
cargo build --release
```

```
cargo install --path circom
```
The previous command will install the circom binary in the directory $HOME/.cargo/bin.


## Installing snarkjs

```
npm install -g snarkjs
```

[Snarkjs Error: File not being found even though the file is present in the specified location](https://stackoverflow.com/questions/65757006/snarkjs-error-file-not-being-found-even-though-the-file-is-present-in-the-speci)

## installing for c++

```
sudo apt install nlohmann-json-dev
sudo apt-get install libgmp-dev
```




# MiMCsponge

[Extending our multiplier to three inputs](https://docs.circom.io/more-circuits/more-basic-circuits/#extending-our-multiplier-to-three-inputs)

[mimcsponge.circom](https://github.com/iden3/circomlib/blob/master/circuits/mimcsponge.circom)

input.json: {"leaves": [1, 2, 3, 4, 5, 6, 7, 8]}

hashing method: MiMCSponge(nInputs, nRounds, nOutputs).
with nRounds = 220 and k = 0,The merkle root I got: merkle8.circom

https://discord.com/channels/942318442340560917/944923724497428490/948522510666833930

```
leaf5 = mimcsponge(1, 2)
leaf6 = mimcsponge(3,4)
leaf7 = mimcsponge(5,6)
component mimc = MimcSponge(2)
mimc.in[0] <== leaf1
mimc.in[1] <== leaf2
mimc.k <== 0

mimc.out...
```

# merkle8

```
circom merkle8.circom --r1cs --wasm --sym --c
node generate_witness.js merkle8.wasm input.json witness.wtns



snarkjs powersoftau new bn128 20 pot20_0000.ptau -v
snarkjs powersoftau contribute pot20_0000.ptau pot20_0001.ptau --name="First contribution" -v
snarkjs powersoftau prepare phase2 pot20_0001.ptau pot20_final.ptau -v
snarkjs groth16 setup merkle8.r1cs pot20_final.ptau merkle8_0000.zkey




snarkjs groth16 setup merkle8.r1cs pot20_final.ptau merkle8_0000.zkey
snarkjs zkey contribute merkle8_0000.zkey merkle8_0001.zkey --name="1st Contributor Name" -v
snarkjs zkey export verificationkey merkle8_0001.zkey verification_key.json

snarkjs groth16 prove merkle8_0001.zkey witness.wtns proof.json public.json

```

```
[ERROR] snarkJS: circuit too big for this power of tau ceremony. 9240*2 > 2**12
```

# merkle-tree

[Merkle Tree](https://solidity-by-example.org/app/merkle-tree/)

[MERKLE PROOFS FOR OFFLINE DATA INTEGRITY](https://ethereum.org/en/developers/tutorials/merkle-proofs-for-offline-data-integrity/)

[Merkle proofs Explained.](https://medium.com/crypto-0-nite/merkle-proofs-explained-6dd429623dc5)

[Verifiable data structures](https://transparency.dev/verifiable-data-structures/)

A Merkle proof consists of a chunk, the root hash of the tree, and the "branch" consisting of all of the hashes going up along the path from the chunk to the root.

A Merkle tree is just an efficient way to prove that something is in a set, without having to store the set. Each non leaf node of a Merkle tree is just the hash of the concatenation of it's children. Each of the leaves are the set we want to prove membership for. In a sense, the root of the Merkle tree is a digest of all of the elements in the data set. Say person A contains the root node of the Merkle tree for set S, and person B wants to convince person A that element E is in S. To do this, person B only has to provide person A with the siblings of all of the elements in the tree in the path from E to the root node. This is only log(n) nodes. So B only has to provide only log(n) pieces of data, and person A only has to store the root node. With this provided information, person A can recompute the root node of the tree, and check to make sure that it matches the one that he knows is correct. If the hash function is collision resistant, then he can be sure that E is in S.
