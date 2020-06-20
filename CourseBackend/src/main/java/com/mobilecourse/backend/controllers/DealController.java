package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.DealDao;
import com.mobilecourse.backend.entity.Deal;
import com.mobilecourse.backend.utils.Global;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
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
        List<Deal> deals = dealDao.getDeals(username);
        return wrapperOKResp(deals);
    }

    @RequestMapping(value="", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getIndexDeals(@RequestParam(required = false) Timestamp time, @RequestParam(required = false) String num){
        if(time == null) time = this.getCurrentTime();
        int limit = 0;
        if(num == null) limit = Global.LIMIT_NUM;
        else limit = Integer.parseInt(num);

        List<Deal> deals = dealDao.getIndexDeals(time, limit);
        return wrapperOKResp(deals);
    }

    // 获取当前自己的接单的
    @RequestMapping(value = "/{username}/take", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getTakeDeals(@PathVariable("username") String username){
        List<Deal> deals = dealDao.getTakeDeals(username);
        return wrapperOKResp(deals);
    }
}
