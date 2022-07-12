// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./interface/IERC20.sol";

contract NTYToken is IERC20 {
    string private _tokenName;
    string private _tokenSymbol;
    uint8 private _tokenDecimals;
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _tokenName = "NTYToken";
        _tokenSymbol = "NTY";
        _tokenDecimals = 8;
        _totalSupply = 6000000000000000;
        _balances[msg.sender] = 100000000000;
    }

    function name() external view override returns (string memory)
    {
        return _tokenName;
    }

    function symbol() external view override returns (string memory)
    {
        return _tokenSymbol;
    }

    function decimals() external view override returns (uint8)
    {
        return _tokenDecimals;
    }

    function totalSupply() public view override returns (uint256)
    {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256)
    {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool)
    {
        require(_balances[msg.sender] >= amount);
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool)
    {
        require(_balances[sender] >= amount);
        require(_allowances[sender][msg.sender] >= amount);
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool)
    {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256)
    {
        return _allowances[owner][spender];
    }
}