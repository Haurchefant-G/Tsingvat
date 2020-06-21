package com.mobilecourse.backend;

import java.io.File;

import com.mobilecourse.backend.utils.Global;
import org.springframework.boot.system.ApplicationHome;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@Configuration
public class WebMvcConfig extends WebMvcConfigurationSupport {
//    @Autowired
//    private MyInterceptor myInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //获取当前jar 的执行路径
        ApplicationHome home = new ApplicationHome(getClass());
        File jarFile = home.getSource();
        String parent = jarFile.getParent();
        System.out.println(parent);
        System.out.println(Global.BASE_FILE_PATH);
        //文件磁盘图片url 映射
        //配置server虚拟路径，handler为前台访问的目录，locations为files相对应的本地路径
        registry.addResourceHandler("/images/**").addResourceLocations("file:"+ Global.BASE_FILE_PATH+"/images/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new MyInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/account/*");

    }
}