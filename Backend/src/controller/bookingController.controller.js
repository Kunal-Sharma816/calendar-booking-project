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
  const { userId, startTime, endTime } = req.body;

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

  // Check for booking conflicts
  const conflictingBooking = await findConflictingBooking(startTime, endTime);
  if (conflictingBooking) {
    return next(new AppError("Booking conflicts with an existing booking", 409));
  }

  // Create the booking
  const newBooking = await bookingDetails.create({
    userId,
    startTime,
    endTime,
  });

  res.status(201).json(newBooking);
});
