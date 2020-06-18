package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.DealDao;
import com.mobilecourse.backend.entity.Deal;
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
@RequestMapping("/deal")
public class DealController extends CommonController {
    @Autowired
    DealDao dealDao;

    @RequestMapping(value = "/create", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> create(@RequestBody Deal deal){
        deal.setUuid(this.getUuid());
        deal.setCreated(this.getCurrentTime());
        dealDao.createDeal(deal);
        return wrapperOKResp(deal);
    }

    @RequestMapping(value = "/modify", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> modify(@RequestBody Deal deal){
        dealDao.modifyDeal(deal);
        return wrapperOKResp(deal);
    }

    @RequestMapping(value = "/delete", method = {RequestMethod.DELETE})
    public ResponseEntity<ResultModel> delete(@RequestParam String uuid){
        dealDao.deleteDeal(uuid);
        return wrapperOKResp(null);
    }

    @RequestMapping(value = "/take", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> take(@RequestBody Deal deal){
        if(deal.getTaker() == null)
            return wrapperErrorResp(ResultModel.ERRAND_TAKE_FAIL, "should specify taker!");
        deal.setTakeTime(this.getCurrentTime());
        dealDao.takeDeal(deal);
        return wrapperOKResp(deal);
    }

    // 获取自己发布的任务
    @RequestMapping(value="/{username}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getDeals(@PathVariable("username") String username){
        List<Errand> errands = dealDao.getDeals(username);
        return wrapperOKResp(errands);
    }

    // 获取当前自己的接单的
    @RequestMapping(value = "/{username}/take", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getTakeDeals(@PathVariable("username") String username){
        List<Errand> errands = dealDao.getTakeDeals(username);
        return wrapperOKResp(errands);
    }
}
