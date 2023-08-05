
<!-- src/routes/loading.svelte -->
<!-- <script>
    import { summaryStore } from '../../summaryStore.js';
    import { navigate } from 'svelte-routing';
    let isLoading = true;
  
    summaryStore.subscribe(value => {
      if (value.transcriptions.length > 0) {
        isLoading = false;
        navigate('/summary');
      }
    });
  </script> -->
  
  <main class="container">
      <h1>Generando tu resumen...</h1>
      <p>Por favor, espera mientras procesamos el video.</p>
      <!-- Aquí podrías agregar una animación de carga -->
  </main>
  
<!-- 
<main class="container">
    <h1>Generando tu resumen...</h1>
    <p>Por favor, espera mientras procesamos el video.</p>
    <a class="button button-primary" href="/summary">Ver resumen</a> 
</main> -->
