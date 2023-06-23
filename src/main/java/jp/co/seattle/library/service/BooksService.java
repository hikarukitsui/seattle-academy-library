package jp.co.seattle.library.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import jp.co.seattle.library.dto.BookDetailsInfo;
import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.rowMapper.BookDetailsInfoRowMapper;
import jp.co.seattle.library.rowMapper.BookInfoRowMapper;

/**
 * 書籍サービス
 * 
 * booksテーブルに関する処理を実装する
 */
@Service
public class BooksService {
	final static Logger logger = LoggerFactory.getLogger(BooksService.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 書籍リストを取得する
	 *
	 * @return 書籍リスト
	 */
	public List<BookInfo> getBookList() {

		// TODO 書籍名の昇順で書籍情報を取得するようにSQLを修正（タスク３）
		List<BookInfo> getedBookList = jdbcTemplate.query(
				"SELECT id, title, author, publisher, publish_date, thumbnail_url, favorite, genre FROM books ORDER BY title ASC;",
				new BookInfoRowMapper());

		return getedBookList;
	}

	public List<BookInfo> searchBookList(String search) {
		String sql = "SELECT * FROM books WHERE title LIKE ? ORDER BY title ASC;";
		String searchword = "%" + search + "%";
		// TODO 書籍名の昇順で書籍情報を取得するようにSQLを修正（タスク３）
		List<BookInfo> getedSearchList = jdbcTemplate.query(sql, new BookInfoRowMapper(), searchword);

		return getedSearchList;
	}

	/**
	 * 書籍IDに紐づく書籍詳細情報を取得する
	 *
	 * @param bookId 書籍ID
	 * @return 書籍情報
	 */
	public BookDetailsInfo getBookInfo(int bookId) {
		String sql = "SELECT id, title, author, publisher, publish_date, isbn, description, genre, thumbnail_url, thumbnail_name FROM books WHERE books.id = ? ORDER BY title ASC;";

		BookDetailsInfo bookDetailsInfo = jdbcTemplate.queryForObject(sql, new BookDetailsInfoRowMapper(), bookId);

		return bookDetailsInfo;
	}

	/**
	 * 書籍を登録する
	 *
	 * @param bookInfo 書籍情報
	 * @return bookId 書籍ID
	 */
	public void registBook(BookDetailsInfo bookInfo) {
		// TODO 取得した書籍情報を登録し、その書籍IDを返却するようにSQLを修正（タスク４）
		String sql = "INSERT INTO books (title, author, publisher, publish_date, genre, thumbnail_name, thumbnail_url, isbn, description, reg_date, upd_date)VALUES (?,?,?,?,?,?,?,?,?,now(),now()) RETURNING id";

		jdbcTemplate.queryForObject(sql, int.class, bookInfo.getTitle(), bookInfo.getAuthor(),
				bookInfo.getPublisher(), bookInfo.getPublishDate(), bookInfo.getGenre(), bookInfo.getThumbnailName(),
				bookInfo.getThumbnailUrl(), bookInfo.getIsbn(), bookInfo.getDescription());
	}

	/**
	 * 書籍を削除する
	 * 
	 * @param bookId 書籍ID
	 */
	public void deleteBook(int bookId) {
		// TODO 対象の書籍を削除するようにSQLを修正（タスク6）
		String sql = "DELETE FROM books WHERE books.Id = ?;";
		jdbcTemplate.update(sql, bookId);
	}

	/**
	 * 書籍情報を更新する
	 * 
	 * @param bookInfo
	 */
	public void updateBook(BookDetailsInfo bookInfo) {
		String sql;
		if (bookInfo.getThumbnailUrl() == null) {
			// TODO 取得した書籍情報を更新するようにSQLを修正（タスク５）
			sql = "UPDATE books SET title = ?, author = ?, publisher = ?, publish_date = ?, isbn = ?,description = ?, genre = ? WHERE id = ?";
			jdbcTemplate.update(sql, bookInfo.getTitle(), bookInfo.getAuthor(), bookInfo.getPublisher(),
					bookInfo.getPublishDate(), bookInfo.getIsbn(), bookInfo.getDescription(), bookInfo.getGenre(),
					bookInfo.getBookId());
		} else {
			// TODO 取得した書籍情報を更新するようにSQLを修正（タスク５）
			sql = "UPDATE books SET title = ?, author = ?, publisher = ?, publish_date = ?, thumbnail_name = ?, thumbnail_url = ?, isbn = ?, description = ?, genre = ? WHERE id = ?";
			jdbcTemplate.update(sql, bookInfo.getTitle(), bookInfo.getAuthor(), bookInfo.getPublisher(),
					bookInfo.getPublishDate(), bookInfo.getThumbnailName(), bookInfo.getThumbnailUrl(),
					bookInfo.getIsbn(), bookInfo.getDescription(), bookInfo.getGenre(), bookInfo.getBookId());
		}

	}

	public void favoriteBook(int bookId) {
		// TODO お気に入りの登録
		String sql = "UPDATE books SET favorite =1 WHERE id = ?;";
		jdbcTemplate.update(sql, bookId);
	}

	public void unfavoriteBook(int bookId) {
		// TODO お気に入りの登録
		String sql = "UPDATE books SET favorite =0 WHERE id = ?;";
		jdbcTemplate.update(sql, bookId);
	}

	public List<BookInfo> favoriteBooksList() {
		List<BookInfo> getedBookList = jdbcTemplate.query(
				"SELECT * FROM books WHERE favorite =1 ORDER BY title ASC;",
				new BookInfoRowMapper());
		return getedBookList;
	}

	public List<BookInfo> genre(String genre) {
		String sql = "SELECT * FROM books WHERE genre = '" + genre + "' ORDER BY title ASC";
		List<BookInfo> getGenre = jdbcTemplate.query(sql, new BookInfoRowMapper());

		return getGenre;
	}
}
