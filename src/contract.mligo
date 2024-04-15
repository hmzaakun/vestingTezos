module C = struct

    type beneficiary = {
        total_amount: nat;
        amount_claimed: nat;
    }

    type storage = {
        admin: address;
        balance: nat; // Variable to replace the FA2 balance
        contract_start: bool;
        vesting_start: timestamp option;
        vesting_period: nat;
        contract_stopped: bool;
        beneficiaries: (address, beneficiary) big_map;
    }

    type res = operation list * storage

    let verify_contract_status (s: storage): unit =
        if s.contract_start = false then
            failwith("Contract not started")
        else
            if s.contract_stopped = true then
                failwith("Contract stopped")
            else
                ()

    let only_admin (s: storage): unit =
        if Tezos.get_sender () <> s.admin then
            failwith("Only admin can call this function")
        else
            ()

    [@entry] let start (vesting_start, vesting_period: timestamp*nat) (s: storage): res =
    let () = only_admin s in
    if s.contract_stopped = true then
        failwith("Contract stopped")
    else
        if s.contract_start = true then
            failwith("Contract already started")
        else
    let vesting_start = Some vesting_start in
    let vesting_period = vesting_period in
    [], { s with contract_start = true; vesting_start; vesting_period }

    [@entry] let kill (_: unit) (s: storage): res =
        let () = only_admin s in
        let () = verify_contract_status s in
        if(s.balance > 0n) then
            failwith("Somoene didn't claim")
        else
    [], { s with contract_stopped = true }

    [@entry] let add_beneficiary (to,amount: address*nat) (s: storage): res =
        let () = only_admin s in
        if s.contract_start = true then
            failwith("Contract already started")
        else
            let beneficiary = { total_amount = amount; amount_claimed = 0n } in
            let beneficiaries = Big_map.add to beneficiary s.beneficiaries in
            // add FA2 transfer
            [], { s with beneficiaries ; balance = s.balance + amount }

    [@entry] let claim (_: unit) (s: storage): res =
        let () = verify_contract_status s in
        let beneficiary = Big_map.find (Tezos.get_sender () : address) s.beneficiaries in
        let vesting_start = match s.vesting_start with
            | Some x -> x
            | None -> failwith("Vesting start not set") in
        let amount_to_claim = abs((beneficiary.total_amount / s.vesting_period * (Tezos.get_now () - vesting_start) / 86400) - beneficiary.amount_claimed) in
        let new_beneficiary: beneficiary = { total_amount = beneficiary.total_amount; amount_claimed = beneficiary.amount_claimed + amount_to_claim } in
        let new_beneficiaries = Big_map.update (Tezos.get_sender () : address) (Some new_beneficiary) s.beneficiaries in
        // Add FA2 transfer
        [], { s with balance = abs(s.balance - amount_to_claim); beneficiaries = new_beneficiaries }

end