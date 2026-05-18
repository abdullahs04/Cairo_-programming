# Whitelist Checker

Student: Abdul Moqeet

---

## What is this?

A whitelist is basically a list of approved addresses. The contract owner decides who goes on the list and who gets removed. Anyone can check whether a given address is whitelisted, but only the owner can actually change the list.

You see this pattern a lot in real projects — NFT mints where only certain wallets can mint early, token sales where only KYC-verified users can participate, or DAOs where only members can vote. The core idea is always the same: a trusted party manages a set of allowed addresses.

---

## What the contract does

There are 6 functions:

- `add_to_whitelist(address)` — owner adds someone to the list
- `remove_from_whitelist(address)` — owner removes someone
- `is_whitelisted(address)` — anyone can check if an address is approved, returns true/false
- `get_owner()` — returns who owns the contract
- `get_whitelist_count()` — returns how many addresses are currently on the list
- `transfer_ownership(new_owner)` — owner can hand over control to someone else

I also added events for every state change (add, remove, ownership transfer) so the history is logged on-chain.

---

## Cairo concepts I used

**`#[starknet::interface]` trait** — I defined the public interface separately from the implementation. This is the standard way to do it in Cairo and also lets other contracts call into this one using a dispatcher.

**`Storage` struct with `Map`** — Starknet storage works as a key-value store. I used `Map<ContractAddress, bool>` to track which addresses are approved and a `u64` counter to keep track of how many are currently on the list.

**`get_caller_address()`** — this gives you the address of whoever is sending the transaction. I use it inside `assert_only_owner` to block unauthorized calls.

**`assert(condition, message)`** — like `require` in Solidity. If the condition fails the whole transaction reverts. I use it to enforce that only the owner can modify the whitelist.

**Events** — declared as an enum with `#[starknet::Event]`. Each variant is a different event type. The `#[key]` attribute makes a field indexed so tools can filter events efficiently.

**`#[constructor]`** — runs once at deployment. I set the owner and initialize the count to 0 here.

**`#[abi(embed_v0)]`** — marks the impl block that gets exported as the contract's public ABI.

---

## Project files

```
Abdul_Moqeet_Whitelist_Checker/
├── Scarb.toml
├── guide.md
└── src/
    ├── lib.cairo
    └── whitelist_checker.cairo
```

---

## How to build

Install Scarb first, then:

```bash
cd Abdul_Moqeet_Whitelist_Checker
scarb build
```

The compiled artifacts go into `target/dev/`.

---

## How to deploy and test on Sepolia

You need Starkli and a funded Sepolia account.

**Build:**
```bash
scarb build
```

**Declare the class:**
```bash
starkli declare ./target/dev/whitelist_checker_WhitelistChecker.contract_class.json \
  --account ./starkli-wallet/account.json \
  --keystore ./starkli-wallet/keystore.json \
  --rpc <your-rpc-url>
```
Save the class hash it prints.

**Deploy (pass your own account address as the owner):**
```bash
starkli deploy <CLASS_HASH> <YOUR_ACCOUNT_ADDRESS> \
  --account ./starkli-wallet/account.json \
  --keystore ./starkli-wallet/keystore.json \
  --rpc <your-rpc-url>
```
Save the contract address.

**Add an address:**
```bash
starkli invoke <CONTRACT_ADDRESS> add_to_whitelist <ADDRESS> \
  --account ./starkli-wallet/account.json \
  --keystore ./starkli-wallet/keystore.json \
  --rpc <your-rpc-url>
```

**Check if whitelisted:**
```bash
starkli call <CONTRACT_ADDRESS> is_whitelisted <ADDRESS> --rpc <your-rpc-url>
```
Returns `0x1` for true, `0x0` for false.

**Remove an address:**
```bash
starkli invoke <CONTRACT_ADDRESS> remove_from_whitelist <ADDRESS> \
  --account ./starkli-wallet/account.json \
  --keystore ./starkli-wallet/keystore.json \
  --rpc <your-rpc-url>
```

**Important:** make sure the account you deploy with is the same one you use for invoke calls, otherwise the owner check fails and the transaction reverts.

---

## Things I noticed while building this

I kept the `add` and `remove` functions idempotent — if you try to add an address that's already on the list it just does nothing instead of failing. Same for remove. This keeps the count accurate and avoids weird errors if someone calls the function twice by mistake.

I also added `transfer_ownership` because in real contracts you almost always need a way to hand over control without redeploying everything. It just overwrites the owner field and emits an event.

The hardest part to get right in Cairo compared to Solidity is the storage access — you have to import the right traits (`StorageMapReadAccess`, `StoragePointerWriteAccess`, etc.) explicitly, otherwise reads and writes don't compile. Once I understood that pattern it made sense.
