
<script>
// Lazy loading implementation for all images
document.addEventListener('DOMContentLoaded', function() {
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.remove('lazy');
                imageObserver.unobserve(img);
            }
        });
    });

    images.forEach(img => imageObserver.observe(img));

    // Fallback for browsers without IntersectionObserver
    if (!window.IntersectionObserver) {
        images.forEach(img => {
            img.src = img.dataset.src;
        });
    }
});

// Memory optimization: Clean up unused elements
window.addEventListener('load', function() {
    // Remove preloader if exists
    const preloader = document.getElementById('hellopreloader');
    if (preloader) {
        setTimeout(() => {
            preloader.style.display = 'none';
            preloader.remove();
        }, 1000);
    }
    
    // Defer non-critical animations
    setTimeout(() => {
        document.body.classList.add('animations-ready');
    }, 500);
});
</script>
