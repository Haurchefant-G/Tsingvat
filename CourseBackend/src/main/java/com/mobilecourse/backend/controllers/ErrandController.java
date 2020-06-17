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
@RequestMapping("/errand")
public class ErrandController extends CommonController {
    @Autowired
    ErrandDao errandDao;

    @RequestMapping(value = "", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createErrand(@RequestBody Errand errand){
        errand.setUuid(this.getUuid());
        errand.setCreated(this.getCurrentTime());
        errandDao.createErrand(errand);
        return wrapperOKResp(errand);
    }

    @RequestMapping(value = "", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> modifyErrand(@RequestBody Errand errand){
        errandDao.modifyErrand(errand);
        return wrapperOKResp(errand);
    }

    @RequestMapping(value = "", method = {RequestMethod.DELETE})
    public ResponseEntity<ResultModel> deleteErrand(@RequestParam String uuid){
        errandDao.deleteErrand(uuid);
        return wrapperOKResp(null);
    }

    @RequestMapping(value = "/2", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> takeErrand(@RequestBody Errand errand){
        if(errand.getTaker() == null)
            return wrapperErrorResp(ResultModel.ERRAND_TAKE_FAIL, "should specify taker!");
        errand.setTakeTime(this.getCurrentTime());
        errandDao.takeErrand(errand);
        return wrapperOKResp(errand);
    }

    // 获取自己发布的任务
    @RequestMapping(value="/1/{username}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getErrands(@PathVariable("username") String username){
        List<Errand> errands = errandDao.getErrands(username);
        return wrapperOKResp(errands);
    }

    // 获取当前自己的接单的
    @RequestMapping(value = "/2/{username}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getTakeErrands(@PathVariable("username") String username){
        List<Errand> errands = errandDao.getTakeErrands(username);
        return wrapperOKResp(errands);
    }
}
