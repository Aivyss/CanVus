$(() => {
    $(document).on('click', '.history-folder', function () {
        console.log("히스토리 클릭");
        location.href='/bookmark/historyDetail/?pageNo=1';
    });

    $(document).on('click', '.bookmark-folders', function () {
        console.log("북마크 클릭");
        const bmId = $(this).attr('id');
        location.href=`/bookmark/detail/?folder_id=${bmId}&pageNo=1`;
    });

    $('#execute-folder-making').on('click', function(){
        const data = {
            user_id : $('#user_id').val(),
            folder_name: $('#new-folder-name').val()
        };

        // create bookmark & duplicate Check
        $.ajax({
            url:'/bookmarkRest/checkDuplicateAndCreate',
            type:'post',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType:'application/json',
            success: function(result) {
                const isSuccess = result['isSuccess'];

                if(isSuccess) {
                    console.log('일단 백단은 성공');
                    const folder_id = result['folder_id'];
                    const folder_name = data['folder_name'];
                    const folder_container = $('#folder-container');

                    const content = `
                        <div class="col-xs-3 bookmark-folders" id="${folder_id}">
                            <ul class="list-group list-group-bm mt-5 text-white">
                                <div class="col-lg-8">
                                    <li class="list-group-item list-group-item-bm d-flex justify-content-between align-content-center">
                                        <div class="d-flex flex-row">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <img src="/resources/images/defaults/folderDefault.png" width="80"/>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div class="check"><input type="checkbox" name="a"></div>
                                                </div>
                                            </div>
                                            <div class="ml-2">
                                                <h3>${folder_name}</h3>
                                                <div class="about about-bm">
                                                    <h6>NEW!</h6>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </div>
                            </ul>
                        </div>
                    `;

                    folder_container.append(content);
                    const folderForm = $('#createFolderForm');
                    folderForm.modal('toggle');
                } else {
                    alert('同じ名前のフォルダがあります。');
                }
            },
            error: function(){
                console.log("통신실패");
            }
        });
    });
});