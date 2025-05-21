import mongoose from "mongoose";

const BookingSchema = new mongoose.Schema({
    userId:{
        type: String,
        required: [true, "User ID is required"],
    },

    startTime: {
        type : Date,
        required: [true, "Start time is required"],
        
    },
    endTime: {
        type: Date,
        equired: [true, "End time is required"],
    }
});


const bookingDetails = mongoose.model("bookingDetails", BookingSchema);
export default bookingDetails