import { registerPlugin } from '@capacitor/core';

import type { AdyenPlugin } from './definitions/index';

const Adyen = registerPlugin<AdyenPlugin>('Adyen', {
  web: () => import('./web').then((m) => new m.AdyenWeb()),
});

export * from './definitions/index';
export { Adyen };
