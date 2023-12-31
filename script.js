
var images = [
        'url("pic1.jpg")',
        'url("pic2.jpg")',
        'url("pic3.jpg")',
        'url("pic4.jpg")',
        'url("pic5.jpg")',
        'url("pic6.jpg")',
    ]
    function changeBackground(){
    const bg= images[Math.floor(Math.random()*images.length)];
    const sec=document.querySelector('.section')
    sec.style.backgroundImage=bg;
}
changeBackground();
setInterval(changeBackground,1000)

