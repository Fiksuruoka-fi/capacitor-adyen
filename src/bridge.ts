import { registerPlugin } from '@capacitor/core';

import type { AdyenPlugin } from './definitions';

export const Adyen = registerPlugin<AdyenPlugin>('Adyen', {
  web: () => import('./web').then((m) => new m.AdyenWeb()),
});
