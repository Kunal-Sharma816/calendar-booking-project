import express from "express"
import { Router } from "express"
import {getAllBookings , getBookingById , createBooking} from "../controller/bookingController.controller.js"

const router = Router();

router.get("/" , getAllBookings);
router.get("/:bookingId" , getBookingById);
router.post("/", createBooking);

export default router;
