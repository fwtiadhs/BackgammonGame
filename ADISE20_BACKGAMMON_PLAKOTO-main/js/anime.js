const tl = gsap.timeline({defaults: { ease: 'power1.out' } });


tl.to('.text', {y: "0%", duration: 1, stagger: 0.30 });
//tl.to('.slider', {y: "-100%", duration: 1.5, delay: 0.5 });
tl.to(".intro", {y: "-100%", duration: 1.5 });
tl.fromTo('nav', {opacity: 0}, {opacity: 1, duration: 1 });
tl.fromTo('.showcase', {opacity: 0}, {opacity: 1, duration: 1 }, "-=1");
tl.fromTo('h1', {opacity: 0}, {opacity: 1, duration: 1 }, "-=2");
tl.fromTo('ul', {opacity: 0}, {opacity: 1, duration: 1 }, "-=3");