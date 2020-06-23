package com.mobilecourse.backend.controllers;


import com.mobilecourse.backend.dao.ErrandDao;
import com.mobilecourse.backend.entity.Errand;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/query")
public class QueryController extends CommonController {
    @Autowired
    private ErrandDao errandDao;
    @RequestMapping(value = {"/errand"}, method = {RequestMethod.GET}) //这是用来处理请求地址映射的注解
    public ResponseEntity<ResultModel> queryResult(
            @RequestParam(required = false, defaultValue = "") String strLike,
            @RequestParam(required = false, defaultValue = "") String fromAddr,
            @RequestParam(required = false, defaultValue = "") String toAddr,
            @RequestParam(required = false, defaultValue = "") String minBonus,
            @RequestParam(required = false, defaultValue = "") String maxBonus
            )
    {
        try {
            List<Errand>  errands = errandDao.queryErrand(strLike,fromAddr, toAddr, minBonus, maxBonus);
            if (errands != null) {
                return wrapperOKResp(errands);
            }
        } catch (Exception e) {
            return wrapperErrorResp(ResultModel.QUERY_FAIL, "查询失败");
        }
        return wrapperErrorResp(ResultModel.QUERY_FAIL, "查询失败");
    }
}
