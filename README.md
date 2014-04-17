# RUSTY Servlet Filter for Restful web services

## Overview

Servlet filter for Restful web service interface. Filter requests by request destinations, users. Response of web service can encrypt for selected webservices or all. Configurations has to be define in rusty-config file. Client side of rusty has feature to prevent web service replay attacks and decrypt data of web service if secured. 

Users and destination management is highly customizable and currently those have to define in rusty-config.xml

We are looking forward to integrate LDAP or any other database to manage users and destinations.

## Setup instructions



## Features

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

* **Enterprise Reqdy**  
 Rusty request handler can process multiple requests at time




