import "bootstrap";
import { initUpdateNavbarOnScroll } from '../components/navbar';
initUpdateNavbarOnScroll();

$(".hover").mouseleave(
  function () {
    $(this).removeClass("hover");
  }
);
