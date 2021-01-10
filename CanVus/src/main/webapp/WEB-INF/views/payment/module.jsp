<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	</head>
	<body>
		<h1>결제모듈 삽입테스트</h1>
		<input type="button" onclick="requestPay();" value="결제하기"><br>
		pixel: 100 <input type="radio" value="pixel: 100" name="pixelOption"> <br>
		pixel: 500 <input type="radio" value="pixel: 500" name="pixelOption"> <br>
		pixel: 1k  <input type="radio" value="pixel: 1000" name="pixelOption"><br>
		pixel: 3k  <input type="radio" value="pixel: 3000" name="pixelOption"><br>
		pixel: 5k  <input type="radio" value="pixel: 5000" name="pixelOption"><br>
		아이디 히든 <input type="hidden" value='${sessionScope.userId }' id='userId'> <br>
		파싱된 merchantUID <input type="hidden" value='${merchant_uid}' id='merchantUid'>
		<script type="text/javascript">
			var productName = '';
			const userId = document.getElementById('userId').value;

			const IMP = window.IMP;
	 		IMP.init("imp01277842"); // 가맹점 식별코드
	 		const pg = 'html5_inicis'; //결제 pg사 선택
	 		const pay_method = 'card'; // 결제종류
			var merchant_uid = '';
	 		const name = productName; // 상품명
	 		const amount = 1004; // 가격(원)
			const buyer_email = 'hklee6417@gmail.com';
			const buyer_name = '이한결';
			const buyer_tel = '010-6664-7104';
			const buyer_addr = '화성시 능동 동탄숲속로96';
			const buyer_postcode = '18430';
			const m_redirect_url = 'main';

			$('input[name=pixelOption]').click(function(){
				productName = $('input[name=pixelOption]:checked').val();
				console.log(productName);

				merchant_uid = {'merchant_uid': userId + "+" + productName + "+" + new Date().getTime()}

				$.ajax({ // merchant_uid 파싱
					url : '/payment/parseMerchantUid',
					type: "POST",
					data : merchant_uid,
					success : function(result) {
						merchant_uid = document.getElementById('merchantUid').value;
						console.log(merchant_uid);
					},
					error: function() {
						console.log("merhcant uid 파싱에러");
					}
				});
				
			});


			



			function requestPay() {
				console.log('start payment');
				
				IMP.request_pay({
					pg: "html5_inicis",
					pay_method: pay_method,
					merchant_uid: merchant_uid,
					name: productName,
					amount: amount,
					buyer_email: buyer_email,
					buyer_name: buyer_name,
					buyer_tel: buyer_tel,
					buyer_addr: buyer_addr,
					buyer_postcode: buyer_postcode
				}, function(rsp) {
					if ( rsp.success ) {
						var msg = '결제가 완료되었습니다.';
						msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;
						
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
					}

					alert(msg);
				});
			}

		</script>		
	</body>
</html>