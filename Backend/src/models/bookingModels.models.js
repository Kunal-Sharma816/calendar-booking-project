import mongoose from "mongoose";

const BookingSchema = new mongoose.Schema({
    
    userId:{
        type: String,
        required: [true, "User ID is required"],
    },
    meetingRoomId:{
        type: String,
        required: [true , "Meeting room is required"],
        enum: ["room1", "room2" , "room3" , "room4"],
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