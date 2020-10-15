const like = () => {
  const hearts = document.querySelectorAll('.fa-heart');
  hearts.forEach((heart)=>{
    heart.addEventListener('click', () => {
      if (heart.classList.contains('fal')) {
        heart.classList.remove('fal');
        heart.classList.add('fas');
      }
      else if (heart.classList.contains('fas')) {
        heart.classList.remove('fas');
        heart.classList.add('fal');
      }
    })
  })
}
export { like };
