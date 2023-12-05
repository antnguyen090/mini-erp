package com.webapp.erpapp.api;


import com.webapp.erpapp.model.request.user.UserActiveRequest;
import com.webapp.erpapp.model.request.user.UserUpdateRequest;
import com.webapp.erpapp.model.response.user.PageUserListRespone;
import com.webapp.erpapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    private UserService userService;

    @PostMapping("/updation")
    public ResponseEntity<?> updateUser(@Valid UserUpdateRequest userUpdateRequest) {
        int user = userService.updateUserDetail(userUpdateRequest);
        if (user == 1) return ResponseEntity.ok().build();
        return (ResponseEntity<?>) ResponseEntity.badRequest();
    }

    @GetMapping
    public ResponseEntity<?> getAllUser(
            @RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
            @RequestParam(name = "search", required = false, defaultValue = "") String search,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
            @RequestParam(name = "status", required = false, defaultValue = "ACTIVE") String status) {

        PageUserListRespone users = userService.getAllUser(search, sort, page, pageSize, status);

        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findUserDetail(@PathVariable("id") String id) {
        return new ResponseEntity<>(userService.findUserDetail(id), HttpStatus.OK);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable("id") String id) {
        return new ResponseEntity<>(userService.deleteUser(id), HttpStatus.OK);
    }


    @PutMapping("/register/approval")
    public ResponseEntity<Boolean> activeUserRegisterRequest(@Valid @RequestBody UserActiveRequest user) {
        return ResponseEntity.ok(userService.activeUserRegisterRequest(user));
    }

    @DeleteMapping("/register/reject/{id}")
    public ResponseEntity<Boolean> rejectUserRegisterRequest(@PathVariable String id) {
        return ResponseEntity.ok(userService.rejectUserRegisterRequest(id));
    }

    @GetMapping("/usernames")
    public ResponseEntity<?> getAllFullname() {
        return new ResponseEntity<>(userService.getAllFullname(), HttpStatus.OK);
    }
}
