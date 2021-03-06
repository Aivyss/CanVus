<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up Process..</title>
    <!-- CSS part -->
    <link rel="stylesheet" href="/resources/css/user/signup/signupSkeleton.css">

</head>
<body>
<!-- 상단 네비 -->
<jsp:include page="/WEB-INF/views/baseJSP/mainMenu.jsp"></jsp:include>

<!-- JS part -->
<script src="/resources/js/user/signup/signup.js"></script>

<!-- body part -->
<div class="container logreg-forms">
    <div class="row" style="display:flex;">
        <!-- profile preview-->
        <div class="col-md-5 avatar-container text-center"
             style="order: 1; vertical-align: middle; display: table-cell;">
            <img src="/resources/images/defaults/profileDefault.png"
                 class="img-circle profile-avatar"
                 alt="プロフィール" style="margin:50% 0; width:250px; height:250px; background-color:white;" id="photo-preview">
        </div>

        <!-- signup Form -->
        <div class="col-md-6 logreg-forms" style="order: 2; background-color: white;">
            <div class="col-xs-12" style="margin-top: 90px;">
                <form role="form" action="/user/signupSubmit" method="post" enctype="multipart/form-data"
                      id="sign-up-form">
                    <!-- 구글 토큰 -->
                    <input type="hidden" name="idToken" value="${idToken }">

                    <!-- 타이틀 부-->
                    <h2>個人情報 <small>簡単な情報が必要です。</small></h2>
                    <hr class="colorgraph">

                    <!-- 닉네임 입력 창-->
                    <div class="form-group">
                        <input type="text" name="nickname" id="nickname" class="form-control input-lg"
                               placeholder="ニックネーム" tabindex="3">
                    </div>

                    <!-- 자기소개 창 -->
                    <div class="form-group">
                            <textarea placeholder="自己紹介" style="width: 100%" id="introduction"
                                      name="introduction"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="photo_upload">プロフィール</label>
                        <input type="file" class="form-control-file" id="photo_upload" name="photo_upload"
                               onchange="readURL(this);">
                    </div>

                    <!-- 동의 창 -->
                    <div class="row">
                        <div class="col-xs-4 col-sm-3 col-md-3">
                                <span class="button-checkbox">
                                    <button type="button" class="btn btn-default" data-color="info" tabindex="7"><i
                                            class="state-icon glyphicon glyphicon-unchecked"></i>I Agree</button>
                                    <input type="checkbox" value="0" name="t_and_c" id="t_and_c" class="hidden">
                                </span>
                        </div>
                        <div class="col-xs-8 col-sm-9 col-md-9">
                            By clicking <strong class="label label-success">登録</strong>, you agree to the <a
                                href="#" data-toggle="modal" data-target="#t_and_c_m">Terms and Conditions</a> set
                            out
                            by this site, including our Cookie Use.
                        </div>
                    </div>

                    <!-- 버튼 부-->
                    <hr class="colorgraph">
                    <div class="row">
                        <div class="col-xs-12 col-md-6"><input type="submit" value="戻る" id="cancel-btn"
                                                               class="btn btn-warning btn-block btn-lg" tabindex="7">
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <a href="#" class="btn btn-success btn-block btn-lg" id="submit-btn">
                                登録
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="t_and_c_m" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">Terms &amp; Conditions</h4>
                </div>
                <div class="modal-body">
                    <p>
                        描いた絵はフィードを削除しても保存されます。しかし、絵の全ての権利は著者にあります。
                        複数の人数で描いた絵の権利はフィードを作成した時点の一緒に描いていた全ての人に同じ割合であります。
                        個人情報は利用者の苗字、名前、メールアドレス、グーグルから利用者を識別事が出来るIDが要求されます。
                        決済したピックセル(pixel)は払戻すことが出来ません。なので、決済の時ご注意ください。
                        絵の権利に関する法律的な問題は弊社と関係がありません。
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">I Agree</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
</body>
</html>