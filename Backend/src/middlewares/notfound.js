
import appError from '../utils/appError.js';

export default function notFound(req, res, next) {
  next(new appError(`Not found: ${req.originalUrl}`, 404));
}
