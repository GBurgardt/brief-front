<!-- src/routes/input.svelte -->
<script>
  let url = '';
</script>

<main class="container">
    <h1>Pega la URL del video</h1>
    <input class="u-full-width" type="text" bind:value={url} placeholder="URL del video de YouTube" />
    <a class="button button-primary" href="/loading">Obtener resumen</a>
</main>
