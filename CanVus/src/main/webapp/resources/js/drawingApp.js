
$(function(){

});

var brushColor = "black";
var color = new fabric.Color(brushColor).toRgba();
color = color.replaceAll('1)', opacity + ')'); // rgb+opacity
var opacity = 1;
var thickness = 5;
var undoText ='';
var redoText ='';

var canvas = new fabric.Canvas('canvas', {
  isDrawingMode: true,
});
var canvas2 = new fabric.Canvas('canvas2', {
  isDrawingMode: true,
});
var canvas3 = new fabric.Canvas('canvas3', {
  isDrawingMode: true,
});
var canvas4 = new fabric.Canvas('canvas4', {
  isDrawingMode: true,
});
var canvas5 = new fabric.Canvas('canvas5', {
  isDrawingMode: true,
});

var canvas_1_1 = new fabric.Canvas('canvas_1_1', {
  isDrawingMode: true,
});
var canvas_1_2 = new fabric.Canvas('canvas_1_2', {
  isDrawingMode: true,
});
var canvas_1_3 = new fabric.Canvas('canvas_1_3', {
  isDrawingMode: true,
});
var canvas_1_4 = new fabric.Canvas('canvas_1_4', {
  isDrawingMode: true,
});
var canvas_1_5 = new fabric.Canvas('canvas_1_5', {
  isDrawingMode: true,
});

var ctx = canvas.getContext('2d');
var ctx2 = canvas2.getContext('2d');
var ctx3 = canvas3.getContext('2d');
var ctx4 = canvas4.getContext('2d');
var ctx5 = canvas5.getContext('2d');


	 
$("#eraser").on("click", function () {
  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
  canvas.isDrawingMode = 1;
  canvas.freeDrawingBrush.width = thickness;
  canvas.freeDrawingBrush.color = "rgba(255,0,0,0.5)";
  canvas.freeDrawingBrush.globalCompositeOperation = "destination-out";
  canvas.freeDrawingBrush.id = 'erasure';
  ctx.beginPath(); // the context of canvas
  canvas.renderAll();
});

$("#drawer").on("click", function () {
  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
  canvas.isDrawingMode = 1;
  canvas.freeDrawingBrush.width = thickness;
  canvas.freeDrawingBrush.color = color;
  canvas.freeDrawingBrush.id = 'drawer';
  canvas.renderAll();
});

$("#red").on("click", function () {
  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
  canvas.isDrawingMode = 1;
  canvas.freeDrawingBrush.color = 'red';
  canvas.freeDrawingBrush.width = 30;
  canvas.freeDrawingBrush.id = 'drawer';
  canvas.calcOffset();
  canvas.renderAll();
});



$("#selection").on("click", function () {
  canvas.isDrawingMode = false;
  canvas.selection = true;
  canvas.selectable = true;
});

$('#stringify').on('click', function() {
  undoText = JSON.stringify(canvas.historyUndo);
  redoText = JSON.stringify(canvas.historyRedo);
  console.log(undoText);
  console.log(redoText);
});

$('#removal').on('click', function(){
  canvas.clearHistory();
});

$('#recover').on('click', function(){
  console.log('recover process');
  canvas.historyUndo = JSON.parse(undoText);
  canvas.historyRedo = JSON.parse(redoText);
  console.log(canvas.historyUndo);
  console.log(canvas.historyRedo);
});

function restoreSketch(imageSVG) {
  fabric.loadSVGFromString(imageSVG, function (objects, options) {
    $.each(objects, function (index, value) {
      if (value.id && value.id == 'erasure') {
        value.set({
          globalCompositeOperation: 'destination-out'
        }); //set gCO for value
      }
    });
    var obj = fabric.util.groupSVGElements(objects, options);
    canvas.add(obj).renderAll();
  });
}

// selected 된 한붓 그리기 객체를 제거하는 메소드
document.addEventListener('keyup', ({ keyCode } = event) => {
  if (keyCode === 46) {
    canvas.remove(canvas.getActiveObject());
  }
});

// redo undo 메소드, ctrl+z, ctrl+y
document.addEventListener('keyup', ({ keyCode, ctrlKey } = event) => {
  // Check Ctrl key is pressed.
  if (!ctrlKey) {
    return
  }

  // Check pressed button is Z - Ctrl+Z.
  if (keyCode === 90) {
    canvas.undo()
  }

  // Check pressed button is Y - Ctrl+Y.
  if (keyCode === 89) {
    canvas.redo()
  }
});

function baseBrush() {
  canvas.freeDrawingBrush = new fabric.BaseBrush(canvas);
}

function sprayBrush() {
  canvas.freeDrawingBrush = new fabric.SprayBrush(canvas);
}

function circleBrush() {
  canvas.freeDrawingBrush = new fabric.CircleBrush(canvas);
}

function patternBrush() {
  canvas.freeDrawingBrush = new fabric.PatternBrush(canvas);
}

function pencilBrush() {
  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
}

function getHistory() {
  console.log(canvas.historyUndo);
}

// 실시간 색정보 변경
document.addEventListener("mouseup", function(event) {
  if (canvas.freeDrawingBrush.globalCompositeOperation == "destination-out") {
    color = new fabric.Color(brushColor).toRgba();
    color = color.replaceAll('1)', opacity + ')'); // rgb+opacity
    canvas.freeDrawingBrush.color = color;
  }
})


