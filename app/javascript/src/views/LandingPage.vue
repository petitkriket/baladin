<template>
  <div>
    <BContainer>
      <BRow
        :style="{ height: '70vh'}"
        class="d-flex align-items-center pt-5 pt-md-0"
      >
        <BCol
          :sm="12"
          :md="5"
          :order-md="1"
          :order="2"
          class="pt-5"
        >
          <h1>Ceci est un titre</h1>

          <p class="lead my-4">
            Nulla placerat, ligula vitae ultrices ultrices, libero turpis viverra lacus,
            ac congue orci lectus a orci.
          </p>
          <div class="d-flex align-items-start flex-column">
            <BButton
              size="lg"
              variant="primary"
              pill
            >
              Trouver le Passager le plus proche
            </BButton>

            <BButton
              variant="link"
              class="mt-2 text-info"
            >
              Voir la carte
            </BButton>
          </div>

          <p class="text-muted small my-3">
            Les oeuvres s'echangent gratuitement et sans aucune contrepartie
          </p>
        </Bcol>

        <BCol
          :order="1"
          :order-md="2"
          :offset-md="1"
        >
          <b-img
            src="https://picsum.photos/800/600/?image=404"
            :style="{ borderRadius: '5%'}"
            fluid
            class="shadow-sm"
            alt="Fluid image"
          />
        </Bcol>
      </BRow>
    </BContainer>

    <section class="w-100 bg-white py-5">
      <BContainer>
        <BRow>
          <h2>Comment ca marche ?</h2>
        </BRow>
        <BRow>
          <BCol :cols="4">
            ...
          </BCol>
          <BCol
            :cols="7"
            class="d-flex flex-column"
            :style="{ gap: '10px' }"
          >
            <BCol>
              <PhNumberCircleOne :size="42" />
              Envoyez un message a la personne proche d'un endroit ou vous pouvez
              récupérer un Passager.
            </BCol>

            <BCol>
              <PhNumberCircleTwo :size="42" />
              Si la personnee vous repond, convenew d'un rendez-vous.
              Vous pouvez aussi envisager un envoi postal
            </BCol>

            <BCol>
              <PhNumberCircleThree :size="42" />
              Une fois que la personne vous a transmis le Passager, rendez-vous
              sur le lien gravé sur le passager pour enregistrer
              votre participation.
            </BCol>

            <BCol>
              <PhNumberCircleFour :size="42" />
              Profitez du Passager qui vous a été donné 🎉
              Vous pouvez le transmettre à la personne de votre choix ou a une personne
              vous ayant contacté via la plateforme.
            </BCol>
          </BCol>
        </BRow>
      </BContainer>
    </section>
  </div>
</template>

<script>
import { BImg, BButton } from 'bootstrap-vue';
import {
  PhNumberCircleOne, PhNumberCircleTwo,
  PhNumberCircleThree, PhNumberCircleFour,
} from 'phosphor-vue';

export default {
  name: 'LandingPage',
  components: {
    BButton,
    BImg,
    PhNumberCircleOne,
    PhNumberCircleTwo,
    PhNumberCircleThree,
    PhNumberCircleFour,
  },
  metaInfo() {
    return {
      title: this.$t('passwordRecoveryPage.recoverPassword'),
    };
  },
};
</script>
