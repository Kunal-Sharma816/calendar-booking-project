import appError from "../utils/appError.js";

export default function globalErrorHandler(err , req , res , next)
{
    console.log('! Errors:', err);

    const statusCode= err.statusCode || 500     
    const message = err.message || 'Internal Server Error'
    
    res.status(statusCode).json({
    status: 'error',
    message,
  });
}