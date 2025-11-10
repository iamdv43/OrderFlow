package com.orderflow.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class UserRequest {

      @NotBlank(message = "Email is required")
      @Email(message = "Email must be valid")
      private String email;

      @NotBlank(message = "Password is required")
      @Size(min = 6, message = "Password must be at least 6 characters")
      private String password;

      private String name;

      private String role;

      private Boolean active;

      // Getters and setters

      public String getEmail() {
            return email;
      }

      public void setEmail(String email) {
            this.email = email;
      }

      public String getPassword() {
            return password;
      }

      public void setPassword(String password) {
            this.password = password;
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
}
