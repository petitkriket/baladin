<!-- TODO: make it editable through a CMS -->
<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('aboutPage.about') }}
        </h1>

        <figure class="figure mb-4">
          <BImgLazy
            :src="require('../assets/images/affinites.jpeg')"
            fluid
            blank
            blank-color="#bbb"
            alt="Affinités"
            class="figure-img rounded"
          />
          <figcaption class="figure-caption">
            {{ $t('aboutPage.photoCredit') }} Paul Nicoué, Gallerie Jousse Entreprise - 2018.
          </figcaption>
        </figure>

        <div class="mb-5">
          <p>{{ $t('aboutPage.firstParagraph') }}</p>
          <p>{{ $t('aboutPage.secondParagraph') }}</p>
          <p>{{ $t('aboutPage.projectCredit') }}</p>
        </div>

        <div>
          <h5>{{ $t('aboutPage.publications') }}</h5>
          <ul>
            <li><a href="#">François Maurin, Les Passagers [FOCUS], Point contemporain</a></li>
            <li><a href="#">Les passagers de François Maurin, Artaïs Art contemporain</a></li>
          </ul>

          <h5>{{ $t('aboutPage.groupExhibitions') }}</h5>
          <ul>
            <li>
              <a href="#">
                Atelier Notre Dame des Champs,
                Commissariat de Julia Borderie et Simon Zaborski, Paris, 2019</a>
            </li>
            <li>
              <a href="#">Weniger ist mehr – less is more, Galerie du Crous,
                Commissariat de Maya Sachweh), Paris, 2018</a>
            </li>
            <li><a href="#">Affinité(s), Galerie Jousse Entreprise, Paris, 2018</a></li>
          </ul>

          <h5>{{ $t('aboutPage.contact') }}</h5>
          <ul>
            <li>Email : contact@pssgrs.com</li>
            <li>Facebook, Instagram</li>
          </ul>

          <h5>{{ $t('aboutPage.colophon') }}</h5>
          <ul>
            <li>Code : Samuel Bouaroua</li>
            <li>Web design : Jules Vaulont</li>
            <li>Typographie : Syne</li>
          </ul>
        </div>
      </BCol>
    </BRow>
  </BContainer>
</template>

<script>
import { BImgLazy } from 'bootstrap-vue';

export default {
  components: {
    BImgLazy,
  },
  metaInfo() {
    return {
      title: this.$t('aboutPage.about'),
    };
  },
};
</script>
