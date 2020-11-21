import express from "express";
import { connect_to_web3 } from "../function/web3";
import { getContractInstance, contract_call, contract_send } from "../function/contract";
import APP_ABI_JSON from "../contracts/app.json";
import {
	add_item_to_mongodb,
	update_item_from_mongodb,
	delete_item_from_mongodb,
} from "../function/db";

//express 路由
const router = express.Router();

//讀取操作
router.get("/getItem/:key", async (req, res) => {
	const { key } = req.params;
	const web3 = await connect_to_web3();
	const accounts = await web3.eth.getAccounts();
	const contract = await getContractInstance(
		web3,
		APP_ABI_JSON,
		process.env.APP_CONTRACT_ADDRESS
	);
	//取得區塊鏈上資料(無更改狀態所有使用call function)
	const result = await contract_call(contract, "getItem", [key]);
	if (result) {
		res.json(result);
	} else {
		res.json("沒有此物件");
	}
});

//新增操作
router.post("/addItem", async (req, res) => {
	const { key, value } = req.body;
	const web3 = await connect_to_web3();
	const accounts = await web3.eth.getAccounts();
	const contract = await getContractInstance(
		web3,
		APP_ABI_JSON,
		process.env.APP_CONTRACT_ADDRESS
	);
	try {
		//新增進區塊鏈(鏈上)
		await contract_send(contract, "addItem", [key, value], {
			from: accounts[0],
			gas: 6000000,
		});

		//新增進資料庫(鏈下)
		await add_item_to_mongodb(key, value);
		res.json("新增成功!");
	} catch (e) {
		res.json("新增操作發生錯誤!");
	}
});

//更新操作
router.put("/updateItem", async (req, res) => {
	const { key, value } = req.body;
	const web3 = await connect_to_web3();
	const accounts = await web3.eth.getAccounts();
	const contract = await getContractInstance(
		web3,
		APP_ABI_JSON,
		process.env.APP_CONTRACT_ADDRESS
	);
	try {
		//更新區塊鏈(鏈上)
		await contract_send(contract, "updateItem", [key, value], {
			from: accounts[0],
			gas: 6000000,
		});

		//更新資料庫(鏈下)
		await update_item_from_mongodb(key, value);
		res.json("更新成功!");
	} catch (e) {
		res.json("更新操作發生錯誤!");
	}
});

//刪除操作
router.delete("/deleteItem/:key", async (req, res) => {
	const { key } = req.params;
	const web3 = await connect_to_web3();
	const accounts = await web3.eth.getAccounts();
	const contract = await getContractInstance(
		web3,
		APP_ABI_JSON,
		process.env.APP_CONTRACT_ADDRESS
	);
	try {
		//刪除區塊鏈上資料(鏈上)
		await contract_send(contract, "deleteItem", [key], {
			from: accounts[0],
			gas: 6000000,
		});

		//刪除資料庫資料(鏈下)
		await delete_item_from_mongodb(key);
		res.json("刪除成功!");
	} catch (e) {
		res.json("刪除操作發生錯誤!");
	}
});

export default router;
