<script lang="ts">
	import type { Entry, Timecard } from '@prisma/client';
	export let timecard: Timecard;
	let totalHours = 0;

	async function getEntries(timcardId: number) {
		const response = await fetch('/api/entries');
		const entries: Entry[] = await response.json();
		const timecardEntries = entries.filter((entry) => entry.timecardId === timcardId);
		timecardEntries.forEach((entry) => {
			totalHours += entry.numberOfHours;
		});
		return timecardEntries;
	}

	async function addEntry(event: Event) {
		const form = event.target as HTMLFormElement;
		const data = new FormData(form);

		await fetch('/api/entries', {
			method: 'POST',
			body: data
		});
	}
</script>

<div class={timecard.isLocked ? 'timecard timecard_locked' : 'timecard'}>
	<h3>Week Ending {new Date(timecard.date).toLocaleDateString('en-US')}</h3>
	<p class="info">Timecard #{timecard.id} - {timecard.numOfWeeks} week pay period.</p>
	<p class="info">Total Hours: {totalHours}</p>

	<ul>
		{#await getEntries(timecard.id)}
			<p>Loading...</p>
		{:then entries}
			{#each entries as entry}
				<li>
					<p>{entry.task} - {entry.numberOfHours} hours</p>
				</li>
			{/each}
		{:catch error}
			<p>{error.message}</p>
		{/await}
	</ul>
	{#if !timecard.isLocked}
		<h4>Add an Entry</h4>
		<form on:submit|preventDefault={addEntry}>
			<label for="task">Task</label>
			<input type="text" name="task" id="task" required />
			<label for="numberOfHours">Hours</label>
			<input type="number" max="10" name="numberOfHours" id="numberOfHours" required />
			<input type="hidden" name="timecardId" value={timecard.id} />
			<button type="submit">Add Entry</button>
		</form>
	{/if}
</div>

<style>
	.timecard {
		position: relative;
		background: var(--tc-bg);
		color: var(--tc-color);
		padding: var(--spacing);
	}

	.timecard_locked {
		border: 4px solid var(--tc-locked-border);
		filter: opacity(0.7);
	}
	.timecard_locked::before {
		content: 'APPROVED AND LOCKED';
		position: absolute;
		top: 0;
		left: 0;
		background: var(--tc-locked-bg);
		color: var(--tc-locked-color);
		padding: 0.5rem;
		font-size: 1.2rem;
		font-weight: bold;
	}

	.info {
		font-size: 1.2rem;
		font-weight: bold;
	}
</style>
