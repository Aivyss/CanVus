<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script src="/resources/js/dateFormat.js"></script>
		<script src="/resources/js/dateFormat.js"></script>
	</head>
	<body>
		<h1>결제모듈 삽입테스트</h1>
		<input type="button" onclick="requestPay();" value="결제하기"><br>
		pixel: 100 <input type="radio" value="pixel: 100" name="pixelOption"> <br>
		pixel: 500 <input type="radio" value="pixel:500" name="pixelOption"> <br>
		pixel: 1k  <input type="radio" value="pixel:1000" name="pixelOption"><br>
		pixel: 3k  <input type="radio" value="pixel:3000" name="pixelOption"><br>
		pixel: 5k  <input type="radio" value="pixel:5000" name="pixelOption"><br>
		아이디 히든 <input type="hidden" value='${sessionScope.userId }' id='userId'> <br>
		
		<script type="text/javascript">
			var productName='';
			const userId = document.getElementById('userId').value;
			const IMP = window.IMP;
	 		IMP.init("imp01277842"); // 가맹점 식별코드
	 		const pg = 'html5_inicis'; //결제 pg사 선택
	 		const pay_method = 'card'; // 결제종류
			var merchant_uid = '';
	 		const name = productName; // 상품명
	 		var amount = '100'; // 가격(원)
			const buyer_email = 'hklee6417@gmail.com';
			const buyer_name = '이한결';
			const buyer_tel = '010-6664-7104';
			const buyer_addr = '화성시 능동 동탄숲속로96';
			const buyer_postcode = '18430';
			const m_redirect_url = 'main';
			var merchant_uid_parsed = '';

			$('input[name=pixelOption]').click(function(){
				productName = $('input[name=pixelOption]:checked').val();
				console.log(productName);
			});
			

			function requestPay() {
				console.log('start payment');

				merchant_uid = {'merchant_uid': userId + "+" + productName + "+" + new Date().getTime()}

				$.ajax({ // merchant_uid 파싱
					url : '/payment/parseMerchantUid',
					type: "POST",
					dataType: "json",
					async: false, // 이항목을 넣지 않으면 비동기식으로 코드 절차를 따라가지 않는다. 
					contentType: "application/json", 
					data : JSON.stringify(merchant_uid),
					success : function(result) {
						merchant_uid_parsed = result['merchant_uid'];
						console.log(merchant_uid_parsed);
					},
					error: function() {
						console.log("merhcant uid 파싱에러");
					}
				});
				
				IMP.request_pay({
					pg: "html5_inicis",
					pay_method: pay_method,
					merchant_uid: merchant_uid_parsed,
					name: productName,
					amount: amount,
					buyer_email: buyer_email,
					buyer_name: buyer_name,
					buyer_tel: buyer_tel,
					buyer_addr: buyer_addr,
					buyer_postcode: buyer_postcode
				}, function(rsp) {
					if ( rsp.success ) {
						const pixel = productName.split(':')[1];
						console.log(pixel);

						const paymentData = {
							'imp_uid': rsp.imp_uid, // 고유 ID
							'merchant_uid': rsp.merchant_uid, // 상점거래 ID
							'paid_amount': rsp.paid_amount, // 결제 금액
							'apply_num': rsp.apply_num, // 카드 승인번호
							'user_id': userId, // 거래한 유저 아이디
							'pixel': pixel, // 구입한 pixel 양
							'date': rsp.paid_at // 구매시각
						}

						$.ajax({ // 결제 내역 전송
							url : '/payment/paymentSubmit',
							type: "POST",
							dataType: "json",
							contentType: "application/json", 
							data : JSON.stringify(paymentData),
							success : function(result) {
								console.log(result['result']);
							}, error: function() {
								console.log("결제실패");
							}
						});
						
						var msg = '결제가 완료되었습니다.';
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