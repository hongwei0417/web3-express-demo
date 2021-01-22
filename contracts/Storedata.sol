pragma solidity >=0.4.22 <0.9.0;
import "./UserManage.sol";

//儲存交易者資料
contract StoreStockinformation {
    
    UserManagement UM; //global
    // string _name;//哪位使用者
    
    constructor(address um_addr) public {
        UserManagement um = UserManagement(um_addr); //get contract
        UM = um;
    }

    uint money = 2000000;
    
    mapping(string => mapping(string => Txn)) public stock;
    struct Txn{
        string stock_Name;      //公司名稱
        uint stock_Id;          //股票代號
        uint stock_NowPrice;    //股票價格
        uint stock_Number;      //股票數量
    }
    
    mapping(string => MoneyTxn) public property;//帳號對到持有金額
    struct MoneyTxn{
        uint cash;
        uint stock_value;
    }
    
    //儲存股票資料
    function setStockId(string memory account, string memory stockId, string memory stock_Name, uint stock_Id, uint stock_NowPrice, uint stock_Number) public{
        if(UM.userIsExist(account)) {
            stock[account][stockId] = Txn(stock_Name, stock_Id, stock_NowPrice, stock_Number); 
        }
    }

    function getStockId(string memory account, string memory stockId) public view returns(string memory, uint, uint, uint){
        Txn memory t = stock[account][stockId]; //txn mapping
        return (t.stock_Name, t.stock_Id, t.stock_NowPrice, t.stock_Number);
    }
    
    //處理交易資料
    function tradeStock(string memory account, string memory stockId, string memory stock_Name, uint stock_Id, uint stock_NowPrice, uint stock_Number) public{
        Txn memory t1 = stock[account][stockId]; //txn mapping
        //持有金額(原本就在)
        //數量*價格 = 花費金額(傳入)
        //持有金額 - 花費金額 = 現在持有金額(更新持有金額)
        //(如果持有金額 < 花費金額 => 交易失敗)
        //購買價格
        //購買股票代號、企業名稱、股票數量
    }
}