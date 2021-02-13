let send = document.querySelector('.chatbox__input svg');
let body = document.querySelector('.chatbox__body')

let messageController = (function(){
    return {
        chatSend: function(){
            const data = {
                user_id: user_id,
                user_nickname: mynickname,
                message: $('#chatContainer').val()
            };

            sendMessage(data,'COMMONCHAT');
            $('#chatContainer').val("");
        },
        chatReply: function(result){
            let reply = result['message']['message'];
            let sender_id = result['message']['user_id'];
            let message_container = document.createElement("div");
            let message = `<div class="message_text"> ${reply} </div>`;

            if (sender_id == user_id) {
                message_container.className = "message sender";
            } else {
                message_container.className = "message receive";
            }

            message_container.innerHTML = message;
            body.insertBefore(message_container, body.firstChild);
        }
    }
})();

let init = (function(messageController){
    ['click', 'keyup'].forEach(event => document.addEventListener(event, handler));

    function handler(e){
        if(e.target == send  || e.keyCode == 13 ){
            messageController.chatSend();
        }
    }
})(messageController);
