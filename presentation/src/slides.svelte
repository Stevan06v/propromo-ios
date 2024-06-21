<script lang="ts">
	import {
		Presentation,
		Slide,
		FitText,
		Stretch,
		Media,
		Notes,
		Step,
	} from '@components'
	import propromo from './lib/assets/images/propromo.png'
	import join from './lib/assets/images/join-gray.png'
	import monitors from './lib/assets/images/monitors-gray.png'
	import chat from './lib/assets/images/chat-gray.png'
	import manageAccount from './lib/assets/images/manage-account-gray.png'

	let isFullscreen = false
</script>

<!-- Notes are visible with the `S` key in the browser -->

<Presentation>
	<Slide animate>
		<FitText class="flex gap-2 uppercase">Propromo</FitText>
		<FitText class="uppercase gray-1-color" data-id="subtitle">
			Your client wants to be involved. We make it possible.
		</FitText>

		<Notes>
			<h1>Propromo</h1>

			<p>Your client wants to be involved. We make it possible.</p>
		</Notes>
	</Slide>

	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="title">Propromo</FitText>
		<FitText class="flex gap-2 uppercase gray-1-color" data-id="subtitle"
			>What we do</FitText
		>

		<div class="min-h-[100vh/2] h-fit-content">
			<Step fadeUp>
				<h2 class="text-6xl uppercase gray-1-color system-ui-font">Project</h2>
			</Step>
			<Step fadeLeft>
				<h2 class="text-6xl uppercase gray-1-color system-ui-font">Progress</h2>
			</Step>
			<Step fadeRight>
				<h2 class="text-6xl uppercase gray-1-color system-ui-font">
					Monitoring
				</h2>
			</Step>
		</div>

		<Notes>
			<h1>What we do</h1>
		</Notes>
	</Slide>

	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="title"
			>Mobile App Features</FitText
		>

		<div class="grid h-full">
			<div>
				<img class="h-48 mx-auto" src={join} alt="plus" />
				<p class="font-extrabold uppercase gray-1-color">Join</p>
			</div>

			<Notes>
				<h1>Features</h1>

				<ol>
					<li>Join Monitors</li>
				</ol>
			</Notes>
		</div>
	</Slide>

	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="title"
			>Mobile App Features</FitText
		>

		<div class="grid h-full grid-cols-2">
			<div>
				<img class="h-48 mx-auto" src={join} alt="plus" />
				<p class="font-extrabold uppercase gray-1-color">Join</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={monitors} alt="monitors" />
				<p class="font-extrabold uppercase gray-1-color">Monitors</p>
			</div>

			<Notes>
				<h1>Features</h1>

				<ol>
					<li>Join Monitors</li>
					<li>View Monitors</li>
				</ol>
			</Notes>
		</div>
	</Slide>

	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="title"
			>Mobile App Features</FitText
		>

		<div class="grid h-full grid-cols-3">
			<div>
				<img class="h-48 mx-auto" src={join} alt="plus" />
				<p class="font-extrabold uppercase gray-1-color">Join</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={monitors} alt="monitors" />
				<p class="font-extrabold uppercase gray-1-color">Monitors</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={chat} alt="chat" />
				<p class="font-extrabold uppercase gray-1-color">Chat</p>
			</div>

			<Notes>
				<h1>Features</h1>

				<ol>
					<li>Join Monitors</li>
					<li>View Monitors</li>
					<li>Chat with the Scrum Master</li>
				</ol>
			</Notes>
		</div>
	</Slide>

	<Slide animate>
		<FitText class="flex gap-2 uppercase" data-id="title"
			>Mobile App Features</FitText
		>

		<div class="grid h-full grid-cols-4">
			<div>
				<img class="h-48 mx-auto" src={join} alt="plus" />
				<p class="font-extrabold uppercase gray-1-color">Join</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={monitors} alt="monitors" />
				<p class="font-extrabold uppercase gray-1-color">Monitors</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={chat} alt="chat" />
				<p class="font-extrabold uppercase gray-1-color">Chat</p>
			</div>

			<div>
				<img class="h-48 mx-auto" src={manageAccount} alt="settings" />
				<p class="font-extrabold uppercase gray-1-color">Account</p>
			</div>

			<Notes>
				<h1>Features</h1>

				<ol>
					<li>Join Monitors</li>
					<li>View Monitors</li>
					<li>Chat with the Scrum Master</li>
					<li>Manage Account</li>
				</ol>
			</Notes>
		</div>
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
			preload={true}
		/>

		{#if isFullscreen}
			<div
				class="absolute left-4 bottom-4 uppercase px-4 py-2 text-lg text-white font-semibold bg-[#0D3269] rounded-md shadow-md source-sans-3-font focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50"
			>
				Live Demo
			</div>
		{/if}

		<Notes>
			<h1>Live Demo</h1>
		</Notes>
	</Slide>

	<Slide animate>
		<Stretch class="mx-auto" src={propromo} type="img" />
		<h1 class="flex justify-center gap-2 pt-4 uppercase">Propromo</h1>

		<Notes>
			<h1>Thank you for listening!</h1>
		</Notes>
	</Slide>
</Presentation>
