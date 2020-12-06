pragma solidity ^0.5.0;
// ----------------------------------------------------------------------------
// Библиотека безопасных вычислений
// ----------------------------------------------------------------------------
library SafeMath {

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        
	return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

// ----------------------------------------------------------------------------
// Стандартный интерфейс ERC20
//
// ----------------------------------------------------------------------------
contract ERC20Interface {
    using SafeMath for uint256;
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}




contract TestToken is ERC20Interface {
    string public name;    //Наименование токена
    string public symbol;  //Тикер 
    uint8 public decimals; //Количество десятичных знаков после запятой
    
//наименование эмитента 
string public nameEmitent;

// номинальная цена токена 
string public tokenNominal;

// назначение токена 
string public tokenPurpose;

// обеспечение токена
string public tokenSuply;

// идентификатор эмитента
string public idEmitent;

// идентификатор пользовательской сети 
string public idUserNet;

// код доступа в токен 
string public kodTokenEntry;

// цифровая подпись эмитента 
string public emitentSign;

// идентификатор пользователя
string public idUser;
    
    
    
   
    uint256 public _totalSupply;
   
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
   
    /*
     * Constrctor function
     *
     * Инициализация контракта с перечислением всех токенов владельцу
     */
    constructor() public {
        name = "Test2SocialNet";
        symbol = "TSN2";
        decimals = 4;
        _totalSupply = 3000000; //Количество токенов 300 с учетом 4 знаков после запятой
       
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
   
    function totalSupply() public view returns (uint) {
        return _totalSupply  - balances[address(0)];
    }
   
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }
   
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
   
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
   
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
   
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
    
    // условие сжигания токена- необходимо определить условие и порядок сжигания токенов 
    // _value Количество сжигаемых токенов.
   
  function burn(uint _value) public {
    require(_value > 0);
    address burner = msg.sender;
    balances[burner] = balances[burner].sub(_value);
    _totalSupply = _totalSupply.sub(_value);
    emit Burn(burner, _value);
  }
 
  event Burn(address indexed burner, uint indexed value);
}