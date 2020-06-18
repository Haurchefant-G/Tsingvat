package com.mobilecourse.backend;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
@WebFilter(filterName = "myFilter",urlPatterns = {"/*"})
public class MyFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO Auto-generated method stub
        System.out.println("MyFilter init ");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // TODO Auto-generated method stub
        HttpServletRequest req = (HttpServletRequest) request;
        System.out.println("MyFilter doFilter"+req.getParameter("name"));
        chain.doFilter(request, response);
        return ;
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
        System.out.println("MyFilter destroy");
    }

}