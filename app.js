import express from "express";
import logger from "morgan";
import appRouter from "./routes/appRouter";
import { connect_to_mongodb } from "./function/db";

require("dotenv").config(); //環境變數
const app = express();

connect_to_mongodb(); //連接MongoDB

app.use(express.json()); //回應能使用json格式
app.use(logger("dev")); //顯示呼叫的api在console畫面

//路由設定
app.use("/app", appRouter);

app.listen(process.env.LISTENING_PORT, () => {
	console.log(`App listening at http://localhost:${process.env.LISTENING_PORT}`);
});

//新的內容
