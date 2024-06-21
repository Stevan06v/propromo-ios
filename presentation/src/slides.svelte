<script lang="ts">
	import {
		Presentation,
		Slide,
		FitText,
		Stretch,
		Media,
		Notes,
	} from '@components'
	import propromo from './lib/assets/images/propromo.png'

	let isFullscreen = false
</script>

<Presentation>
	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="propromo-headline">
			Propromo
		</FitText>
		<FitText class="uppercase gray-1-color" data-id="propromo-content">
			Your client wants to be involved. We make it possible.
		</FitText>

		<Notes>
			<h1>Propromo</h1>

			<p>Your client wants to be involved. We make it possible.</p>
		</Notes>
	</Slide>

	<Slide
		animate
		class="flex justify-center"
		on:in={() => (isFullscreen = true)}
		on:out={() => (isFullscreen = false)}
	>
		{#if isFullscreen}
			<style>
				iframe {
					pointer-events: auto !important;
				}

				.slides {
					inset: unset !important;
					transform: none !important;
					width: 100vw !important;
					max-width: 100%;
				}
			</style>
		{/if}

		<Media
			class="w-full h-screen"
			src="https://propromo-d08144c627d3.herokuapp.com"
			type="iframe"
		/>

		<div
			class="absolute left-4 bottom-4 uppercase px-4 py-2 text-lg text-white font-semibold bg-[#0D3269] rounded-md shadow-md source-sans-3-font focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50"
		>
			Live Demo
		</div>

		<Notes>
			<h1>Live Demo</h1>
		</Notes>
	</Slide>

	<Slide animate>
		<Stretch
			class="mx-auto"
			src={propromo}
			type="img"
			data-id="propromo-content"
		/>
		<h1
			class="flex justify-center gap-2 pt-4 uppercase"
			data-id="propromo-headline"
		>
			Propromo
		</h1>

		<Notes>
			<h1>Thank you for listening!</h1>
		</Notes>
	</Slide>
</Presentation>
