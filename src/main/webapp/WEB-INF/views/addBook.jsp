<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta charset="UTF-8">
<title>書籍の追加｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="resources/js/thumbnail.js"></script>
</head>
<body class="wrapper">
    <header>
        <div class="left">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="right">
            <ul>
                <li><a href="<%=request.getContextPath()%>/home" class="menu">Home</a></li>
                <li><a href="<%=request.getContextPath()%>/">ログアウト</a></li>
            </ul>
        </div>
    </header>
    <main>
        <form action="<%=request.getContextPath()%>/insertBook" method="post" enctype="multipart/form-data" id="data_upload_form">
            <h1>書籍の追加</h1>
            <div class="input-form" id="input-form">
                <template id="form-template">
                    <div class="content_body add_book_content">
                        <div>
                            <span>書籍の画像</span> <span class="care care1">任意</span>
                            <div class="book_thumnail">
                                <img class="book_noimg" src="resources/img/noImg.png">
                            </div>
                            <input type="file" accept="image/*" name="thumbnail" id="thumbnail">
                        </div>
                        <div class="content_right">
                            <c:if test="${!empty errorList}">
                                <div class="error">
                                    <c:forEach var="error" items="${errorList}">
                                        <p>${error}</p>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <div>
                                <span>書籍名</span><span class="care care2">必須</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="title" value="${bookInfo.title}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="title" autocomplete="off">
                                </c:if>
                            </div>
                            <div>
                                <span>著者名</span><span class="care care2">必須</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="author" value="${bookInfo.author}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="author" autocomplete="off">
                                </c:if>
                            </div>
                            <div>
                                <span>出版社</span><span class="care care2">必須</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="publisher" value="${bookInfo.publisher}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="publisher">
                                </c:if>
                            </div>
                            <div>
                                <span>出版日</span><span class="care care2">必須</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="publishDate" value="${bookInfo.publishDate}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="publishDate">
                                </c:if>
                            </div>
                            <div>
                                <span>ISBN</span><span class="care care1">任意</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="isbn" value="${bookInfo.isbn}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="isbn">
                                </c:if>
                            </div>
                            <div>
                                <span>説明文</span><span class="care care1">任意</span>
                                <c:if test="${!empty bookInfo}">
                                    <input type="text" name="description" value="${bookInfo.description}">
                                </c:if>
                                <c:if test="${empty bookInfo}">
                                    <input type="text" name="description">
                                </c:if>
                            </div>
                            <div>
                                <span>ジャンル</span><span class="care care1">任意</span> <select name="genre" value="${bookInfo.genre}">
                                    <option value="" hidden></option>
                                    <option value="小説">小説</option>
                                    <option value="参考書">参考書</option>
                                    <option value="漫画">漫画</option>
                                    <option value="映画">映画</option>
                                    <option value="ビジネス本">ビジネス本</option>
                                </select>
                            </div>
                            <input type="hidden" id="bookId" name="bookId" value="${bookInfo.bookId}">
                        </div>
                    </div>
                </template>
            </div>
            <c:forEach var="bookInfo" items="${bookInfoList}">
                <div class="input-form" id="input-form">
                    <template id="form-template">
                        <div class="content_body add_book_content">
                            <div>
                                <span>書籍の画像</span> <span class="care care1">任意</span>
                                <div class="book_thumnail">
                                    <img class="book_noimg" src="resources/img/noImg.png">
                                </div>
                                <input type="file" accept="image/*" name="thumbnail" id="thumbnail">
                            </div>
                            <div class="content_right">
                                <c:if test="${!empty errorList}">
                                    <div class="error">
                                        <c:forEach var="error" items="${errorList}">
                                            <p>${error}</p>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <div>
                                    <span>書籍名</span><span class="care care2">必須</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="title" value="${bookInfo.title}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="title" autocomplete="off">
                                    </c:if>
                                </div>
                                <div>
                                    <span>著者名</span><span class="care care2">必須</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="author" value="${bookInfo.author}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="author" autocomplete="off">
                                    </c:if>
                                </div>
                                <div>
                                    <span>出版社</span><span class="care care2">必須</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="publisher" value="${bookInfo.publisher}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="publisher">
                                    </c:if>
                                </div>
                                <div>
                                    <span>出版日</span><span class="care care2">必須</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="publishDate" value="${bookInfo.publishDate}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="publishDate">
                                    </c:if>
                                </div>
                                <div>
                                    <span>ISBN</span><span class="care care1">任意</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="isbn" value="${bookInfo.isbn}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="isbn">
                                    </c:if>
                                </div>
                                <div>
                                    <span>説明文</span><span class="care care1">任意</span>
                                    <c:if test="${!empty bookInfo}">
                                        <input type="text" name="description" value="${bookInfo.description}">
                                    </c:if>
                                    <c:if test="${empty bookInfo}">
                                        <input type="text" name="description">
                                    </c:if>
                                </div>
                                <div>
                                    <span>ジャンル</span><span class="care care1">任意</span> <select name="genre" value="${bookInfo.genre}">
                                        <option value="" hidden></option>
                                        <option value="小説">小説</option>
                                        <option value="参考書">参考書</option>
                                        <option value="漫画">漫画</option>
                                        <option value="映画">映画</option>
                                        <option value="ビジネス本">ビジネス本</option>
                                    </select>
                                </div>
                                <input type="hidden" id="bookId" name="bookId" value="${bookInfo.bookId}">
                            </div>
                        </div>
                     </template>
                </div>
            </c:forEach>
            <div class="bookBtn_box">
                <button type="submit" id="add-btn" class="btn_addBook">登録</button>
            </div>
        </form>
        </div>
        <div id="addform">
            <button class="uk-button uk-button-default" onclick="addForm()">複製</button>
        </div>
    </main>
    <script>
					let i = 1

					function addForm() {
						// 8人以上なら処理を終了する
						if (i > 5) {
							return;

						} else {
							// HTMLからtemplate要素を取得
							const template = document
									.getElementById("form-template");

							// templateの内容を複製
							const new_form = template.content.cloneNode(true);

							// 子要素を指定しname属性の値を変更

							//親要素を取得し 複製した要素を追加
							const parent = document
									.getElementById("input-form");
							parent.appendChild(new_form);

							//インデント番号を更新
							i++;
						}
					}

					//ページ読み込み時に関数addForm()を実行
					window.addEventListener('DOMContentLoaded', addForm);
				</script>
</body>
</html>