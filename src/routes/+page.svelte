<!-- <h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p> -->


<!-- src/routes/index.svelte -->
<script>
    import { onMount } from 'svelte';
    let url = '';
    let summary = '';
    let loading = false;

    async function getSummary() {
        if (!url) return;
        
        loading = true;
        const response = await fetch(`tu-api-url?videoUrl=${encodeURIComponent(url)}`);
        const data = await response.json();
        summary = data.summary;
        loading = false;
    }

    onMount(() => {
        summary = '';
    });
</script>

<main>
    <h1>Bienvenido a tu resumidor de videos</h1>

    <input type="text" bind:value={url} placeholder="Pega aquí la URL del video de YouTube" />
    <button on:click={getSummary} disabled={loading}>
        {#if loading}
        Cargando...
        {:else}
        Obtener resumen
        {/if}
    </button>

    {#if summary}
        <p>{summary}</p>
    {/if}
</main>
  