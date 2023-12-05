package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.book.BookCreateRequest;
import com.webapp.erpapp.model.request.book.BookUpdateRequest;
import com.webapp.erpapp.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/books")
public class BookApi {

    @Autowired
    private BookService bookService;

    @GetMapping
    public ResponseEntity<?> findAll(@RequestParam(name = "search", required = false, defaultValue = "") String search,
                                     @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                     @RequestParam(name = "pageSize", required = false, defaultValue = "5") int pageSize) {
        return ResponseEntity.ok(bookService.findAll(search, page, pageSize));
    }

    @GetMapping("/count")
    public ResponseEntity<?> getTotalItem(@RequestParam(name = "search", required = false, defaultValue = "") String search) {
        return ResponseEntity.ok(bookService.getTotalItem(search));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(bookService.findById(id));
    }

    @PostMapping
    public ResponseEntity<?> createBook(BookCreateRequest bookCreateRequest) {
        return ResponseEntity.ok(bookService.createBook(bookCreateRequest));
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateBook(BookUpdateRequest bookUpdateRequest) {
        return ResponseEntity.ok(bookService.updateBook(bookUpdateRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBook(@PathVariable String id) {
        return ResponseEntity.ok(bookService.deleteBook(id));
    }
}
