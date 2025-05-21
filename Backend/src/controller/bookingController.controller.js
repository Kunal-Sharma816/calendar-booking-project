import bookingDetails from "../models/bookingModels.models.js";
import catchAsync from "../utils/catchAsync.js";
import AppError from "../utils/appError.js";
import findConflictingBooking from "../services/bookingServices.services.js";

// GET /api/bookings - Get all bookings
export const getAllBookings = catchAsync(async (req, res) => {
  const bookings = await bookingDetails.find();
  res.status(200).json(bookings);
});

// GET /api/bookings/:bookingId - Get a booking by ID
export const getBookingById = catchAsync(async (req, res, next) => {
  const bookingId = req.params.bookingId;
  const booking = await bookingDetails.findById(bookingId);

  if (!booking) {
    return next(new AppError("Booking not found", 404));
  }

  res.status(200).json(booking);
});

// POST /api/bookings - Create a new booking
export const createBooking = catchAsync(async (req, res, next) => {
  const { userId, meetingRoomId, startTime, endTime } = req.body;

  if (!["room1", "room2", "room3"].includes(meetingRoomId)) {
    return next(new AppError("Invalid meeting room ID", 400));
  }

  // Validate required fields
  if (!userId || !startTime || !endTime) {
    return next(new AppError("All fields are required", 400));
  }

  // Validate date formats
  const start = new Date(startTime);
  const end = new Date(endTime);

  if (isNaN(start) || isNaN(end)) {
    return next(new AppError("Invalid time format", 400));
  }

  if (start >= end) {
    return next(new AppError("Start time must be before end time", 400));
  }

  // Pass userId correctly here
  const conflictingBooking = await findConflictingBooking( meetingRoomId, start, end);
  if (conflictingBooking) {
    return next(
      new AppError(
        `Booking conflict: You already have a booking from ${conflictingBooking.startTime} to ${conflictingBooking.endTime}`,
        409
      )
    );
  }

  // Create the booking
  const newBooking = await bookingDetails.create({
    userId,
    meetingRoomId,
    startTime,
    endTime,
  });

  res.status(201).json(newBooking);
});


// GET /api/booking/room/:meetingRoomId
export const getBookingsByRoom = catchAsync(async (req, res, next) => {
  const { meetingRoomId } = req.params;

  const bookings = await bookingDetails.find({ meetingRoomId });

  if (!bookings || bookings.length === 0) {
    return next(new AppError("No bookings found for this meeting room", 404));
  }

  res.status(200).json({
    status: "success",
    results: bookings.length,
    data: bookings,
  });
});

