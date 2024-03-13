<template>
    <section class="about-section">
        <div class="heading">
            <h3>Our Cafe</h3>
        </div>

        <div class="row">
            <div class="about-content">
                <img src="../assets/images/dp.jpg" class="image" alt="">
                <div class="about-content-text">
                    <h2>In 2003, Lewi Café began its journey in Woliso, Ethiopia, starting as a modest establishment with no delivery services and reservations made informally through word-of-mouth. The café's primary focus was on sharing the flavors of "Lewi's secret-spiced magic" with the local community. As time passed, the café evolved, introducing delivery services facilitated by dedicated young men on bicycles and transitioning to using a paper book for reservations, reflecting its growing popularity. Lewi Café has transformed into a multifaceted establishment that serves as a restaurant, a community hub, and a meeting place where Ethiopian cuisine meets modernity. Today, Lewi Café not only offers authentic dishes but also provides a welcoming space for locals to gather, connect, and share experiences. Despite its growth and evolution, Lewi Café's core mission remains steadfast: to foster community unity and bring people together through the shared experience of food.
</h2>
                </div>
            </div>
        </div>

   
    </section>
</template>

<script>
export default {
    name: "About",
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Satisfy&display=swap");

.about-section {
    padding: 2% 9%;
    height: 80vh;
}

.about-section .about-content {
    display: flex;
    width: 100%;

}

.about-section .about-content img {
    background-color: rgb(249, 249, 249);
}

.about-section .about-content .about-content-text {
    font-size: 16px;
    padding-left: 50px;
    
}
.heading h3, .about-content-text {
    padding-top: 20px;
}

.about-section .gallery .wrapper img:nth-child(7n + 1) {
    grid-column: 2 / span 2;
}

.about-section .gallery .wrapper img:hover {
    z-index: 2;
    transform: scale(1);
}
.image{
        height: 65%;
    }

@media (max-width: 768px) {
    .about-section .about-content img {
        width: 250px;
    }

    .about-section .gallery .wrapper img:hover {
        transform: scale(2.5);
    }
    .image{
        height: 60vh;
    }

}

@media (max-width: 576px) {
    .about-section .about-content img {
        width: inherit;
    }

    .about-section .about-content {
        display: block;
    }

    .about-section .about-content .about-content-text {
        padding-left: 0px;
    }

    .about-section .gallery {
        padding: 50px 0px;
    }

    .about-section .gallery .wrapper img {
        max-width: 100%;

    }

    .about-section .gallery .wrapper {
        grid-gap: 2vmin;
    }

    .about-section .gallery .wrapper img:hover {
        transform: scale(2);
    }
    .image{
        height: 50%;
    }

}
</style>