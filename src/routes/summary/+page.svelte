<script>
    import { summaryStore } from '../../summaryStore.js';
    import { onMount } from 'svelte';

    let summary = {
        transcriptions: [],
        summaries: [],
        highlights: "",
    };

    summaryStore.subscribe(data => {
        console.log("Data from store: ", data);
        summary = data;
    });

    async function convertResume(text) {
        const apiUrl = 'http://localhost:5001/api/convert-text';
        const payload = { text };
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
            return data;
        } catch (error) {
            console.error(error);
        }
    }

    onMount(async () => {
        for (let i = 0; i < summary.summaries.length; i++) {
            const htmlText = await convertResume(summary.summaries[i].summary);
            summary.summaries[i].summary = htmlText;
        }
    });

    let currentTab = 'summary';
</script>

<main class="container">
    <h1>Aquí está tu resumen</h1>
    <div class="tabs">
        <button on:click={() => currentTab = 'summary'}>Resumen</button>
        <button on:click={() => currentTab = 'transcriptions'}>Transcripciones</button>
        <button on:click={() => currentTab = 'highlights'}>Highlights</button>
    </div>
    {#if currentTab === 'summary'}
        <div id="summary">
            <h2>Resumen:</h2>
            <ul>
            {#each summary.summaries as item (item.segment)}
                <li>{@html item.summary}</li>
            {/each}
            </ul>
        </div>
    {:else if currentTab === 'transcriptions'}
        <div id="transcriptions">
            <h2>Transcripciones:</h2>
            <ul>
            {#each summary.transcriptions as transcript, index (index)}
                <li>{transcript}</li>
            {/each}
            </ul>
        </div>
    {:else if currentTab === 'highlights'}
        <div id="highlights">
            <h2>Highlights:</h2>
            <p>{summary.highlights}</p>
        </div>
    {/if}
    <a class="button button-primary" href="/input">Hacer otro resumen</a>
</main>

<!-- <script>
    import { summaryStore } from '../../summaryStore.js';
    import { onMount } from 'svelte';

    let summary = {
        transcriptions: [],
        summaries: [],
        highlights: "",
    };

    summaryStore.subscribe(data => {
        console.log("Data from store: ", data);
        summary = data;
    });

    async function convertTextToHTML(text) {
        // const apiUrl = 'http://ec2-54-158-67-18.compute-1.amazonaws.com:5001/api/convert-text';
        const apiUrl = 'http://localhost:5001/api/convert-text';
        const payload = { text };
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
            return data;
        } catch (error) {
            console.error(error);
        }
    }

    onMount(async () => {
        for (let i = 0; i < summary.summaries.length; i++) {
            const htmlText = await convertTextToHTML(summary.summaries[i].summary);
            summary.summaries[i].summary = htmlText;
        }
    });
</script>

<main class="container">
    <h1>Aquí está tu resumen</h1>
    <h2>Resumen:</h2>
    <ul>
    {#each summary.summaries as item (item.segment)}
        <li>{@html item.summary}</li>
    {/each}
    </ul>
    <h2>Transcripciones:</h2>
    <ul>
    {#each summary.transcriptions as transcript, index (index)}
        <li>{transcript}</li>
    {/each}
    </ul>
    <h2>Highlights:</h2>
    <p>{summary.highlights}</p>
    <a class="button button-primary" href="/input">Hacer otro resumen</a>
</main>
     -->