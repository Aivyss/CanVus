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
		<input type="button" onclick="requestPay();" value="결제하기">
		<input type="button" onclick="fakeRequestPay();" value="결제하기 테스트">
		
				
 		<script type="text/javascript">
	 		var IMP = window.IMP;
	 		IMP.init("imp01277842"); // 가맹점 식별코드

	 		const pg = 'inicis';
	 		const pay_method = 'card';
	 		const merchant_uid = 'canvus';
	 		const name = 'canvus pixel: 500'; // 상품명
	 		const amount = 50000; // 가격(원)
	 		const buyer_email = 'hklee6417@gmail.com';
	 		const buyer_name = '이한결';
	 		const buyer_tel = '010-6664-7104';
	 		const buyer_addr = '화성시 능동 동탄숲속로96';
	 		const buyer_postcode = '18430';
	 		const m_redirect_url = '/';

	 		function requestPay (){
		 		console.log('start payment');
	 			IMP.request_pay({
		 		    pg : pg, // version 1.1.0부터 지원.
		 		    pay_method : pay_method,
		 		    merchant_uid : merchant_uid + new Date().getTime(),
		 		    name : name,
		 		    amount : amount,
		 		    buyer_email : buyer_email,
		 		    buyer_name : buyer_name,
		 		    buyer_tel : buyer_tel,
		 		    buyer_addr : buyer_addr,
		 		    buyer_postcode : buyer_postcode,
		 		    m_redirect_url : m_redirect_url
		 		}, function(rsp) {
		 		    if ( rsp.success ) {
		 		        var msg = '결제가 완료되었습니다.';
		 		        msg += '고유ID : ' + rsp.imp_uid;
		 		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		 		        msg += '결제 금액 : ' + rsp.paid_amount;
		 		        msg += '카드 승인번호 : ' + rsp.apply_num;

		 		        var paymentInfo = {
							imp_uid : rsp.imp_uid,
							merchant_uid : rsp.merchant_uid,
							paid_amount : rsp.paid_amount,
							apply_num : rsp.apply_num
				 		};

				 		$.ajax({ // 결제 완료 정보를 서버단으로 전달
					 		url : '/payment/complete',
				 			type: "POST",
					 		header : {"Content-Type" : "application/json" },
					 		data : JSON.stringify(paymentInfo)
					 	});
		 		    } else {
		 		        var msg = '결제에 실패하였습니다.';
		 		        msg += '에러내용 : ' + rsp.error_msg;
		 		    }
		 		    alert(msg);
		 		});
			}

			// 서버단 데이터 전송 테스트
	 		function fakeRequestPay () {
		 		console.log("fakeRequestPay is working");
		 		
	 			var paymentCompleteInfo = {
						imp_uid : "test_imp_uid",
						merchant_uid : "test_merchant_uid",
						paid_amount : "test_paid_amount",
						apply_num : "test_apply_num"
			 		};

		 		$.ajax({ // 결제 완료 정보를 서버단으로 전달
			 		url : '/payment/complete',
		 			method: "post",
			 		type: "json",
			 		data : JSON.stringify(paymentCompleteInfo)
			 	});
			}
 		</script>		
	</body>
</html>