// services/checkConflict.js
import bookingDetails from "../models/bookingModels.models.js";

const findConflictingBooking = async ( meetingRoomId , startTime, endTime) => {
  return bookingDetails.findOne({
    meetingRoomId,
    $or: [
      {
        startTime: { $lt: endTime },
        endTime: { $gt: startTime },
      },
    ],
  });
};

export default findConflictingBooking;
