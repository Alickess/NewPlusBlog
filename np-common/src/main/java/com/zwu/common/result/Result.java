package com.zwu.common.result;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "全局统一返回结果")
public class Result<T>  {

    @ApiModelProperty(value = "返回码")
    private Integer code;

    @ApiModelProperty(value = "返回消息")
    private String message;

    @ApiModelProperty(value = "返回数据")
    private T data;

    public static <T> Result<T> success(int code,String message,T data){
        Result<T> result = new Result<T>();
        result.setCode(code);
        result.setMessage(message);
        result.setData(data);
        return result;
    }
    public static <T> Result<T> success(ResultCodeEnum resultCodeEnum,T data){
        Result<T> result = new Result<T>();
        result.setCode(resultCodeEnum.getCode());
        result.setMessage(resultCodeEnum.getMessage());
        result.setData(data);
        return result;
    }
    public static <T> Result<T> success(T data){
        return success(ResultCodeEnum.SUCCESS,data);
    }
    public static <T> Result<T> success(){
        return success(ResultCodeEnum.SUCCESS,null);
    }

    public static <T> Result<T> fail(int code,String message,T data){
        Result<T> result = new Result<T>();
        result.setCode(code);
        result.setMessage(message);
        result.setData(data);
        return result;
    }
    public static <T> Result<T> fail(ResultCodeEnum resultCodeEnum,T data){
        Result<T> result = new Result<T>();
        result.setCode(resultCodeEnum.getCode());
        result.setMessage(resultCodeEnum.getMessage());
        result.setData(data);
        return result;
    }
    public static <T> Result<T> fail(T data){
        return fail(ResultCodeEnum.FAIL,data);
    }
    public static <T> Result<T> fail(){
        return fail(ResultCodeEnum.FAIL,null);
    }

}
