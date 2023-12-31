document.getElementById('reserveBtn').addEventListener('click',function(e){
    e.preventDefault();
    var form= document.getElementById('reservationForm');
    if(form.style.display==='none'|| form.style.display===''){
        form.style.display='block';
    }
    else{
        form.style.display='none';
    }
});

document.getElementById('form').addEventListener('submit',function(event){
    event.preventDefault();
    alert('Reservation submitted!');
});