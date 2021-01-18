pragma solidity >=0.4.22 <0.9.0;

contract UserManagement {
    
    mapping(string => userinformation) public person;
    
    struct userinformation{
        string _username;       //使用者名稱
        string _userpassword;   //使用者密碼
        string _usergrade;      //使用者學年
        string _usermajor;      //使用者科系
    }
    //使用者註冊
    function adduser(string memory _useraccount, string memory _username, string memory _userpassword, string memory _usergrade, string memory _usermajor) public{
        person[_useraccount] = (userinformation(_username, _userpassword, _usergrade, _usermajor));     
    }
    //觀看註冊是否成功
    function getuser(string memory _useraccount) public view returns(string memory, string memory, string memory, string memory, string memory){
        userinformation memory ui = person[_useraccount];
        return (ui._username, _useraccount, ui._userpassword, ui._usergrade, ui._usermajor);
    }
    
    int a=0;//測試登入機制
    //使用者登入
    function inputuser(string memory account, string memory password) public{
        if(keccak256(abi.encodePacked(password)) == keccak256(abi.encodePacked(person[account]._userpassword))){
            //登入成功
            a=1;
        }
        else{
            //密碼錯誤
            a=2;
        }
    }
    //測試登入機制
    function geta() public view returns(int){
        return a;
    }
}