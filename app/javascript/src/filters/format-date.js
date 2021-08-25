import dayjs from 'dayjs';
import localizedFormat from 'dayjs/plugin/localizedFormat';
import 'dayjs/locale/fr';
import 'dayjs/locale/en';

import i18n from '../plugins/i18n';

dayjs.extend(localizedFormat);
dayjs.locale(i18n.locale);

const formatDate = (value, format) => {
  if (!value) return '-';
  return dayjs(value).format(format);
};

export { dayjs, formatDate };
