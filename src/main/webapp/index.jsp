<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	margin-top: 50px;
}

.main-area {
	margin: 10px 10px 10px 10px;
	height: 300px;
}

#log {
	position: relative;
	height: 300px;
	border: 1px dotted;
}

#message {
	width: 90%;
}
</style>
<script src="//code.jquery.com/jquery-1.11.0.js"></script>
<script src="//cdn.sockjs.org/sockjs-0.3.min.js"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	var ws = [];
	var url = "<%= request.getRequestURL().toString() %>".replace(/^https?:\/\/(.+?)\/.*$/, "$1");

	if ("WebSocket" in window) {
		ws = new WebSocket("ws://" + url + "/<%= request.getContextPath() %>/app/echo");
	} else {
		ws = new SockJS(
				"http://" + url + "/<%= request.getContextPath() %>/app/sockjs/echo",
					undefined, {
						protocols_whitelist : []
					});
		}

		ws.onopen = function() {
			//alert("onOpen");
		};

		ws.onclose = function() {
			//alert("onClose");
		};

		ws.onmessage = function(message) {
			$("#log").append(message.data).append("<br/>");
			$("#message").val("");
		};

		ws.onerror = function(event) {
			alert("WebSocketエラー");
		};

		$("#form").submit(function() {
			ws.send($("#message").val());
			return false;
		});
	});
</script>

</head>

<body>

	<nav class="navbar navbar-fixed-top navbar-inverse" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp">Top</a>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="#">Menu1</a></li>
					<li><a href="#">Menu2</a></li>
					<li><a href="#">Menu3</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="main-area">
		<div class="container" id="log"></div>
	</div>

	<div class="container">
		<form id="form" action="#">
			<input type="text" id="message" /><input type="submit" id="send" value="送信" />
		</form>
	</div>
</body>

</html>