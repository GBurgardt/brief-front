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

    async function convertHighlights(text) {
        const apiUrl = 'http://ec2-54-158-67-18.compute-1.amazonaws.com/api/convert-highlights';
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

    async function convertResume(text) {
        const apiUrl = 'http://ec2-54-158-67-18.compute-1.amazonaws.com/api/convert-text';
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
        const htmlHighlights = await convertHighlights(summary.highlights);
        summary.highlights = htmlHighlights;

        for (let i = 0; i < summary.summaries.length; i++) {
            const htmlText = await convertResume(summary.summaries[i].summary);
            summary.summaries[i].summary = htmlText;
        }
    });

    let currentTab = 'summary';
</script>


<main class="container" style="margin-top: 2rem;">
    <div class="tabs" style="margin-bottom: 2rem;"> 
        <button on:click={() => currentTab = 'summary'}>Resumen</button>
        <button on:click={() => currentTab = 'transcriptions'}>Transcripciones</button>
        <button on:click={() => currentTab = 'highlights'}>Highlights</button>
    </div>
    {#if currentTab === 'summary'}
        <div id="summary" style="margin-bottom: 2rem;">
            
            <div>
            {#each summary.summaries as item (item.segment)}
                <div>{@html item.summary}</div>
            {/each}
            </div>
        </div>
    {:else if currentTab === 'transcriptions'}
        <div id="transcriptions" style="margin-bottom: 2rem;">
            
            <div>
            {#each summary.transcriptions as transcript, index (index)}
                <div>{transcript}</div>
            {/each}
            </div>
        </div>
    {:else if currentTab === 'highlights'}
        <div id="highlights" style="margin-bottom: 2rem;">
            <!-- <p>{summary.highlights}</p> -->
            {@html summary.highlights}
        </div>
    {/if}
    <a class="button button-primary" href="/input" style="margin-bottom: 2rem;">
        Hacer otro resumen
    </a>
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

    async function convertResume(text) {
        const apiUrl = 'http://ec2-54-158-67-18.compute-1.amazonaws.com/api/convert-text';
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
</main> -->
