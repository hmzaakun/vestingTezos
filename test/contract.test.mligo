#import "./helper/bootstrap_time.mligo" "Bootstrap"
#import "./helper/assert.mligo" "Assert"
#import "../src/contract.mligo" "MyContract"
// #import "@ligo/fa/lib/fa2/asset/single_asset.impl.mligo" "FA2Contract"

let test_vesting =
    let (admin,user,_,_, _,_,_) = Bootstrap.boot_accounts() in
    let empty_map: (address,MyContract.C.beneficiary) big_map = Big_map.empty in
    let initial_storage: MyContract.C.storage = {
        admin = admin;
        balance = 0n;
        contract_start = false;
        vesting_start = None;
        vesting_period = 0n;
        contract_stopped = false;
        beneficiaries = empty_map;
    } in
    let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
    let beneficiary = user in
    let amount = 50n in
    let empty_beneficiaries: (address,MyContract.C.beneficiary) big_map = Big_map.empty in

    // 1 - Add beneficiary
    let contr = Test.to_contract addr in
    let r = Test.transfer_to_contract contr (Add_beneficiary (beneficiary, amount)) 0tez in
    let () = Assert.tx_success r in
    let storage = Test.get_storage addr in
    let expected_beneficiaries = Big_map.literal [(beneficiary, {total_amount = amount; amount_claimed = 0n;})] in
    let () = assert (storage.beneficiaries = expected_beneficiaries) in

    // 2 - Start contract
    let vesting_start = ("2024-01-04t10:10:10Z": timestamp) in
    let vesting_period = 1n in // 1 day
    let r = Test.transfer_to_contract contr (Start (vesting_start, vesting_period)) 0tez in
    let () = Assert.tx_success r in
    let storage = Test.get_storage addr in
    let () = assert (storage.contract_start = true) in

    // 3 - Fail to kill contract before all beneficiaries claimed
    let () = Test.set_source admin in
    let r = Test.transfer_to_contract contr Kill 0tez in
    let () = Assert.string_failure r "Somoene didn't claim" in

    // 4 - Claim
    let () = Test.set_source user in
    let r = Test.transfer_to_contract contr Claim 0tez in
    let () = Assert.tx_success r in
    let storage = Test.get_storage addr in
    
    // let expected_beneficiary_claimed_balance = amount in 
    // let expected_beneficiary_total_balance = amount in 
    // let () = match Big_map.find_opt beneficiary storage.beneficiaries with
    // | None -> failwith("[Test]: benef not found")
    // | Some {total_amount; amount_claimed} -> 
    //     let () = Test.log amount_claimed in
    //     let () = assert(total_amount = expected_beneficiary_total_balance) in
    //     assert(amount_claimed = expected_beneficiary_claimed_balance)
    // in
    let () = assert (storage.beneficiaries = Big_map.literal [(beneficiary, {total_amount = amount; amount_claimed = amount;})]) in
    
    // 5 - Kill contract
    let () = Test.set_source admin in
    let r = Test.transfer_to_contract contr Kill 0tez in
    let () = Assert.tx_success r in

()