$(() => {
    // rgba, 굵기, 투명도의 글로벌 정보를 업데이트하는 메소드
    function colorChangeGlobal(opacity, thickness, rgb) {
        opacityGlobal = opacity;
        thicknessGlobal = thickness;
        let rgba = new fabric.Color(rgb).toRgba();
        rgbaGlobal = rgba.replaceAll('1)', opacityGlobal + ')');
    }

    function changeBrush(fabricObj) {
        if (brushGlobal == 'PencilBrush') {
            fabricObj.freeDrawingBrush = new fabric.PencilBrush(fabricObj);
        } else if (brushGlobal == "SprayBrush") {
            fabricObj.freeDrawingBrush = new fabric.SprayBrush(fabricObj);
        } else if (brushGlobal == "CircleBrush") {
            fabricObj.freeDrawingBrush = new fabric.CircleBrush(fabricObj);
        } else if (brushGlobal == "BaseBrush") {
            fabricObj.freeDrawingBrush = new fabric.BaseBrush(fabricObj);
        } else if (brushGlobal == "PatternBrush") {
            fabricObj.freeDrawingBrush = new fabric.BaseBrush(fabricObj);
        }

        fabricObj.freeDrawingBrush.color = rgbaGlobal;
        fabricObj.freeDrawingBrush.width = thicknessGlobal;
    }

    // Layer Explorer를 클릭시 현재 페이지번호, 레이어번호를 업데이트하고 현재 바라보는 레이어를 설정.
    $("#itemBoxWrap").click(function(event) {
        const layerBoxId = event.target.id;
        // 전 단계 페이지 레이어 번호 지정 및 z인덱스
        bPageNum = pageNum;
        bLayerNum = layerNum;
        bZNum = zNum;
        const bPageLayer = "p" + bPageNum + "l" + bLayerNum;
        // 전 단계 upper-canvas의 z-index를 원상복구한다.
        $('#'+bPageLayer+'u').css({"z-index": zNumSet[bPageNum-1][bLayerNum-1]});

        // 현 단계 페이지 번호 지정
        pageNum = $(layerBoxId).children('.pageNum');
        layerNum = $(layerBoxId).children('.layerNum');
        const pageLayer = "p"+pageNum+"l"+layerNum;

        // 레이어 타게팅
        currlayer = layerSet[pageNum-1][layerNum-1];
        changeBrush(currlayer);
        // 타게팅한 레이어를 그릴수 있는 upper-canvas를 가장 위에둔다. 2147483647는 z-index 최대값이다.
        $('#'+pageLayer+"u").css({"z-index": 2147483647});
    });

});