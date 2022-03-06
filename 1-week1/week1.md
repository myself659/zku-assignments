
# Q1

## circom code  

```
pragma circom 2.0.0;

include "mimcsponge.circom";


template Merkle8 () {

    signal input ins[8];
    signal output out;

    component ins_L1[4];

    for(var i = 0; i < 4; i++) {
        ins_L1[i] = MiMCSponge(2, 220, 1);
        ins_L1[i].ins[0] <-- ins[2*i];
        ins_L1[i].ins[1] <-- ins[2*i+1];
        ins_L1[i].k <== 0;
    }
    component ins_L2[2];
    for(var i = 0; i < 2; i++) {
        ins_L2[i] = MiMCSponge(2, 220, 1);
        ins_L2[i].ins[0] <--  ins_L1[2*i].outs[0];
        ins_L2[i].ins[1] <--  ins_L1[2*i+1].outs[0];
        ins_L2[i].k <== 0;
    }

    component top = MiMCSponge(2, 220, 1);
    top.ins[0] <-- ins_L2[0].outs[0];
    top.ins[1] <-- ins_L2[1].outs[0];
    top.k <== 0;

    out <== top.outs[0];
    // note: if circom support loop in loop, the above code can be Refactored to be general
}

// component: Instantiate a template.
 component main = Merkle8();

```

## public.json

```
[
 "7457672556014162487472065518158328090252704233415054189820328174772177160972"
]
```

the proof of public.json is as follow:

![](Q1-public.png)

## Do we really need zero-knowledge proof for this? Can a publicly verifiable smart contract that computes Merkle root achieve the same? If so, give a scenario where Zero-Knowledge proofs like this might be useful. Are there any technologies implementing this type of proof? Elaborate in 100 words on how they work.


## As you may have noticed, compiling circuits and generating the witness is an elaborate process. Explain what each step is doing. Optionally, you may create a bash script and comment on each step in it. This script will be useful later on to quickly compile circuits.


# Q2

# Q3

## 1. Summarize the key differences (in application, not in theory) between SNARKs and STARKs in 100 words.

## 2. How is the trusted setup process different between Groth16 and PLONK?

## 3. Give an idea of how we can apply ZK to create unique usage for NFTs.


## 4. Give a novel idea on how we can apply ZK for Dao Tooling. (Yes, we know voting is a very popular one, but what else can ZK do?)

链上资产证明。

Voting and guaranteeing fair election results.

AMMs: Novel AMM designs are possible using our technology, including dAMM, a design where liquidity is shared across multiple independent L2 solutions.

Data Management; monitoring supply chains, managing medical information, maintaining real estate records, tracking royalties in the music industry, and more.

# reference

[On-boarding 10,000 Developers for ZK Products ](https://harmonyone.notion.site/harmonyone/On-boarding-10-000-Developers-for-ZK-Products-9eeb5f83a097499289ca5e9fd113f2f5)

[Assignment 1](https://zku.one/course-schedule/assignment-1-due)
