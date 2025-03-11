// // SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {WegelToken} from "../src/WegelToken.sol";

contract MerkleAirdropTest is Test {
    MerkleAirdrop public airdrop;
    WegelToken public token;
    bytes32 public ROOT =
        0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT = 25 * 1e18;
    uint256 public AMOUNT_TO_SEND = AMOUNT * 4;
    bytes32 proofOne =
        0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
    bytes32 proofTwo =
        0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] public PROOF = [proofOne, proofTwo];
    address user;
    uint256 userPrivKey;

    function setUp() public {
        token = new WegelToken();
        airdrop = new MerkleAirdrop(ROOT, token);
        token.mint(token.owner(), AMOUNT_TO_SEND)(
            user,
            userPrivKey
        ) = makeAddrAndKey("user");
    }
    function testUsersCanClaim() public view {
        uint256 startingBalance = token.balanceOf(user);

        vm.prank(user);
        airdrop.claim(user, AMOUNT, PROOF);

        uint256 endingBalance = token.balanceOf(user);
        console.log("Ending Balance", endingBalance);
        assertEq(endingBalance - startingBalance, AMOUNT);
    }
}
