
# Question 1: Dark Forest

<!--
https://www.xdaichain.com/about-gc/project-spotlights/dark-forest
https://blog.zkga.me/announcing-darkforest
https://mirror.xyz/cryptodesigner.eth/3mffedGJy1UxhQWaNUt6dLFUhCrMgaleoVXkyivV5Ik
https://omarmezenner.mirror.xyz/gFCfCVwTfUU91SDXeROEaDQe4984nbFBIgv9QSY0r1U



 -->

# Question 2: Fairness in card games

##  1. Card commitment - In DarkForest, players commit to a location by submitting a location hash. It is hard to brute force a location hash since there can be so many possible coordinates.

In a card game, how can a player commit to a card without revealing what the card is? A naive protocol would be to map all cards to a number between 0 and 51 and then hash this number to get a commitment. This won’t actually work as one could easily brute force the 52 hashes.

To prevent players from changing the card we need to store some commitment on-chain. How would you design this commitment? Assume each player has a single card that needs to be kept secret.  Modify the naive protocol so that brute force doesn’t work


## 2. To prevent players from changing the card we need to store some commitment on-chain. How would you design this commitment? Assume each player has a single card that needs to be kept secret.  Modify the naive protocol so that brute force doesn’t work

Design a contract, necessary circuits, and verifiers to achieve this. You may need to come up with an appropriate representation of cards as integers such that the above operations can be done easily.


## 3. [Bonus] How can a player reveal that it is a particular card (Say ace) without revealing which suit it belongs to (ace of diamonds etc.)


# Question 3: MACI and VDF

## 1. What problems in voting does MACI not solve? What are some potential solutions?

<!--
https://github.com/appliedzkp/maci/tree/v1
https://medium.com/privacy-scaling-explorations/release-announcement-maci-1-0-c032bddd2157
https://ethresear.ch/t/maci-anonymization-using-rerandomizable-encryption/7054
https://blog.clr.fund/trusted-setup-completed/
https://ethresear.ch/t/minimal-anti-collusion-infrastructure/5413
 -->

Anonymisation. While all votes are encrypted, currently the coordinator is able to decrypt and read them

using rerandomizable encryption  ElGamal Encryption

Trusted setup

## 2. How can a pseudorandom dice roll be simulated using just Solidity?

### 1. What are the issues with this approach?

use blocktime.


### 2. How would you design a multi party system that performs a dice roll?

solution A:

solution B:

### 3. Compare both techniques and explain which one is fairer and why.

### 4. Show how the multi party system is still vulnerable to manipulation by malicious parties and then elaborate on the use of VDF’s in solving this.



## 3. [Bonus] How would two players pick a random and mutually exclusive subsets of a set? For instance, in a poker game, how would two players decide on a hand through the exchange of messages on a blockchain?


# Question 4: InterRep


## 1. How does InterRep use Semaphore in their implementation? Explain why InterRep still needs a centralized server.

## 2. Clone the InterRep repos: contracts and reputation-service. Follow the instructions on the Github repos to start the development environment. Try to join one of the groups, and then leave the group. Explain what happens to the Merkle Tree in the MongoDB instance when you decide to leave a group.


## 3. Use the public API (instead of calling the Kovan testnet, call your localhost) to query the status of your own identityCommitment in any of the social groups supported by InterRep before and after you leave the group. Take the screenshots of the responses and paste them to your assignment submission PDF.  


## 4. [Bonus] Suggest a viable solution to make InterRep completely decentralized.


# Question 4: Thinking in ZK


## 1. If you have a chance to meet with the people who built DarkForest and InterRep, what questions would you ask them about their protocols?




# reference

1. [Assignment 3](https://zku.one/course-schedule/assignment-3)
2. [zkDAO – Succinct, Private, Fair](https://open.harmony.one/zkdao-succinct-private-fair)
3. [zku.ONE – 2022 Mar-April Syllabus / Course Schedule](https://zku.one/course-schedule)
