<template>
	<autocomplete
		:class="divClasses"
		:source="clientList"
		input-class="form-control form-control-sm"
		:initial-display="selectedClientName"
		:initial-value="initialValue"
		name="client_id"
		@selected="onSelect"
		@clear="onClear"
	/>
</template>

<script>
	import Autocomplete from 'vuejs-auto-complete';
	export default {
		props: {
			additionalClasses: {
				type: String,
				default: () => ''
			},
			clientList: {
				type: Array,
				required: true
			},
			disabled: {
				type: Boolean,
				default: () => false
			},
			selectedClientName: {
				type: String,
				default: () => ''
			},
			onSelect: {
				type: Function,
				default: () => {return () => null}
			},
			onClear: {
				type: Function,
				default: () => {return () => null}
			}
		},
		computed: {
			divClasses: function(){
				var disabledClass = this.disabled ? 'disabled' : '';
				return this.additionalClasses + ' ' + disabledClass;
			},
			initialValue: function(){
				if (this.selectedClientName.length === 0) return '';
				return this.clientList.find(c => c.name === this.selectedClientName).id;
			}
		},
		components: {
			Autocomplete
		}
	}
</script>