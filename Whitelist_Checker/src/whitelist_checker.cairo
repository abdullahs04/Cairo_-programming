// Whitelist Checker contract - Abdul Moqeet
// The idea is simple: only approved addresses can be on the list.
// The owner (whoever deploys the contract) controls who gets added or removed.
// Anyone can check if an address is whitelisted, but only the owner can change things.

use starknet::ContractAddress;

// defining the interface first so other contracts can also call into this one if needed
#[starknet::interface]
trait IWhitelistChecker<TContractState> {
    fn add_to_whitelist(ref self: TContractState, address: ContractAddress);
    fn remove_from_whitelist(ref self: TContractState, address: ContractAddress);
    fn is_whitelisted(self: @TContractState, address: ContractAddress) -> bool;
    fn get_owner(self: @TContractState) -> ContractAddress;
    fn get_whitelist_count(self: @TContractState) -> u64;
    fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
}

#[starknet::contract]
mod WhitelistChecker {
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use starknet::storage::{
        Map,
        StorageMapReadAccess,
        StorageMapWriteAccess,
        StoragePointerReadAccess,
        StoragePointerWriteAccess,
    };

    #[storage]
    struct Storage {
        owner: ContractAddress,          // who deployed the contract
        whitelist: Map<ContractAddress, bool>,  // address => is it allowed?
        whitelist_count: u64,            // how many addresses are currently approved
    }

    // events so we can track what happened on-chain without reading storage manually
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        AddressWhitelisted: AddressWhitelisted,
        AddressRemoved: AddressRemoved,
        OwnershipTransferred: OwnershipTransferred,
    }

    #[derive(Drop, starknet::Event)]
    struct AddressWhitelisted {
        #[key]
        address: ContractAddress,
    }

    #[derive(Drop, starknet::Event)]
    struct AddressRemoved {
        #[key]
        address: ContractAddress,
    }

    #[derive(Drop, starknet::Event)]
    struct OwnershipTransferred {
        #[key]
        previous_owner: ContractAddress,
        #[key]
        new_owner: ContractAddress,
    }

    // runs once when deployed, sets the owner
    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
        self.whitelist_count.write(0);
    }

    // helper to block non-owners from calling restricted functions
    fn assert_only_owner(self: @ContractState) {
        let caller = get_caller_address();
        let owner = self.owner.read();
        assert(caller == owner, 'Caller is not the owner');
    }

    #[abi(embed_v0)]
    impl WhitelistCheckerImpl of super::IWhitelistChecker<ContractState> {

        // adds an address to the whitelist, only owner can do this
        // skips silently if address is already added (avoids messing up the count)
        fn add_to_whitelist(ref self: ContractState, address: ContractAddress) {
            assert_only_owner(@self);

            if !self.whitelist.read(address) {
                self.whitelist.write(address, true);
                self.whitelist_count.write(self.whitelist_count.read() + 1);
                self.emit(AddressWhitelisted { address });
            }
        }

        // removes an address, again only owner
        // skips if it wasn't on the list to begin with
        fn remove_from_whitelist(ref self: ContractState, address: ContractAddress) {
            assert_only_owner(@self);

            if self.whitelist.read(address) {
                self.whitelist.write(address, false);
                self.whitelist_count.write(self.whitelist_count.read() - 1);
                self.emit(AddressRemoved { address });
            }
        }

        // anyone can call this to check if an address is approved
        fn is_whitelisted(self: @ContractState, address: ContractAddress) -> bool {
            self.whitelist.read(address)
        }

        // read the owner address
        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }

        // Returns the total number of addresses currently on the whitelist.
        // Public read — anyone can call this.
        fn get_whitelist_count(self: @ContractState) -> u64 {
            self.whitelist_count.read()
        }

        // Transfers ownership of the contract to `new_owner`.
        // Only the current owner may call this.
        // Emits an event recording both the old and new owner.
        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            assert_only_owner(@self);

            let previous_owner = self.owner.read();
            self.owner.write(new_owner);

            // Log the ownership change on-chain for transparency
            self.emit(OwnershipTransferred { previous_owner, new_owner });
        }
    }
}
