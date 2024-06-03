#[starknet::interface]
trait TestingContractInterface<TContractState> {
    fn emit_event(ref self: TContractState, x: u128) -> u128;
}


#[starknet::contract]
mod TestingContract {
    use core::starknet::event::EventEmitter;
use core::traits::Into;
use mock_contract::some_component::ISC;
    use mock_contract::some_component::SomeComponent;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        scs: SomeComponent::Storage,
    }

    component!(path: SomeComponent, storage: scs, event: scs_event);
    #[abi(embed_v0)]
    impl SCExternalImpl = SomeComponent::SCExternalImpl<ContractState>;

    #[derive(Drop, starknet::Event)]
    struct EventA {
        some_field_1: u128,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        scs_event: SomeComponent::Event,
        event_a: EventA,
    }

    #[abi(embed_v0)]
    impl TestingContractImpl of super::TestingContractInterface<ContractState> {
        fn emit_event(ref self: ContractState, x: u128) -> u128 {
            self.emit(Event::event_a(EventA { some_field_1: 42 }));

            x * 2
        }
    }
}