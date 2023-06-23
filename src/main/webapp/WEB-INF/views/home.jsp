<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=utf8"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>ホーム｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet" type="text/css">
</head>
<body class="wrapper">
    <div class="overlay"></div>
    <nav class="nav">
        <div class="toggle">
            <span id="deleteconpo" class="toggler"></span>
        </div>
        <div class="logo">
            <a href="#">MENU</a>
        </div>
        <ul class="linkList">
            <li><a href="#">Home</a></li>
            <li><a href="#">ログアウト</a></li>
            <li><a href="#">お気に入り書籍</a></li>
            <li><a href="#">詳細</a></li>
            <li><a href="#"></a></li>
        </ul>
    </nav>
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
        <h1>Home</h1>
        <a href="<%=request.getContextPath()%>/addBook" class="btn_add_book">書籍の追加</a>
        <div class="content_body">
            <c:if test="${!empty resultMessage}">
                <div class="error_ms">${resultMessage}</div>
            </c:if>
        </div>
        <div id="searchButtonnBlock">
            <button class="btn onActive" onclick="filterSelection('all')">全て</button>
            <button class="btn" onclick="filterSelection('novel')">小説</button>
            <button class="btn" onclick="filterSelection('sannkou')">参考書</button>
            <button class="btn" onclick="filterSelection('comic')">漫画</button>
            <button class="btn" onclick="filterSelection('movie')">映画</button>
            <button class="btn" onclick="filterSelection('business')">ビジネス本</button>
        </div>
        <div class="genre">
            <span>ジャンル別表示</span>
            <form method="post" action="genre">
                <select required class="select" name="genre">
                    <option value="" selected disabled>選択してください</option>
                    <option value="小説">小説</option>
                    <option value="参考書">参考書</option>
                    <option value="漫画">漫画</option>
                    <option value="映画">映画</option>
                    <option value="ビジネス本">ビジネス本</option>
                </select>
                <button type="submit">表示</button>
            </form>
        </div>
        <form method="GET" action="favoriteList">
            <button class="btn_show_favorites">お気に入りの書籍を表示</button>
        </form>
        <p>
        <form method="get" action="<%=request.getContextPath()%>/searchbook" class="btn_search_book">
            <input type="text" name="search" placeholder="検索キーワードを入力してください">
            <button type="submit">検索</button>
        </form>
        </p>
        <input type="button" onclick="CheckBox" value="削除"></input>
        <div class="booklist">
            <c:forEach var="bookInfo" items="${bookList}">
                <div class="books">
                    <form method="get" class="book_thumnail" action="editBook">
                        <a href="javascript:void(0)" onclick="this.parentNode.submit();"> <c:if test="${empty bookInfo.thumbnail}">
                                <img class="book_noimg" src="resources/img/close.png">
                            </c:if> <c:if test="${!empty bookInfo.thumbnail}">
                                <img class="book_noimg" src="${bookInfo.thumbnail}">
                            </c:if>
                        </a> <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                    </form>
                    <c:if test="${bookInfo.favorite!=1}">
                        <form method="GET" action="favoriteBook" name="favorite">
                            <p align="justify">
                                <button class="btn btn-primary addtofavorite">⭐︎</button>
                                <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                            </p>
                        </form>
                    </c:if>
                    <p>
                        <c:if test="${bookInfo.favorite==1}">
                            <form method="GET" action="unfavoriteBook" name="unfavorite">
                                <p align="justify">
                                    <button class="btn btn-primary removefavorite hidden">★</button>
                                    <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                </p>
                    </p>
                    </form>
                    </c:if>
                    <ul>
                        <li class="book_title">${bookInfo.title}</li>
                        <li class="book_author">${bookInfo.author}(著）</li>
                        <li class="book_publisher">出版社：${bookInfo.publisher}</li>
                        <li class="book_publish_date">出版日：${bookInfo.publishDate}</li>
                        <li class="book_publish_genre">分類：${bookInfo.genre}</li>
                    </ul>
                    <label><input type="checkbox">削除する</label>
                </div>
            </c:forEach>
        </div>
        
    </main>
</body>
</html>
<title>TAG index Webサイト</title>
<script type="text/javascript">
	パターン1の色設定開始
	function color1() {

		document.bgColor = "#eeeeff"; // bgcolor：背景色
		document.fgColor = "#0080ff"; // text：文字の基本色
		document.linkColor = "#ff0000"; // link：リンク文字の色
		document.vlinkColor = "#ff0000"; // vlink：リンク文字の色（アクセス済みのリンク）
		document.alinkColor = "#ff8000"; // alink：リンク文字の色（クリックした瞬間の色）

	}
	// パターン1の色設定終了

	// パターン2の色設定開始
	function color2() {

		document.bgColor = "#fbeae6";
		document.fgColor = "#ff0000";
		document.linkColor = "#ff00ff";
		document.vlinkColor = "#ff00ff";
		document.alinkColor = "#ff8000";

	}
</script>
<script>
	filterSelection("all")
	function filterSelection(c) {
		var x, i;
		x = document.getElementsByClassName("filterDiv");
		if (c == "all")
			c = "";
		for (i = 0; i < x.length; i++) {
			searchRemoveClass(x[i], "show");
			if (x[i].className.indexOf(c) > -1)
				searchAddClass(x[i], "show");
		}
	}

	function searchAddClass(element, name) {
		var i, arr1, arr2;
		arr1 = element.className.split(" ");
		arr2 = name.split(" ");
		for (i = 0; i < arr2.length; i++) {
			if (arr1.indexOf(arr2[i]) == -1) {
				element.className += " " + arr2[i];
			}
		}
	}

	function searchRemoveClass(element, name) {
		var i, arr1, arr2;
		arr1 = element.className.split(" ");
		arr2 = name.split(" ");
		for (i = 0; i < arr2.length; i++) {
			while (arr1.indexOf(arr2[i]) > -1) {
				arr1.splice(arr1.indexOf(arr2[i]), 1);
			}
		}
		element.className = arr1.join(" ");
	}

	var btnContainer = document.getElementById("searchButtonnBlock");
	var btns = btnContainer.getElementsByClassName("btn");
	for (var i = 0; i < btns.length; i++) {
		btns[i].addEventListener("click", function() {
			var current = document.getElementsByClassName("onActive");
			current[0].className = current[0].className
					.replace(" onActive", "");
			this.className += " onActive";
		});
	}
</script>
<script>const toggler = document.querySelector(".toggle");

window.addEventListener("click", event => {
  if(event.target.className == "toggle" || event.target.className == "toggle") {
    document.body.classList.toggle("show-nav");
    document.getElementById("deleteconpo").classList.toggle("deleteclass")
  } else if (event.target.className == "overlay") {
    document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
  }

});


//ドロワーのメニューをクリックしたら非表示
const hrefLink = document.querySelectorAll('.linkList li a');
for (i = 0; i < hrefLink.length; i++) {
hrefLink[i].addEventListener("click", () => {
document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
});
}</script>
<body>
    <p>
        <input type="button" value="パターン1" onClick="color1()"> <input type="button" value="パターン2" onClick="color2()">
    </p>
</body>