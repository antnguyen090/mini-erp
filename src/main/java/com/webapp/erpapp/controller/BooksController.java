package com.webapp.erpapp.controller;

import com.webapp.erpapp.model.response.book.BookDetailResponse;
import com.webapp.erpapp.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/books")
public class BooksController {

    @Autowired
    BookService bookService;

    @GetMapping
    public ModelAndView books() {
        ModelAndView view = new ModelAndView("/books/books");
        return view;
    }

    @GetMapping("/{id}")
    public ModelAndView bookDetail(@PathVariable("id") String id) {
        ModelAndView view = new ModelAndView("/books/bookDetail");
        BookDetailResponse bookDetail = bookService.findById(id);
        view.addObject("bookDetail", bookDetail);
        return view;
    }
}
