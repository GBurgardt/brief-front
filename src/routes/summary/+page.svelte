
<!-- src/routes/summary.svelte -->
<script>
import { summaryStore } from '../../summaryStore.js';

let summary = {
    transcriptions: [],
    summaries: [],
    highlights: "",
};

summaryStore.subscribe(data => {
    console.log("Data from store: ", data   );
    summary = data;
});
</script>

<main class="container">
    <!-- <div class="container">
        <h1>Análisis del video</h1>
        <h2>Resumen</h2>
        <p>El video plantea reflexiones acerca del cambio constante de partidos políticos en Estados Unidos en contraste con la estabilidad del Partido Comunista en China. Sin embargo, se señala que, a pesar de estos cambios en EE. UU., la política pública no sufre modificaciones significativas.</p>
        <h2>Comparación con China</h2>
        <p>En China, aunque el Partido Comunista se mantiene en el poder, la política pública experimenta cambios revolucionarios. A pesar de la apertura de China al mercado internacional, el Partido Comunista no se deja dominar por los capitalistas.</p>
        <h2>Situación en Estados Unidos</h2>
        <p>En contraposición, en Estados Unidos se sugiere que los oligarcas y capitalistas ejercen un gran control sobre la política. Destacando la influencia de los grupos de interés y la legalización del lobby.</p>
        <h2>Conclusiones</h2>
        <p>El análisis final indica que en China, aunque existe un mercado próspero, el poder del capital no puede sobreponerse al poder político del Partido Comunista. En comparación con Estados Unidos, las empresas y magnates en China pueden ser restringidos por el partido si no representan los intereses del proletariado.</p>
        <div class="row">
            <a class="button button-primary" href="/analisis-anterior">Ver análisis anterior</a>
            <a class="button button-primary" href="/nuevo-analisis">Hacer otro análisis</a>
        </div>
    </div> -->
    
    <h1>Aquí está tu resumen</h1>
    <h2>Resumen:</h2>
    <ul>
    {#each summary.summaries as item (item.segment)}
        <li>Segmento {item.segment}: {item.summary}</li>
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
  
<!-- 
<main class="container">
    <h1>Aquí está tu resumen</h1>
    <p>Resumen del video...</p> 
    <a class="button button-primary" href="/input">Hacer otro resumen</a>
</main> -->
