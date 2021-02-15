let filter = document.getElementById('filter');
let list = document.getElementById('list');
let listItems = list.querySelectorAll('li');

//filter.focus();

filter.addEventListener('keyup', function (e) {
    let val = new RegExp(e.target.value, 'gi');
    for (let i = 0; i < listItems.length; i++) {
        if (e.target.value.length > 0) {
            let text = listItems[i].innerHTML;

            if (!text.match(val)) {
                listItems[i].classList.add('is-hidden');
            } else {
                listItems[i].classList.remove('is-hidden');
            }
        } else {
            listItems[i].classList.remove('is-hidden');
        }

    }
});