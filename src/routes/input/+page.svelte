<!-- src/routes/input.svelte -->
<script>
  import { navigate } from 'svelte-routing';
  import { summaryStore } from '../../summaryStore.js';
  
  import { goto } from '$app/navigation';

    function routeToPage(route, replaceState) {
      goto(`/${route}`, { replaceState }) 
    }
  
  let url = '';
  let isLoading = false;

  async function getSummary() {
    isLoading = true;
    const apiUrl = 'http://ec2-54-158-67-18.compute-1.amazonaws.com:5001/api/process-audio';
    const payload = { url };
    try {
      const response = await fetch(apiUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      if (!response.ok) {
        throw new Error("Error en la respuesta del servidor");
      }
      const data = await response.json();
      summaryStore.set(data); // Actualizamos el store con los datos recibidos
      isLoading = false;
      // navigate("/summary"); // Redireccionamos a la página de resumen
      routeToPage("summary", true); 
    } catch (error) {
      isLoading = false;
      console.error(error);
      // manejar error
    }
  }
</script>


<main class="container">
  <h1>Pega la URL del video</h1>
  <input class="u-full-width" type="text" bind:value={url} placeholder="URL del video de YouTube" />
  <button class="button button-primary" on:click={getSummary} disabled={isLoading}>
    {#if isLoading}
      Cargando...
    {:else}
      Obtener resumen
    {/if}
  </button>
</main>

