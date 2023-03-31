<script lang="ts">
	import type { Entry, Timecard } from '@prisma/client';
	import TimecardComp from '$lib/timecard.svelte';

	async function getTimecards() {
		const response = await fetch('/api/timecards');
		const timecards: Timecard[] = await response.json();
		return timecards;
	}
</script>

<h1>Time Card</h1>
<p>My own personal timekeeping system</p>

{#await getTimecards()}
	<p>Loading...</p>
{:then timecards}
	<p>You have {timecards.length} {timecards.length > 1 ? 'timecards' : 'timecard'}.</p>

	<div class="grid">
		{#each timecards as timecard}
			<TimecardComp {timecard} />
		{/each}
	</div>
{:catch error}
	<p>{error.message}</p>
{/await}

<style>
	.grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		grid-gap: 1rem;
	}
</style>
