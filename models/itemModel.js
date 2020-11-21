import mongoose, { SchemaTypes } from "mongoose";
const Schema = mongoose.Schema;

//資料庫定義模型
const itemSchema = new Schema(
	{
		key: {
			type: String,
			required: true,
		},
		value: {
			type: String,
			required: true,
		},
	},
	{
		timestamps: true,
	}
);

const ItemSchema = mongoose.model("Items", itemSchema, "items");

export default ItemSchema;
