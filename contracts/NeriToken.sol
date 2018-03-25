pragma solidity ^0.4.18;

import "./Ownable.sol";
import "./PausableToken.sol";
import "./BurnableToken.sol";
import "./FreezableToken.sol";

/**
 * @title NeriToken
 */
contract NeriToken is FreezableToken, PausableToken, BurnableToken {
    string public name = "Neritoken";
    string public symbol = "NERI";
    uint8 public decimals = 18;

    uint256 public constant INITIAL_SUPPLY = 100 ether; //To change

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    function NeriToken() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }
}