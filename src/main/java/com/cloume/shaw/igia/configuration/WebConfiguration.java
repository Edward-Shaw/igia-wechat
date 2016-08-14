package com.cloume.shaw.igia.configuration;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConfiguration {
	
	class SimpleCORSFilter implements Filter {
	    public void doFilter(ServletRequest req, ServletResponse res, final FilterChain chain) throws IOException, ServletException {
	        HttpServletResponse response = (HttpServletResponse) res;
	        HttpServletRequest request = (HttpServletRequest) req;
	        
	        if(request.getMethod().equalsIgnoreCase("options")){
		        response.setHeader("Access-Control-Allow-Methods", "GET, PUT, POST, GET, OPTIONS, DELETE");
		        ///response.setHeader("Access-Control-Max-Age", "3600");
		        response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, accept, content-type");
	        }
	        response.setHeader("Access-Control-Allow-Origin", "*");
	        
	        chain.doFilter(req, res);
	    }

	    public void init(FilterConfig filterConfig) {}

	    public void destroy() {}
	}
	
	@Bean
    public FilterRegistrationBean filterRegistrationBean(){  
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        
        filterRegistrationBean.setFilter(new SimpleCORSFilter());
        filterRegistrationBean.setEnabled(true);
        filterRegistrationBean.addUrlPatterns("/jsapisign/*", "/user/*");
        
        return filterRegistrationBean;  
    }
}
