package com.orderflow.user.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public class UserResponse {

      private UUID userId;
      private String email;
      private String name;
      private String role;
      private Boolean active;
      private LocalDateTime createdAt;
      private LocalDateTime updatedAt;

      // Constructors

      public UserResponse() {
      }

      public UserResponse(UUID userId, String email, String name, String role, Boolean active,
                  LocalDateTime createdAt, LocalDateTime updatedAt) {
            this.userId = userId;
            this.email = email;
            this.name = name;
            this.role = role;
            this.active = active;
            this.createdAt = createdAt;
            this.updatedAt = updatedAt;
      }

      // Getters and setters

      public UUID getUserId() {
            return userId;
      }

      public void setUserId(UUID userId) {
            this.userId = userId;
      }

      public String getEmail() {
            return email;
      }

      public void setEmail(String email) {
            this.email = email;
      }

      public String getName() {
            return name;
      }

      public void setName(String name) {
            this.name = name;
      }

      public String getRole() {
            return role;
      }

      public void setRole(String role) {
            this.role = role;
      }

      public Boolean getActive() {
            return active;
      }

      public void setActive(Boolean active) {
            this.active = active;
      }

      public LocalDateTime getCreatedAt() {
            return createdAt;
      }

      public void setCreatedAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
      }

      public LocalDateTime getUpdatedAt() {
            return updatedAt;
      }

      public void setUpdatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
      }
}
