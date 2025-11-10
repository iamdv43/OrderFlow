package com.orderflow.user.services;

import com.orderflow.user.dto.UserRequest;
import com.orderflow.user.dto.UserResponse;
import com.orderflow.user.exceptions.DuplicateEmailException;
import com.orderflow.user.exceptions.ResourceNotFoundException;
import com.orderflow.user.models.User;
import com.orderflow.user.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserServiceImpl implements UserService {

      @Autowired
      private UserRepository userRepository;

      @Autowired
      private PasswordEncoder passwordEncoder;

      @Override
      public List<UserResponse> getAllUsers() {
            return userRepository.findAll().stream()
                        .map(this::convertToResponse)
                        .collect(Collectors.toList());
      }

      @Override
      public UserResponse getUserById(UUID userId) {
            if (userId == null) {
                  throw new IllegalArgumentException("User ID cannot be null");
            }
            User user = userRepository.findById(userId)
                        .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + userId));
            return convertToResponse(user);
      }

      @Override
      public UserResponse getUserByEmail(String email) {
            User user = userRepository.findByEmail(email)
                        .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + email));
            return convertToResponse(user);
      }

      @Override
      public UserResponse createUser(UserRequest userRequest) {
            // Check if email already exists
            if (userRepository.existsByEmail(userRequest.getEmail())) {
                  throw new DuplicateEmailException("Email already exists: " + userRequest.getEmail());
            }

            User user = new User();
            user.setEmail(userRequest.getEmail());
            user.setPasswordHash(passwordEncoder.encode(userRequest.getPassword()));
            user.setName(userRequest.getName());
            user.setRole(userRequest.getRole() != null ? userRequest.getRole() : "USER");
            user.setActive(userRequest.getActive() != null ? userRequest.getActive() : true);

            User savedUser = userRepository.save(user);
            return convertToResponse(savedUser);
      }

      @Override
      public UserResponse updateUser(UUID userId, UserRequest userRequest) {
            if (userId == null) {
                  throw new IllegalArgumentException("User ID cannot be null");
            }
            User user = userRepository.findById(userId)
                        .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + userId));

            // Check if email is being changed and if new email already exists
            if (!user.getEmail().equals(userRequest.getEmail()) &&
                        userRepository.existsByEmail(userRequest.getEmail())) {
                  throw new DuplicateEmailException("Email already exists: " + userRequest.getEmail());
            }

            user.setEmail(userRequest.getEmail());
            if (userRequest.getPassword() != null && !userRequest.getPassword().isEmpty()) {
                  user.setPasswordHash(passwordEncoder.encode(userRequest.getPassword()));
            }
            if (userRequest.getName() != null) {
                  user.setName(userRequest.getName());
            }
            if (userRequest.getRole() != null) {
                  user.setRole(userRequest.getRole());
            }
            if (userRequest.getActive() != null) {
                  user.setActive(userRequest.getActive());
            }

            User updatedUser = userRepository.save(user);
            return convertToResponse(updatedUser);
      }

      @Override
      public void deleteUser(UUID userId) {
            if (userId == null) {
                  throw new IllegalArgumentException("User ID cannot be null");
            }
            if (!userRepository.existsById(userId)) {
                  throw new ResourceNotFoundException("User not found with id: " + userId);
            }
            userRepository.deleteById(userId);
      }

      private UserResponse convertToResponse(User user) {
            return new UserResponse(
                        user.getUserId(),
                        user.getEmail(),
                        user.getName(),
                        user.getRole(),
                        user.getActive(),
                        user.getCreatedAt(),
                        user.getUpdatedAt());
      }
}
