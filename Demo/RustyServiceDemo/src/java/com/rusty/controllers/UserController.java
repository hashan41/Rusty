/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.rusty.controllers;

import com.rusty.entities.User;
import java.util.ArrayList;

/**
 *
 * @author hmj
 */
public class UserController {
        public ArrayList<User> getAllUsers() {
        ArrayList<User> userList = new ArrayList<User>();
        for (int i = 0; i < 5; i++) {
            User u = new User();
            u.setFirstName("Rusty");
            u.setLastName("Rest");
            u.setDOB("2014-04-16");
            u.setUserName("rustyU");
            userList.add(u);
        }
        return userList;
    }
}
