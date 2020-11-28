import 'leaflet/dist/leaflet.css';
import { Icon } from 'leaflet';

const iconRetinaUrl = require('leaflet/dist/images/marker-icon-2x.png');
const iconUrl = require('leaflet/dist/images/marker-icon.png');
const shadowUrl = require('leaflet/dist/images/marker-shadow.png');

// eslint-disable-next-line no-underscore-dangle
delete Icon.Default.prototype._getIconUrl;

Icon.Default.mergeOptions({
  iconRetinaUrl,
  iconUrl,
  shadowUrl,
});

export default {

};
