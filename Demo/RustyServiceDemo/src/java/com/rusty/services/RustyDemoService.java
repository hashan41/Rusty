/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rusty.services;

import com.rusty.Rusty;
import com.rusty.controllers.UserController;
import com.rusty.entities.User;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 *
 * @author hmj
 */
@Path("/rustyDemo")
//
@WebFilter("/rest/rustyDemo/*")
public class RustyDemoService implements Filter{

    @GET
    @Path("/getSecureUsers")
    @Produces("application/json")
    public ArrayList<User> getSecureUsersList() {
        return new UserController().getAllUsers();
    }

    @GET
    @Path("/getUnSecureUsers")
    @Produces("application/json")
    public ArrayList<User> getUnSecureUsersList() {
        return new UserController().getAllUsers();
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Init Servlet Filter");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //Hand it over to Rusty
        Rusty.initRustyFilter(request, response, chain);
    }

    @Override
    public void destroy() {
        System.out.println("Close Servlet Filter");
    }
}
