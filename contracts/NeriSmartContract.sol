pragma solidity ^0.4.18;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./NeriToken.sol";

/**
 * @title NeriSmartContract Smart Contract
 */
contract NeriSmartContract is Ownable {

    using SafeMath for uint256;

    NeriToken public token; // The token being sold

    address[] addresses;

    function NeriSmartContract(address _contractAddress) public {
        require(_contractAddress != 0x0);
        token = NeriToken(_contractAddress);
    }

    function() public payable {
        revert();
    }

    // Send Tokens from smart contract (only owner)
    function sendToken(address _address, uint256 _amountTokens) public onlyOwner returns(bool success){
        require(_address != 0x0);
        require(token.transfer(_address, _amountTokens));

        addresses.push(_address);

        return true;
    }

    function sendTokens(address[] _addresses, uint256[] _amountTokens) public onlyOwner returns(bool success) {
        require(_addresses.length > 0);
        require(_amountTokens.length > 0);
        require(_addresses.length  == _amountTokens.length);

        for (uint256 i = 0; i < _addresses.length; i++) {
            sendToken(_addresses[i], _amountTokens[i]);
        }

        return true;
    }

    function getAddresses() public onlyOwner view returns (address[] )  {
        return addresses;
    }
}