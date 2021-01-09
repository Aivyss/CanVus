<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
				<div>
			<canvas id="canvas" width="300px" height="300px"></canvas>
		</div>
		
		<div class="AI model">
			<div>Teachable Machine Image Model</div>
		    <button type="button" onclick="init()">Start</button>
		    <div id="webcam-container"></div>
		    <div id="label-container"></div>
		    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
		    <script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
		    <script type="text/javascript">
		        // More API functions here:
		        // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image
		
		        // the link to your model provided by Teachable Machine export panel
		        const URL = "../my_model/";
		
		        let model, webcam, labelContainer, maxPredictions;
	
		        // Load Canvas
		        var draw = canvas.getContext("2d");
		        
		        var img = new Image();
		        img.src = "../../../resources/image/miku.jpg";
		        img.onload = function() {
					draw.drawImage(img, 50, 50, 300, 300 );
				}
		        
		        // Load the image model and setup the webcam
		        async function init() {
		            const modelURL = "https://storage.googleapis.com/tm-model/9pDoSysvl/model.json";
		            const metadataURL = "https://storage.googleapis.com/tm-model/9pDoSysvl/metadata.json";
		
		            // load the model and metadata
		            // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
		            // or files from your local hard drive
		            // Note: the pose library adds "tmImage" object to your window (window.tmImage)
		            model = await tmImage.load(modelURL, metadataURL);
		            maxPredictions = model.getTotalClasses();
		
		            // Convenience function to setup a webcam
		            window.requestAnimationFrame(loop);
		
		            // append elements to the DOM
		            labelContainer = document.getElementById("label-container");
		            for (let i = 0; i < maxPredictions; i++) { // and class labels
		                labelContainer.appendChild(document.createElement("div"));
		            }
		        }
		
		        async function loop() {
		            await predict();
		        }
		
		        // run the webcam image through the image model
		        async function predict() {
		            // predict can take in an image, video or canvas html element
		            const prediction = await model.predict(document.getElementById("canvas"));
		            for (let i = 0; i < maxPredictions; i++) {
		                const classPrediction = prediction[i].className + ": " + prediction[i].probability.toFixed(2);
		                labelContainer.childNodes[i].innerHTML = classPrediction;
		            }
		        }
		    </script>
		</div>
	</body>
</html>