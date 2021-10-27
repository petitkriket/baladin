import Vue from 'vue';
import { VueHammer } from 'vue2-hammer';

Vue.use(VueHammer);

VueHammer.config.swipe = {
  threshold: 5,
  velocity: 0.1,
};
