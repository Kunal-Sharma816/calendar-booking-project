import mongoose from "mongoose";
console.log(process.env.MONGO_URI)

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("MongoDB connected ");
  } catch (err) {
    console.error("MongoDB connection failed ", err);
    process.exit(1);
  }
};


export default connectDB;