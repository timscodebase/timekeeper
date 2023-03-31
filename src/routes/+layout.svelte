<script lang="ts">
	import '../reset.css';
	import '../global.css';
</script>

<div class="container">
	<header />
	<main>
		<slot />
	</main>
	<footer>Tim Smith &copy; {new Date().getFullYear()}</footer>
</div>

<style>
	.container {
		max-width: 1000px;
		margin: 0 auto;
		min-height: 100vh;
	}
</style>
