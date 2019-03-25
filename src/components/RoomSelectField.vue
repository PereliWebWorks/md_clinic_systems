<template>
	<div :class="'col-' + width">
		<div class="row">
			<label :class="classes.label">{{label}}</label>
			<select :name="name" :class="classes.select">
				<option value=""></option>
				<option
					v-for="option in options"
					:key="option.value"
					:value="option.value"
					:selected="selectedOption && selectedOption == option.value ? 'selected' : false"
				>{{option.name}}</option>
			</select>
		</div>
	</div>
</template>

<script>
	export default {
		props: {
			label: {
				type: String,
				required: true
			}, 
			name: {
				type: String,
				required: true
			},
			options: {
				type: Array,
				required: true
			},
			selectedOption: { //Optional. The value of the selected item, if there is one
				type: [Number, Boolean],
				default: () => false
			},
			roomState: {
				type: String,
				required: true
			},
			disabledStates: { //The states that this field should be disabled on
				type: Array,
				default: () => []
			},
			width: {
				type: Number,
				default: () => 12
			}, //1 - 12 
			labelWidth: {
				type: Number,
				default: () => 4
			},
			selectWidth: {
				type: Number,
				default: () => 8
			}
		},
		computed: {
			classes: function(){
				var classes = {
					label: 'col-form-label col-form-label-sm ' + 'col-' + this.labelWidth,
					select: 'form-control form-control-sm col-' + this.selectWidth
				}
				if (this.disabledStates.includes(this.roomState)) classes.select += ' disabled';
				return classes;
			}
		}
	}
</script>