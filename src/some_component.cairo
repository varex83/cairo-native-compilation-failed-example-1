#[starknet::interface]
pub trait ISC<TContractState> {
    fn get_flag(ref self: TContractState) -> u128;
    fn set_flag(ref self: TContractState, flag: u128);
}

#[starknet::component]
pub mod SomeComponent {
    #[storage]
    pub struct Storage {
        flag: u128
    }

    #[embeddable_as(SCExternalImpl)]
    pub impl ExternalImpl<
        TContractState,
        +HasComponent<TContractState>,
        +Drop<TContractState>,
    > of super::ISC<ComponentState<TContractState>> {
        fn get_flag(ref self: ComponentState<TContractState>) -> u128 {
            self.flag.read()
        }

        fn set_flag(ref self: ComponentState<TContractState>, flag: u128) {
            self.flag.write(flag);
        }
    }
}
