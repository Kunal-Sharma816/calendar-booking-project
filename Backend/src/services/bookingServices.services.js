// services/bookingServices.services.js

import bookingDetails from "../models/bookingModels.models.js";

const findConflictingBooking = async (startTime, endTime) => {
  return bookingDetails.findOne({
    $or: [
      {
        startTime: { $lt: endTime },
        endTime: { $gt: startTime },
      },
    ],
  });
};

export default findConflictingBooking;
