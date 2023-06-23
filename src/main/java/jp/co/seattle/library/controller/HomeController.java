package jp.co.seattle.library.controller;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.service.BooksService;

/**
 * Handles requests for the application home page.
 */
@Controller // APIの入り口
public class HomeController {
	final static Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private BooksService booksService;

	/**
	 * Homeボタンからホーム画面に戻るページ
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String transitionHome(Model model) {
		//書籍の一覧情報を取得（タスク３）

		List<BookInfo> books = booksService.getBookList();
		model.addAttribute("bookList", books);
		return "home";
	}

	@RequestMapping(value = "/searchbook", method = RequestMethod.GET)
	public String searchHome(Model model, @RequestParam("search") String search) {
		List<BookInfo> books = booksService.searchBookList(search);

		if (!(books.isEmpty())) {
			model.addAttribute("bookList", books);
			return "home";
		} else {
			model.addAttribute("resultMessage", "書籍が0件です");
			return "home";
		}

	}

	@Transactional
	@RequestMapping(value = "/unfavoriteBook", method = RequestMethod.GET)
	public String unfavoriteBook(Locale locale, @RequestParam("bookId") int bookId, Model model) {

		// 書籍情報を削除する
		booksService.unfavoriteBook(bookId);

		// 一覧画面に遷移する
		return "redirect:/home";
	}

	@Transactional
	@RequestMapping(value = "/favoriteBook", method = RequestMethod.GET)
	public String favoriteBook(Locale locale, @RequestParam("bookId") int bookId, Model model) {

		// 書籍情報を削除する
		booksService.favoriteBook(bookId);

		// 一覧画面に遷移する
		return "redirect:/home";
	}

	@Transactional
	@RequestMapping(value = "/favoriteList", method = RequestMethod.GET, produces = "text/plain;charset=utf-8")
	public String favoriteBookList(Model model) {
		List<BookInfo> books = booksService.favoriteBooksList();

		model.addAttribute("bookList", books);
		return "home";

		// 一覧画面に遷移する

	}
	@RequestMapping(value = "/genre", method = RequestMethod.POST)
	public String genre(Model model, @RequestParam("genre") String genre) {
		List<BookInfo> books = booksService.genre(genre);

		if (!(books.isEmpty())) {
			model.addAttribute("bookList", books);
			return "home";
		} else {
			model.addAttribute("resultMessage", "該当する書籍はありません");
			return "home";
		}

		// 一覧画面に遷移する

	}

}
