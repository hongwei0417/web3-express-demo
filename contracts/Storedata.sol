pragma solidity >=0.4.22 <0.9.0;
//儲存交易者資料
contract Storedata {
    mapping(address => mapping(string => Txn)) public people;

    struct Txn{
        string stock_Name;      //公司名稱
        uint stock_Date;        //當日日期
        uint stock_Id;          //股票代號
        uint stock_NowPrice;    //股票價格
        // uint stock_MostPrice;   //當日最高
        // uint stock_LowestPrice; //當日最低
    }
    
    function addId(address uaddr, string memory txnId, string memory stock_Name, uint stock_Date, uint stock_Id, uint stock_NowPrice) public{
        people[uaddr][txnId] = Txn(stock_Name, stock_Date, stock_Id, stock_NowPrice);
    }
    
    function getId(address uaddr, string memory txnId) public view returns(address,string memory,uint,uint,uint){
        Txn memory t = people[uaddr][txnId]; //txn mapping
        return (uaddr, t.stock_Name, t.stock_Date, t.stock_Id, t.stock_NowPrice);
    }
}