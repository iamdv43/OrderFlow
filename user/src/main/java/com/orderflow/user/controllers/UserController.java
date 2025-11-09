package com.orderflow.user.controllers;

import com.orderflow.user.repositories.UserRepository;
import com.orderflow.user.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;

@RestController
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/users")
    public List<User> getAllUsers(HttpServletRequest request) {
        logHeaders(request);
        return userRepository.findAll();
    }

    @PostMapping("/users")
    public ResponseEntity<User> addUser(@RequestBody User user, HttpServletRequest request) {
        logHeaders(request);
        if (user.getUserId() == null) {
            return ResponseEntity.badRequest().build();
        }
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    }

    @GetMapping("/")
    public String home(HttpServletRequest request) {
        logHeaders(request);
        return "User Service Running...";
    }

    private void logHeaders(HttpServletRequest request) {
        System.out.println("---- Incoming Request Headers ----");
        request.getHeaderNames().asIterator().forEachRemaining(
                name -> System.out.println(name + ": " + request.getHeader(name)));
        System.out.println("----------------------------------");
    }
}