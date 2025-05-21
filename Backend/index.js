import express from "express"
import dotenv from "dotenv"
import morgan from "morgan";
import mongoose from "mongoose";

import connectDB from "./src/config/mongodb.config.js";
import bookingRoutes from "./src/routes/bookingRoutes.routes.js"
import globalErrorHandler from './src/middlewares/globalErrorHandler.js';
import notFound from './src/middlewares/notfound.js'
import cors from "cors"



dotenv.config({path: "./.env"})

const app = express();
app.use(cors());

app.use(express.json()) 
app.use(morgan('dev'))

app.use('/api/bookings' , bookingRoutes);

app.use(notFound);
app.use(globalErrorHandler);

const PORT = process.env.PORT || 5000;

app.listen(PORT , ()=>
{
    connectDB();
    console.log(`Server is running on http://localhost:${PORT}`)
})

app.listen()