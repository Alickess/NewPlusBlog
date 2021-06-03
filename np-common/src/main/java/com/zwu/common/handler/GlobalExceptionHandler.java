package com.zwu.common.handler;

import com.zwu.common.exception.BlogException;
import com.zwu.common.result.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result error(Exception e) {
        e.printStackTrace();
        return Result.fail();
    }

    @ExceptionHandler(BlogException.class)
    @ResponseBody
    public Result error(BlogException e) {
        e.printStackTrace();
        return Result.fail();
    }
}
