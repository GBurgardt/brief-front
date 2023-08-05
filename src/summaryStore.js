// src/summaryStore.js
import { writable } from 'svelte/store';

// Creamos un store con estado inicial vacío
export const summaryStore = writable({
  transcriptions: [],
  summaries: [],
  highlights: "",
});
