pragma solidity ^0.8.9;


contract Thoritos {
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    
    address public admin;
    
    string public name = "Thoritos";
    string public symbol = "THOR";
    uint public decimal = 8;
    uint public totalSupply = 100000 * 10 ** 8;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor() {
        
        balances[msg.sender] = totalSupply;
        
        admin = msg.sender;
        //_mint(msg.sender, totalSupply);
        
    }
    
    function balanceOf(address owner) public view returns(uint) {
        
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool) {
        
        require(balanceOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool) {
       
        require(balanceOf(from) >= value, 'balance too low');
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[from] -= value;
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
       
        allowance[msg.sender][spender] = value;
        return true;
    }
    
     function _mint(address owner, uint value) internal virtual {
        require(owner != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), owner, value);

        totalSupply += value;
        balances[owner] += value;
        
        _afterTokenTransfer(address(0), owner, value);
    }
    
     function _burn(address owner, uint value) internal virtual {
        require(owner != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(owner, address(0), value);

        uint accountBalance = balances[owner];
        require(accountBalance >= value, "ERC20: burn amount exceeds balance");
        unchecked {
            balances[owner] = accountBalance - value;
        }
        
        totalSupply -= value;

        
        _afterTokenTransfer(owner, address(0), value);
    }
   
        function _beforeTokenTransfer(address from, address to, uint value) internal view {}

   
        function _afterTokenTransfer( address from, address to, uint value) internal view {}
         
    function mint(address to , uint value) external {
        require(msg.sender == admin , 'Only Admin');
        _mint(to , value);
       
    }
   
    function burn(uint value) external {
       
        _burn(msg.sender , value);
    }
        
}