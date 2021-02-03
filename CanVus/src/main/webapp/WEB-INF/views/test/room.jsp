<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.0/sockjs.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
		<script src="/resources/js/fabric/dist/fabric.js"></script>
		<script type="text/javascript">
			$(()=> {
				// 대강의 패브릭 객체 만들자
				var canvas = new fabric.Canvas('canvas');
				canvas.isDrawingMode = true;
				
				connect(); // 소켓 커넥트 실시

				document.onkeydown = function (event) {

					if(event.keyCode == 116 || event.ctrlKey == true && (event.keyCode == 82)) {
						disconnect(); // 소켓 커넥트 종료
						event.cancelBubble = true;
						event.returnValue = false;
						setTimeout(function() {
							window.location.reload();
						}, 100);

						return false;
					}
				}

				// 버튼을 클릭하면 보낸다. 단 실제로 이렇게 안하고 백단테스트용
				$('#btn').on('click', ()=> {
					sendFabric(canvas, 1, 2, "a");
				});
				
			}); // 레디함수 엔드

			// 소켓 클라이언트 정의
			var stompClient = null;

			// 소켓 연결부
			function connect() {
				const socket = new SockJS('/endpoint');
				stompClient = Stomp.over(socket);

				stompClient.connect({}, function(frame) {
					// fabric js 객체를 실시간으로 받아들이는 파트
					stompClient.subscribe('/subscribe/room/${room_Id}/fabric', function(result) {
						var data = JSON.parse(result.body);
						console.log(data);
					});
				});

				stompClient.connect({}, function(frame) {
					// 챗 메세지를 실시간으로 받아들이는 파트
					stompClient.subscribe('/subscribe/room/${room_Id}/chat', function(result) {
						var data = JSON.parse(result.body);
						console.log(data);
					});
				});
			}

			function sendFabric(fabricObj, page, layer, room_Id) {
				// fabric 객체를 보내는 과정 page, layer는 1, room_Id는 "a"이라 가정한다.
				// fabric 객체도 대강 하자. 위에 canvas객체로 대강 때려 넣었다.

				// stringify process
				const data = {
					room_Id : room_Id,
					page_no : page,
					layer_no : layer,
					stringify : JSON.stringify(fabricObj)
				}

				// send process
				stompClient.send('/test/room/${room_Id}/fabric', {}, JSON.stringify(data));
			}
		</script>	
	</head>
	<body>
		<canvas id="canvas" style="width : 100px; height : 200px;"></canvas>
		<input type="button" id="btn" value="전송테스트">

	</body>
</html>