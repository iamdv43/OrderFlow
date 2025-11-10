package com.orderflow.user.services;

import com.orderflow.user.dto.UserRequest;
import com.orderflow.user.dto.UserResponse;

import java.util.List;
import java.util.UUID;

public interface UserService {
      List<UserResponse> getAllUsers();

      UserResponse getUserById(UUID userId);

      UserResponse getUserByEmail(String email);

      UserResponse createUser(UserRequest userRequest);

      UserResponse updateUser(UUID userId, UserRequest userRequest);

      void deleteUser(UUID userId);
}