$(function(){

	var brushColor = "black";
	var color = new fabric.Color(brushColor).toRgba();
	color = color.replaceAll('1)', opacity + ')'); // rgb+opacity
	var opacity = 1;
	var thickness = 5;
	var undoText ='';
	var redoText ='';
	
	var canvas = new fabric.Canvas('canvas', {
	  isDrawingMode: true,
	});
	var canvas2 = new fabric.Canvas('canvas2', {
	  isDrawingMode: true,
	});
	
	var ctx = canvas.getContext('2d');
	var ctx2 = canvas2.getContext('2d');
	
	$("#eraser").on("click", function () {
	  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
	  canvas.isDrawingMode = 1;
	  canvas.freeDrawingBrush.width = thickness;
	  canvas.freeDrawingBrush.color = "rgba(255,0,0,0.5)";
	  canvas.freeDrawingBrush.globalCompositeOperation = "destination-out";
	  canvas.freeDrawingBrush.id = 'erasure';
	  ctx.beginPath(); // the context of canvas
	  canvas.renderAll();
	});
	
	$("#drawer").on("click", function () {
	  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
	  canvas.isDrawingMode = 1;
	  canvas.freeDrawingBrush.width = thickness;
	  canvas.freeDrawingBrush.color = color;
	  canvas.freeDrawingBrush.id = 'drawer';
	  canvas.renderAll();
	});
	
	$("#red").on("click", function () {
	  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
	  canvas.isDrawingMode = 1;
	  canvas.freeDrawingBrush.color = 'red';
	  canvas.freeDrawingBrush.width = 30;
	  canvas.freeDrawingBrush.id = 'drawer';
	  canvas.calcOffset();
	  canvas.renderAll();
	});
	
	$("#selection").on("click", function () {
	  canvas.isDrawingMode = false;
	  canvas.selection = true;
	  canvas.selectable = true;
	});
	
	$('#stringify').on('click', function() {
	  undoText = JSON.stringify(canvas.historyUndo);
	  redoText = JSON.stringify(canvas.historyRedo);
	  console.log(undoText);
	  console.log(redoText);
	});
	
	$('#removal').on('click', function(){
	  canvas.clearHistory();
	});
	
	$('#recover').on('click', function(){
	  console.log('recover process');
	  canvas.historyUndo = JSON.parse(undoText);
	  canvas.historyRedo = JSON.parse(redoText);
	  console.log(canvas.historyUndo);
	  console.log(canvas.historyRedo);
	});
	
	function restoreSketch(imageSVG) {
	  fabric.loadSVGFromString(imageSVG, function (objects, options) {
	    $.each(objects, function (index, value) {
	      if (value.id && value.id == 'erasure') {
	        value.set({
	          globalCompositeOperation: 'destination-out'
	        }); //set gCO for value
	      }
	    });
	    var obj = fabric.util.groupSVGElements(objects, options);
	    canvas.add(obj).renderAll();
	  });
	}
	
	// selected 된 한붓 그리기 객체를 제거하는 메소드
	document.addEventListener('keyup', ({ keyCode } = event) => {
	  if (keyCode === 46) {
	    canvas.remove(canvas.getActiveObject());
	  }
	});
	
	// redo undo 메소드, ctrl+z, ctrl+y
	document.addEventListener('keyup', ({ keyCode, ctrlKey } = event) => {
	  // Check Ctrl key is pressed.
	  if (!ctrlKey) {
	    return
	  }
	
	  // Check pressed button is Z - Ctrl+Z.
	  if (keyCode === 90) {
	    canvas.undo()
	  }
	
	  // Check pressed button is Y - Ctrl+Y.
	  if (keyCode === 89) {
	    canvas.redo()
	  }
	});
	
	function baseBrush() {
	  canvas.freeDrawingBrush = new fabric.BaseBrush(canvas);
	}
	
	function sprayBrush() {
	  canvas.freeDrawingBrush = new fabric.SprayBrush(canvas);
	}
	
	function circleBrush() {
	  canvas.freeDrawingBrush = new fabric.CircleBrush(canvas);
	}
	
	function patternBrush() {
	  canvas.freeDrawingBrush = new fabric.PatternBrush(canvas);
	}
	
	function pencilBrush() {
	  canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
	}
	
	function getHistory() {
	  console.log(canvas.historyUndo);
	}
	
	// 실시간 색정보 변경
	document.addEventListener("mouseup", function(event) {
	  if (canvas.freeDrawingBrush.globalCompositeOperation == "destination-out") {
	    color = new fabric.Color(brushColor).toRgba();
	    color = color.replaceAll('1)', opacity + ')'); // rgb+opacity
	    canvas.freeDrawingBrush.color = color;
	  }
	})
	
	$(function(){
	  $('.canvas-container').mousedown(function (e) {
	    console.log("canvas Container");
	    // rgb값 추출
	    brushColor = document.getElementsByClassName('hexInput')[0].value;
	    // 투명도 값 추출
	    opacity = parseFloat(document.getElementById('opacity').value);
	    // 굵기 추출
	    thickness = parseInt(document.getElementById('thickness').value);
	  
	    color = new fabric.Color(brushColor).toRgba();
	    color = color.replaceAll('1)', opacity + ')'); // rgb+opacity
	    canvas.freeDrawingBrush.color = color;
	    canvas.freeDrawingBrush.width = thickness;
	  });
	
	  canvas.renderAll();
	})
	

});

