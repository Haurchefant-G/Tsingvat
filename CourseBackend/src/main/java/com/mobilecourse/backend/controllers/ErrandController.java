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

    @RequestMapping(value = "/create", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createErrand(@RequestBody Errand errand){
        errand.setUuid(this.getUuid());
        errand.setCreated(this.getCurrentTime());
        errandDao.createErrand(errand);
        return wrapperOKResp(errand);
    }

    @RequestMapping(value = "/modify", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> modifyErrand(@RequestBody Errand errand){
        errandDao.modifyErrand(errand);
        return wrapperOKResp(errand);
    }

    @RequestMapping(value = "/delete", method = {RequestMethod.DELETE})
    public ResponseEntity<ResultModel> deleteErrand(@RequestParam String uuid){
        errandDao.deleteErrand(uuid);
        return wrapperOKResp(null);
    }

    @RequestMapping(value = "/take", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> takeErrand(@RequestBody Errand errand){
        if(errand.getUuid() == null || errand.getTaker() == null)
            return wrapperErrorResp(ResultModel.ERRAND_TAKE_FAIL, "should specify taker!");
        errand.setTakeTime(this.getCurrentTime());
        errandDao.takeErrand(errand);
        return wrapperOKResp(errand);
    }

    // Errand参数实际上只需要errand的uuid，但是传输进入uuid也会直接
    @RequestMapping(value = "/finish", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> finishErrand(@RequestBody Errand errand){
        if(errand.getUuid() == null)
            return wrapperErrorResp(ResultModel.ERRAND_TAKE_FAIL, "should specify taker!");
        errand.setFinishTime(this.getCurrentTime());
        errandDao.finishErrand(errand);
        return wrapperOKResp(errand);
    }

    // 获取自己发布的任务
    @RequestMapping(value="/{username}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getErrands(@PathVariable("username") String username){
        List<Errand> errands = errandDao.getErrands(username);
        return wrapperOKResp(errands);
    }

    // 获取当前自己的接单的
    @RequestMapping(value = "/{username}/take", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getTakeErrands(@PathVariable("username") String username){
        List<Errand> errands = errandDao.getTakeErrands(username);
        return wrapperOKResp(errands);
    }
}
