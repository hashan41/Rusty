# RUSTY Servlet Filter for Restful web services

## Overview

Servlet filter for Restful web service interface. Filter requests by request destinations, users. Response of web service can encrypt for selected webservices or all. Configurations has to be define in rusty-config file. Client side of rusty has feature to prevent web service replay attacks and decrypt data of web service if secured. 

Users and destination management is highly customizable and currently those have to define in rusty-config.xml

We are looking forward to integrate LDAP or any other database to manage users and destinations.

## Setup instructions

* **Download Rusty.jar**  
 Download Rusty.jar and add to library.

* **Add Web filter annotation to URL**  
 `@WebFilter("/rest/*")`
 `public class SecureGET implements Filter {`

 Implement javax.servlet.Filter with your java class. Override init, doFilter and destroy methods in Filter interface.
 
* **Override doFilter() Method**
 `@Override`
    `public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,    ServletException {`
        `Rusty.initRustyFilter(request, response, chain);`
    `}`
 That's It. You are now implemented Rusty Filter to your Rest Web service Interface. Now Lets Start with Rusty Configurations.

### rusty-config.xml
 
 Rusty Configuration file is managing all request and response modifying.
 
 rusty-config.xml must place under rusty folder in WEB-INF.
 
 > WEB-INF
>  -rusty
>   -rusty-config.xml

* **Encryption Enabling**
 `<encryption active="true" apply="*">`
     `<key>rustykey12345678</key>`
 `</encryption>`
 
 If you need to encrypt all you responses add attribute apply="*" in encryption tag.
 
 If you need to encrypt responses of selected services then use apply="~" in ancryption tag.
 
 If you need your service to be secure use secured="true"
 `<service-item secured="true">/assets/getassets</service-item>` 

 If you don't care about securing your service secured="false" or do not add "secured" attribute
 
 `<service-item secured="false">/assets/getunsecureassets</service-item> `
 
* **User Access Management** 
 
 `<user-management active="true">`
     `<management-type>custom</management-type>`
     `<connection-string></connection-string>`
     `<users>`
        `<user username="hashan41" password="hashan41"></user>`
        `<user username="admin" password="admin"></user>`
        `<user username="dmsadmin" password="dmsadmin"></user>`
     `</users>`
 `</user-management>`
 
 Add active="true" to active Rusty user access management.
 
 Define management type "custom" to filter users by defined in rusty-config.xml 
 users must define under users tag
 
 We are working forward to integrate with LDAP user management or MySql, MsSql and Oracle DB.
 
* **Domain Access Management** 

 You can define which IP or domain can access web services. ex : 192.0.0.31 can only access those 4 web services.
 
 `<destination>`
    `<ip>192.0.0.31</ip>`
    `<allowed-services>`
        `<service>/assets/getassets</service> `
        `<service>/assets/getunsecureassets</service> `
        `<service>/assets/postassets</service> `
        `<service>/assets/putassets</service> `
    `</allowed-services>`
 `</destination>`
 
 If you want to give 192.0.0.31 to access all services,
 
 `<destination>`
     `<ip>192.0.0.31</ip>`
     `<allowed-services>`
         `*`
     `</allowed-services>`
 `</destination>`



## Features

* **Easy to use**  
 Call rusty filter and define configurations in rusty-config.xml

* **Integrate with any servlet container**  
 Can Integrate in any Java Application server with servlet container

* **Prevent XHR Replay Attacks**  
 Rusty client side request handler can prevent XHR Replay Attacks. 

* **Add audit trail using session attributes**  
 Client side audit trail injection can handle by rusty request handler

* **Authenticate Web service**  
 Authenticate selected web service or all services with credentials

* **Secure Web service (s) without using SSL**  
 Encrypt response using Java AES encryption and decrypt by Rusty Request handler before access by client application

* **Authenticate web service by domain**  
 You can restrict web service call by domain or any given IP Addresses. Authenticate all services or selected services.

* **Prevent Man in Middle Attack**  
 No one can sniff or grab data in transport layer. All data is encrypted before send it to web service layer and response also encrypted.

* **Enterprise Ready**  
 Rusty request handler can process multiple requests at time


## Requirements

* [JAVA](http://jquery.com/) v. 1.6+
* [JAVA EE](http://jquery.com/) v. 5+
* [Servlet](http://jquery.com/) v. 2+
* AJAVA Application Server

## License
Released under the [MIT license](http://www.opensource.org/licenses/MIT).
