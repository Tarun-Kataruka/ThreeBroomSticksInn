
var images = [
        'url("images/pic1.jpg")',
        'url("images/pic2.jpg")',
        'url("images/pic3.jpg")',
        'url("images/pic4.jpg")',
        'url("images/pic5.jpg")',
        'url("images/pic6.jpg")',
    ]
    function changeBackground(){
    const bg= images[Math.floor(Math.random()*images.length)];
    const sec=document.querySelector('.section')
    sec.style.backgroundImage=bg;
}
changeBackground();
setInterval(changeBackground,1000)

