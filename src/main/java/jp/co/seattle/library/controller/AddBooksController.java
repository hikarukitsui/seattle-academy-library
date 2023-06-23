package jp.co.seattle.library.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jp.co.seattle.library.commonutil.BookUtil;
import jp.co.seattle.library.dto.BookDetailsInfo;
import jp.co.seattle.library.dto.BookInfoError;
import jp.co.seattle.library.service.BooksService;
import jp.co.seattle.library.service.ThumbnailService;

@Controller
public class AddBooksController {
	final static Logger logger = LoggerFactory.getLogger(AddBooksController.class);

	@Autowired
	private BooksService booksService;
	@Autowired
	private ThumbnailService thumbnailService;
	@Autowired
	private BookUtil bookUtil;

	@RequestMapping(value = "/addBook", method = RequestMethod.GET)
	public String login(Model model) {
		return "addBook";
	}

	@RequestMapping(value = "/addBookCorrection", method = RequestMethod.GET)
	public String logined(Model model) {
		return "addBookCorrection";
	}

	@RequestMapping(value = "/insertBook", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String insertBook(Locale locale,
			@RequestParam(value = "title") String[] titles,
			@RequestParam(value = "author") String[] authors,
			@RequestParam(value = "publisher") String[] publishers,
			@RequestParam(value = "publishDate") String[] publishDates,
			@RequestParam(value = "isbn") String[] isbns,
			@RequestParam(value = "description") String[] descriptions,
			@RequestParam(value = "genre") String[] genres,
			@RequestParam(value = "thumbnail") MultipartFile[] files,
			Model model,
			RedirectAttributes redirectAttributes) {

		logger.info("Welcome insertBooks.java! The client locale is {}.", locale);

		// 配列の長さを取得
		int length = Math.max(
				Math.max(titles != null ? titles.length : 0, authors != null ? authors.length : 0),
				Math.max(
						Math.max(publishers != null ? publishers.length : 0,
								publishDates != null ? publishDates.length : 0),
						Math.max(
								Math.max(isbns != null ? isbns.length : 0,
										descriptions != null ? descriptions.length : 0),
								genres != null ? genres.length : 0)));

		List<BookInfoError> bookInfoList = new ArrayList<>();
		Boolean errorFlg = false;
		

		for (int i = 0; i < length; i++) {
			String title = titles != null && i < titles.length ? titles[i] : "";
			String author = authors != null && i < authors.length ? authors[i] : "";
			String publisher = publishers != null && i < publishers.length ? publishers[i] : "";
			String publishDate = publishDates != null && i < publishDates.length ? publishDates[i] : "";
			String isbn = isbns != null && i < isbns.length ? isbns[i] : "";
			String description = descriptions != null && i < descriptions.length ? descriptions[i] : "";
			String genre = genres != null && i < genres.length ? genres[i] : "";
			MultipartFile file = files != null && i < files.length ? files[i] : null;

			BookInfoError book = new BookInfoError();
			BookDetailsInfo bookInfo = new BookDetailsInfo();
			bookInfo.setTitle(title);
			bookInfo.setAuthor(author);
			bookInfo.setPublisher(publisher);
			bookInfo.setPublishDate(publishDate);
			bookInfo.setIsbn(isbn);
			bookInfo.setDescription(description);
			bookInfo.setGenre(genre);

			book.setBookDetailsInfo(bookInfo);

			List<String> errorList = bookUtil.checkBookInfo(bookInfo);
			book.setErrorList(errorList);
			bookInfoList.add(book);

			if (!errorList.isEmpty()) {
				errorFlg = true;
				continue;
			}
			// クライアントのファイルシステムにある元のファイル名を設定する
			String thumbnail = file.getOriginalFilename();

			if (!file.isEmpty()) {
				try {
					// サムネイル画像をアップロード
					String fileName = thumbnailService.uploadThumbnail(thumbnail, file);
					// URLを取得
					String thumbnailUrl = thumbnailService.getURL(fileName);

					bookInfo.setThumbnailName(fileName);
					bookInfo.setThumbnailUrl(thumbnailUrl);

				} catch (Exception e) {
					// 異常終了時の処理
					logger.error("サムネイルアップロードでエラー発生", e);
					redirectAttributes.addFlashAttribute("bookDetailsInfo", bookInfo);
					return "redirect:/addBook";
				}
			}
			// 書籍情報を新規登録する
		 booksService.registBook(bookInfo);
		}

		if (errorFlg) {
			redirectAttributes.addFlashAttribute("bookInfoList", bookInfoList);

			return "redirect:/addBookCorrection";
		}

		return "redirect:/home";
	}
}