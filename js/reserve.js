document.getElementById('reserveBtn').addEventListener('click',function(e){
    e.preventDefault();
    var form=document.getElementById('reservationForm');
    if(form.style.display==='none' || form.style.display===''){
        form.style.display='block';
    }
    else{
        form.style.display='none';
    }
});

function BookTable()
{
    var name =document.getElementById('name').value;
    var email =document.getElementById('email').value;
    // var date =document.getElementById('reservationDate').value;
    // var time =document.getElementById('reservationTime"').value;
    var people =document.getElementById('number').value;
    var contact =document.getElementById('contact').value;

var mailtoUrl = 'mailto:tarunkataruka22@outlook.com'
+ '?subject=' + encodeURIComponent('Table Reservation Request')
+ '&body=' + encodeURIComponent (
        'NAME:' + name + '\n'+
        'EMAIL:' + email + '\n'+
        // 'DATE:' + date + '\n'+
        // 'TIME:' + time + '\n'+
        'GUESTS:' + people + '\n'+
        'CONTACT NUMBER:' + contact
);
window.location.href=mailtoUrl
}
    

