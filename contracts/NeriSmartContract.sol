pragma solidity ^0.4.18;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./NeriToken.sol";

/**
 * @title NeriSmartContract Smart Contract
 */
contract NeriSmartContract is Ownable {

    using SafeMath for uint256;

    ERC20 public token; // The token being sold
    uint256 availableTokens;

    address[] addresses;

    function NeriSmartContract() public {
        token = new NeriToken();
        availableTokens = token.balanceOf(this);
    }

    /**
     * @dev fallback function
     */
    function () external payable {

    }

    // Transfer token ownership (only owner)
    function transferTokenOwnership(address _newOwner) public onlyOwner returns(bool success) {
        NeriToken _token = NeriToken(token);
        _token.transferOwnership(_newOwner);

        return true;
    }

    // Send ETH from smart contract (only owner)
    function transferEthFromContract(address _to, uint256 amount) public onlyOwner {
        _to.transfer(amount);
    }

    // Send Tokens from smart contract (only owner)
    function sendToken(address _address, uint256 _amountTokens) public onlyOwner {
        require(availableTokens.sub(_amountTokens) >= 0);

        NeriToken _token = NeriToken(token);
        _token.transfer(_address, _amountTokens);

        availableTokens = availableTokens.sub(_amountTokens);
        addresses.push(_address);
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