import express from "express"
import { Router } from "express"
import {getAllBookings , getBookingById , createBooking , getBookingsByRoom} from "../controller/bookingController.controller.js"

const router = Router();

router.get("/" , getAllBookings);
router.get("/:bookingId" , getBookingById);
router.post("/", createBooking);
router.get("/room/:meetingRoomId", getBookingsByRoom);


export default router;
