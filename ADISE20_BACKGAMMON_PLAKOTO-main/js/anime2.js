const tl = gsap.timeline({defaults: { ease: 'power1.out' } });


tl.fromTo('nav', {opacity: 0}, {opacity: 1, duration: 1 });
tl.fromTo('.userInput_test', {opacity: 0}, {opacity: 1, duration: 1 }, "-=1");