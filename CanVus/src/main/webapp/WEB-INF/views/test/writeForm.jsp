<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
		//references to layer2
		var canvas2 = document.getElementById('layer2');
		var context2 = canvas2.getContext('2d');
		
		// references to layer3
		var canvas3 = document.getElementById('layer3');
		var context3 = canvas3.getContext('2d');
		
		// draw stuff on the layers
		context1.fillStyle = "red";
		context2.fillStyle = "blue";
		context3.fillStyle = "green";
		
		context1.fillRect(20, 20, 50, 50);
		context2.fillRect(50, 50, 50, 50);
		context3.fillRect(80, 80, 50, 50);
		
		// merge all layers onto layer1
		context1.drawImage(canvas2, 0, 0);
		context1.drawImage(canvas3, 0, 0);
		
		// save the merged drawings as an image
		// and set the img element src to that merged image
		var img = new Image();
		img.onload = function () {
		    document.getElementById("results").src = img.src;
		}
		img.src = canvas1.toDataURL();
	</script>
</head>
<body>
	<h1>피드작성 테스트 페이지</h1>
	<canvas id="layer1" width="150" height="150"></canvas>
	<canvas id="layer2" width="150" height="150"></canvas>
	<canvas id="layer3" width="150" height="150"></canvas>

</body>
</html>