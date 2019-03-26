<template>
	<modal :id="id" title="Client Measurements">
		<div class="row">
			<b-form class="col-12">
				<client-autocomplete-field
					:clientList="autocompleteClientList"
					:onSelect="updateSelectedClient"
				/>
			</b-form>
		</div>
		<div
			v-if="selectedClient"
		>
			<div class="row">
				<div class="col-12 mt-3">
					<b-button v-b-toggle.measurement-table variant="primary">See Measurements</b-button>
				</div>
			</div>
			<div class="row">
				<b-collapse id="measurement-table" class="col-12">
					<b-card>
						<b-table
							:items="selectedClient.client_measurements"
							primary-key="id"
							:fields="['created_at', 'weight', 'waist']"
							striped
						>
							<template slot="HEAD_weight" scope="data">
								{{data.label + ' (lbs)'}}
							</template>
							<template slot="HEAD_waist" scope="data">
								{{data.label + ' (inches)'}}
							</template>
							<template slot="created_at" scope="data">
								{{formatDateTime(data.value)}}
							</template>
						</b-table>
					</b-card>
				</b-collapse>
			</div>
			<div class="row">
				<b-form @submit.prevent="submit" class="col-12">
					<h5>New Measurement</h5>
					<b-form-group>
						<b-input
							type="number"
							name="weight"
							placeholder="weight (lbs)"
						/>
					</b-form-group>
					<b-form-group>
						<b-input
							type="number"
							name="waist"
							placeholder="waist (inches)"
						/>
					</b-form-group>
					<input type="hidden" name="client_id" :value="selectedClient.id" />
					<input type="hidden" name="model" value="client_measurement" />
					<b-button type="submit" variant="primary">Submit</b-button>
				</b-form>
			</div>
		</div>
	</modal>
</template>

<script>
	import Modal from './Modal.vue';
	import ClientAutocompleteField from './ClientAutocompleteField.vue';
	export default {
		props: {
			id: {
				type: String,
				required: true
			},
			clients: {
				type: Array, 
				required: true
			},
			autocompleteClientList: {
				type: Array,
				required: true
			},
			submit: {
				type: Function,
				required: true
			}
		},
		data: function(){
			return {
				selectedClient: false
			}
		},
		methods: {
			updateSelectedClient: function(e){
				this.selectedClient = this.clients.find(c => c.id === e.value);
				console.log(this.selectedClient);
			}
		},
		components: {
			Modal,
			ClientAutocompleteField
		}
	}
</script>