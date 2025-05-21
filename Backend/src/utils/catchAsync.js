function catchAsync(asyncFunction)
{
    return function (req , res , next)
    {
        asyncFunction(req , res , next).catch((error)=>
        {
            next(error);
        });
    };
}

export default catchAsync;