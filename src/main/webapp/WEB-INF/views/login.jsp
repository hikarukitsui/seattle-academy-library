<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<meta name="description" content="社内の書籍検索や貸出を行うことができます。" />
<meta name="robots" content="noindex,nofollow" />
<meta http-equiv="content-type" content="text/html" charset="utf-8" />
<title>ログイン｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet" type="text/css">
<style>
/* モーダルのスタイル */
.modal {
	display: none;
	position: fixed;
	z-index: 9999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #fff;
	padding: 20px;
}

.close-btn {
	float: right;
	cursor: pointer;
}
</style>
</head>
<body>
    <div class="wrapper">
        <div class="authorization_head">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="authorization">
            <div class="authorization_form">
                <form method="post" action="login">
                    <div class="title">ログイン</div>
                    <label class="label">メールアドレス</label> <input type="text" class="input" name="email" id="email" autocomplete="off" required /> <label class="label">パスワード</label> <input type="password" class="input" id="password" name="password" required />
                    <c:if test="${!empty errorMessage}">
                        <div class="error">${errorMessage}</div>
                    </c:if>
                    <input type="submit" class="button primary" value="ログイン" />
                </form>
            </div>
            <div class="authorization_navi">
                <label class="authorization_text">アカウントをお持ちでない方</label> <a class="authorization_link marker" href="<%=request.getContextPath()%>/newAccount">アカウント作成</a>
            </div>
            <div class="authorization_navi">
                <label class="authorization_text">パスワードをお忘れの方</label> <br> <a class="authorization_link marker" href="<%=request.getContextPath()%>/PasswordReset">パスワードをリセット</a>
            </div>
        </div>
        <div class="wave">
            <canvas id="waveCanvas" width="800" height="200"></canvas>
        </div>
        <script>
    var unit = 100,
        canvasList,
        info = {},
        colorList;

    function init() {
      info.seconds = 0;
      info.t = 0;
      canvasList = [];
      colorList = [];
      canvasList.push(document.getElementById("waveCanvas"));
      colorList.push(['#333', '#666', '#111']);
      
      for (var canvasIndex in canvasList) {
        var canvas = canvasList[canvasIndex];
        canvas.width = document.documentElement.clientWidth;
        canvas.height = 200;
        canvas.contextCache = canvas.getContext("2d");
      }
      
      update();
    }

    function update() {
      for (var canvasIndex in canvasList) {
        var canvas = canvasList[canvasIndex];
        draw(canvas, colorList[canvasIndex]);
      }
      
      info.seconds = info.seconds + .014;
      info.t = info.seconds * Math.PI;
      
      setTimeout(update, 35);
    }

    function draw(canvas, color) {
      var context = canvas.contextCache;
      context.clearRect(0, 0, canvas.width, canvas.height);

      drawWave(canvas, color[0], 0.5, 3, 0);
      drawWave(canvas, color[1], 0.4, 2, 250);
      drawWave(canvas, color[2], 0.2, 1.6, 100);
    }

    function drawWave(canvas, color, alpha, zoom, delay) {
      var context = canvas.contextCache;
      context.fillStyle = color;
      context.globalAlpha = alpha;
      context.beginPath();
      drawSine(canvas, info.t / 0.5, zoom, delay);
      context.lineTo(canvas.width + 10, canvas.height);
      context.lineTo(0, canvas.height);
      context.closePath();
      context.fill();
    }

    function drawSine(canvas, t, zoom, delay) {
      var xAxis = Math.floor(canvas.height / 2);
      var yAxis = 0;
      var context = canvas.contextCache;
      var x = t;
      var y = Math.sin(x) / zoom;
      context.moveTo(yAxis, unit * y + xAxis);

      for (i = yAxis; i <= canvas.width + 10; i += 10) {
        x = t + (-yAxis + i) / unit / zoom;
        y = Math.sin(x - delay) / 3;
        context.lineTo(i, unit * y + xAxis);
      }
    }

    init();
  </script>
        <footer>
            <div class="copyright">© 2019 Seattle Consulting Co., Ltd. All rights reserved.</div>
        </footer>
    </div>
    <button onclick="openModal()">Open Modal</button>
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h2>Modal Content</h2>
            <p>This is a modal window. You can put any content here.</p>
        </div>
    </div>
    <script>
    function openModal() {
      var modal = document.getElementById("modal");
      modal.style.display = "block";
    }
    
    function closeModal() {
      var modal = document.getElementById("modal");
      modal.style.display = "none";
    }
  </script>
    <script const doObserve=(element)=> {
  const targets = document.querySelectorAll('.typeWriter'); /* ターゲットの指定 */
  const options = {
    root: null,
    rootMargin: '0px',
    threshold: 0
  };
  const observer = new IntersectionObserver((items) => {
    items.forEach((item) => {
      if (item.isIntersecting) {

const typeWriter = selector => {
  const el = document.querySelector(selector);
  const text = el.innerHTML;

  (function _type(i = 0) {
    if (i === text.length) return;
    el.innerHTML = text.substring(0, i + 1) + '<span aria-hidden="true"></span>';
    setTimeout(() => _type(i + 1), 150);
  })();
};

typeWriter(".typeWriter");
      } else {
        item.target.classList.remove('typing'); /* 表示域から外れた時にターゲットから削除するclassの指定 */
      }
    });
  }, options);
  Array.from(targets).forEach((target) => {
    observer.observe(target);
  });
};
doObserve('.observe_target');
</script>
</body>
</html>
