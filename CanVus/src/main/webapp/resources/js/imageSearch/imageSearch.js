function getExtensionOfFilename(filename) {
    const _fileLen = filename.length;
    /**
     * lastIndexOf('.')
     * 뒤에서부터 '.'의 위치를 찾기위한 함수
     * 검색 문자의 위치를 반환한다.
     * 파일 이름에 '.'이 포함되는 경우가 있기 때문에 lastIndexOf() 사용
     */
    const _lastDot = filename.lastIndexOf('.');

    // 확장자 명만 추출한 후 소문자로 변경
    const _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();

    return _fileExt;
}

function checkExtension(extension) {
    let checker = true;

    if (extension != '.jpg'
        && extension != '.jpeg'
        && extension != '.png'
        && extension != '.gif'
        && extension != '.jfif') {
        checker = false;
    }

    return checker;
}

// More API functions here:
// https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

// the link to your model provided by Teachable Machine export panel
const URL = "../my_model/";

let model, webcam, labelContainer, maxPredictions;

// Load Canvas
let canvas = document.getElementById('canvas');
let draw = canvas.getContext("2d");

let img = new Image();
// img.src = "../resources/miku.jpg";
// img.onload = function () {
//     draw.drawImage(img, 600, 600, 0, 0);
// }

function readURL(input) {
    // TODO : 파일 확장자 체크
    const notIsFileNull = $("#photo_upload").val();
    if (notIsFileNull) {
        let fileValue = $("#photo_upload").val().split("\\");
        let fileName = fileValue[fileValue.length - 1]; // 파일명
        const extension = getExtensionOfFilename(fileName);
        const checkExt = checkExtension(extension);

        if (!checkExt) {
            alert('有効なファイルではありません。(jpg. jpeg, gif, png, jfif)');
            return false;
        }
    } else {
        alert('アップロードしようとするファイルがありません。');
        return false;
    }

    if (input.files && input.files[0]) {
        let reader = new FileReader();

        // 파일을 canvas에 업로드
        reader.onload = function (e) {
            img.src = e.target.result;
            img.onload = function () {
                draw.drawImage(img, 0, 0, 400, 400);

                // 예측 시작
                init();
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// Load the image model and setup the webcam
async function init() {
    const modelURL = "https://storage.googleapis.com/tm-model/PVS4MepCm/model.json";
    const metadataURL = "https://storage.googleapis.com/tm-model/PVS4MepCm/metadata.json";

    // load the model and metadata
    // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
    // or files from your local hard drive
    // Note: the pose library adds "tmImage" object to your window (window.tmImage)
    model = await tmImage.load(modelURL, metadataURL);
    maxPredictions = model.getTotalClasses();

    // Convenience function to setup a webcam
    window.requestAnimationFrame(loop);
}

async function loop() {
    await predict();
}

// run the webcam image through the image model
async function predict() {
    // predict can take in an image, video or canvas html element
    const prediction = await model.predict(document.getElementById("canvas"));
    
    // 예상 키워드 추출
    let maxProbability = 0;
    let maxProbabilityKeyword = '';
    
    for (let i = 0; i < maxPredictions; i++) {
        if (prediction[i].probability > maxProbability) {
            maxProbability = prediction[i].probability;
            maxProbabilityKeyword = prediction[i].className;
        }
    }
    
    // 서치 실행
    doSearch(maxProbabilityKeyword);
}