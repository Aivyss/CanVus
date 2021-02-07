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
			var layer = null;

			$(()=> {
				// 대강의 패브릭 객체 만들자
				layer= new fabric.Canvas('canvas');
				layer.isDrawingMode = true;
				
				connect(); // 소켓 커넥트 실시

				

				document.onkeydown = function (event) {

					if(event.keyCode === 116 || event.ctrlKey == true && (event.keyCode === 82)) {
						disconnect(); // 소켓 커넥트 종료
						event.cancelBubble = true;
						event.returnValue = false;
						setTimeout(function() {
							window.location.reload();
						}, 100);

						return false;
					}
				}

				// 버튼을 클릭하면 fabric 객체를 보낸다. 단 실제로 이렇게 안하고 백단테스트용
				$('#btn').on('click', ()=> {
					sendFabric(layer, 1, 1, "${room_Id}");
				});

				// 버튼을 클릭하면 챗 메세지를 보낸다. 단 실제로 이렇게 안하고 백단 테스트 용.
				$('#btn2').on('click', () => {
					sendMessage("${room_Id}", '메세지', 'Aivyss', 'commonchat');
				});

				//그려지면 전송하는 구조
				layer.on('mouse:up', function() {
					sendFabric(layer, 1, 1, "${room_Id}");
				});
			}); // 레디함수 엔드



			// 소켓 클라이언트 정의
			var chatClient = null;
			var fabricClient = null;

			// 소켓 연결부
			function connect() {
				const socket1 = new SockJS('/endpoint');
				const socket2 = new SockJS('/endpoint');
				chatClient = Stomp.over(socket1);
				fabricClient = Stomp.over(socket2);

				chatClient.connect({}, function(frame) {
					// 챗 메세지를 실시간으로 받아들이는 파트
					chatClient.subscribe('/subscribe/test/room/${room_Id}/chat', function(result) {
						var data = JSON.parse(result.body);
						console.log(data);
					});
				});

				fabricClient.connect({}, function(frame) {
					fabricClient.subscribe('/subscribe/test/room/${room_Id}/fabric', function(result) {
						const data = JSON.parse(result.body);
						console.log(data);
						console.log(data['stringify']);
						layer.loadFromJSON(data['stringify'], layer.renderAll.bind(layer));
					});
				});
			}

			// 패브릭 객체 전송 함수
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
				fabricClient.send('/test/room/${room_Id}/fabric', {}, JSON.stringify(data));
			}

			// 메세지 전송 함수
			function sendMessage(room_Id, message, nickname, type) {
				const data = {
					type : type,
					room_Id : room_Id,
					message : JSON.stringify(message)
				}

				// send process
				chatClient.send('/test/room/${room_Id}/chat', {}, JSON.stringify(data));
			}

			// 페이지 종료 이벤트 --> 소켓종료
			$(window).on('beforeunload', function() {
				var data = {'quitmessage': '일단테스트'};
				sendMessage('${room_Id}', data, '${userVO.nickname}', 'quit')
				
				chatClient.disconnect();
				fabricClient.disconnect();
			});
		</script>	
	</head>
	<body>
		<div class="container">
			<canvas id="canvas" style="width : 100px; height : 200px; border: 1px solid black;"></canvas>
			<input type="button" id="btn" value="객체 전송테스트">
			<input type="button" id="btn2" value="메세지 전송테스트">
		</div>
	</body>
</html>