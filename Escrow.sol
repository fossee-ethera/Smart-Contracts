pragma solidity ^0.5.0;
import './ExampleToken.sol';

contract Escrow
{
    ExampleToken token;
    enum State {Requested,Process,Validated}
    uint public count;
    struct Verify{
        address validator;
        address candidate;
        string sign;
        uint request_number;
        State state;
    }
    mapping(uint=> Verify) public mark;
    
    event Success(address validator, string sign);
    
    constructor(ExampleToken _token) public {
        token=_token;
        count=0;
    }
    
    function Request() public{
        count+=1;
        mark[count].candidate=msg.sender;
        mark[count].state=State.Requested;
        mark[count].request_number=count;
        token.approve1(mark[count].candidate,address(this),10);
        token.transferFrom1(mark[count].candidate,address(this),10);
    }
    
    function ForwardRequest(uint i,address _validator) public{
        require(mark[i].state==State.Requested);
        mark[i].validator=_validator;
        mark[i].state=State.Process;
    }
    
    function Validate(uint j, string memory _sign) public validator(j) {
        token.approve1(address(this),msg.sender,10);
        mark[j].sign=_sign;
        token.transferFrom1(address(this),msg.sender,10);
        emit Success(mark[j].validator,mark[j].sign);
        mark[j].state=State.Validated;
    }
    
    function reject(uint j) public validator(j){
        token.approve1(address(this),msg.sender,5);
        token.approve1(address(this),mark[j].candidate,5);
        token.transferFrom1(address(this),msg.sender,5);
        token.transferFrom1(address(this),mark[j].candidate,5);
        mark[j].state=State.Validated;
    }
    
    modifier validator(uint j){
        require(mark[j].request_number==j,'request_number not same.');
        require(mark[j].state==State.Process,'State is not same');
        require(mark[j].validator==msg.sender,'You are not authorized.');
        _;
    }
    
    function getSign(uint j) public view returns (string memory) {
        return mark[j].sign;
    }
}
