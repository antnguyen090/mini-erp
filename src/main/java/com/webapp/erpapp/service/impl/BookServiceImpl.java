package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.constant.BookConstant;
import com.webapp.erpapp.converter.BookConverter;
import com.webapp.erpapp.entity.Book;
import com.webapp.erpapp.exception.MissingException;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.BookMapper;
import com.webapp.erpapp.model.request.book.BookCreateRequest;
import com.webapp.erpapp.model.request.book.BookUpdateRequest;
import com.webapp.erpapp.model.response.book.BookDetailResponse;
import com.webapp.erpapp.model.response.book.ShowBookResponse;
import com.webapp.erpapp.service.BookService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private BookConverter bookConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public List<ShowBookResponse> findAll(String searchTerm, int start, int pageSize) {
        int offset = (start - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        List<Book> books = bookMapper.findAll(searchTerm, rowBounds);
        return bookConverter.toListShowBookResponse(books);
    }

    @Override
    public long getTotalItem(String search) {
        return bookMapper.totalBook(search);
    }

    @Override
    public int createBook(BookCreateRequest bookCreateRequest) {

        MultipartFile bookImage = bookCreateRequest.getImage();

        String bookImageFileName = null;
        boolean isSaveImageSuccess = true;

        if(bookImage != null){

            applicationUtils.checkValidateImage(Book.class, bookImage);

            bookImageFileName = FileUtils.formatNameImage(bookImage);
            isSaveImageSuccess = FileUtils.saveImageToServer(
                    request, BookConstant.UPLOAD_FILE_DIR, bookCreateRequest.getImage(), bookImageFileName);
        } else{
            throw new MissingException(MessageErrorUtils.missing("image"));
        }

        if(isSaveImageSuccess){
            Book book = bookConverter.toEntity(bookCreateRequest, bookImageFileName);
            try {
                bookMapper.createBook(book);
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, BookConstant.UPLOAD_FILE_DIR, bookImageFileName);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public BookDetailResponse findById(String id) {
        return bookConverter.toDetailResponse(bookMapper.findById(id));
    }

    @Override
    public int updateBook(BookUpdateRequest bookUpdateRequest) {

        Book book = bookMapper.findById(bookUpdateRequest.getId());

        if(book == null) throw new NotFoundException("id");

        MultipartFile bookFile = bookUpdateRequest.getImage();

        String fileNameBook = null, oldImage = book.getImage();
        boolean isSaveBookSuccess = true;

        if(bookFile != null){
            applicationUtils.checkValidateImage(Book.class, bookFile);

            fileNameBook = FileUtils.formatNameImage(bookFile);
            isSaveBookSuccess = FileUtils.saveImageToServer(
                    request, BookConstant.UPLOAD_FILE_DIR, bookUpdateRequest.getImage(), fileNameBook);
        } else{
            fileNameBook = oldImage;
        }

        Book b;
        if(isSaveBookSuccess){
            b = bookConverter.toEntity(bookUpdateRequest, fileNameBook);
            try {
                bookMapper.updateBook(b);
                if(!fileNameBook.equals(oldImage)){
                    FileUtils.deleteImageFromServer(request, BookConstant.UPLOAD_FILE_DIR, oldImage);
                }
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, BookConstant.UPLOAD_FILE_DIR, fileNameBook);
                return 0;
            }
        }
        return 0;
    }

    @Override
    public int deleteBook(String id) {

        if (bookMapper.findById(id) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        return bookMapper.deleteBook(id);
    }
}
