// *** //

function AutoComplete2(config) {
	this.results = [];
	this.maxItems = config.maxItems;
	this.inputId = config.inputId;
	this.withCat = config.withCat ? config.withCat : false;
	this.searchUrl = config.searchUrl;
	this.input = document.getElementById(this.inputId);
	if (this.withCat) {
		this.cat1Id = config.cat1Id;
		this.cat2Id = config.cat2Id;
		this.cat3Id = config.cat3Id;
		if (this.cat1Id != null) {
			this.cat1 = document.getElementById(this.cat1Id);
		} else {
			this.cat1 = null;
		}
		if (this.cat2Id != null) {
			this.cat2 = document.getElementById(this.cat2Id);
		} else {
			this.cat2 = null;
		}
		if (this.cat3Id != null) {
			this.cat3 = document.getElementById(this.cat3Id);
		} else {
			this.cat3 = null;
		}
	}
	this.selected = -1;
	this.selector = document.createElement('div');
	this.environment = config.environment;
	this.doOnSelect = config.doOnSelect;
	
	this.init = function() {
		var rect = this.input.getBoundingClientRect();
		var selectorWidth = rect.right - rect.left - 2;
		var selectorLeftPos = rect.left;
		var selectorTopPos = rect.bottom;
		this.selector.style.width = selectorWidth + 'px';
		this.selector.style.left = selectorLeftPos + 'px';
		this.selector.style.top = selectorTopPos + 'px';
		this.selector.className = 'autocomplete-selector-box';
		this.selector.id = this.inputId + 'autocomplete-selector';
		document.body.appendChild(this.selector);
		//this = this;
		this.input.ac = this;
		addEvent('keydown', this.input, this.onKeyDownEvent);
		addEvent('keyup', this.input, this.onKeyUpEvent);
		addEvent('blur', this.input, this.onBlurEvent);
//		addEvent('focus', this.input, this.onFocusEvent);
		addEvent('click', document.body, function(e) {
			var target = e.target || e.srcElement;
			if (document.body.autocomplete != null && !target.id.startsWith(document.body.autocomplete.inputId)) {
				document.body.autocomplete.doOnSelect(null);
				document.body.autocomplete.closeSelector();
			}
		});
		this.closeSelector();
	};
	
	this.selectNext = function() {
		var pSelectedItem = document.getElementById('result-item-' + this.selected);
		if (pSelectedItem != null) {
			pSelectedItem.className = 'autocomplete-no-selected-item-box';
			if (this.selected === this.results.length-1 || this.selected === this.maxItems-1) {
				this.selected = -1;
			}
		}
		this.selected++;
		var selectedItem = document.getElementById('result-item-' + this.selected);
		if (selectedItem != null) {
			selectedItem.className = 'autocomplete-selected-item-box';
		}
	};
	
	this.selectPrev = function() {
		var pSelectedItem = document.getElementById('result-item-' + this.selected);
		if (pSelectedItem != null) {
			pSelectedItem.className = 'autocomplete-no-selected-item-box';
			if (this.selected == 0) {
				if (this.results.length < this.maxItems) {
					this.selected = this.results.length;
				} else {
					this.selected = this.maxItems;
				}
			}
		}
		this.selected--;
		var selectedItem = document.getElementById('result-item-' + this.selected);
		if (selectedItem != null) {
			selectedItem.className = 'autocomplete-selected-item-box';
		}
	};
	
	this.updateAutocomplete = function(r) {
		this.cleanBox(this.selector);
		for (var i=0; i<r.length && i<this.maxItems; i++) {
			var data = r[i];
			this.selector.appendChild(this.buildItem(data, data.label, 'result-item-' + i));
			this.selector.style.borderBottomWidth = '1px';
		}
		this.updateResults(r);
	};
	
	this.cleanBox = function(box) {
		while(box.firstChild) {
		    box.removeChild(box.firstChild);
		}
		this.selector.style.borderBottomWidth = '0';
	};
	
	this.buildItem = function(data, label, id) {
		var item = document.createElement('div');
		item.id = id;
		item.innerHTML = label;
		item.className = 'autocomplete-no-selected-item-box';
		item.acdata = data;
		addEvent('click', item, function (e) {
			var target = e.target || e.srcElement;
			document.body.autocomplete.input.value = target.innerHTML;
			document.body.autocomplete.doOnSelect(data);
			document.body.autocomplete.closeSelector();
		});
		return item;
	};
	
	this.updateResults = function(r) {
		this.results = r;
		this.selected = -1;
		if (r.length > 0) {
			this.selectNext();
		}
	};
	
	this.openSelector = function() {
		document.body.autocomplete = this;
		this.selector.style.display = '';
	};
	
	this.closeSelector = function() {
		this.cleanBox(this.selector);
		this.selector.style.display = 'none';
		this.results = [];
		this.selected = -1;
		document.body.autocomplete = null;
	};
	
	this.onKeyDownEvent = function(e) {
		var target = e.target || e.srcElement;
		if (target.ac) {
			var keycode = e.keyCode;
			if (keycode === 40) { // DOWN
				target.ac.selectNext();
			} else if (keycode === 27) { // ESC
				target.ac.closeSelector();
			} else if (keycode === 13) { // ENTER
				if (target.ac.results && target.ac.results.length > 0 && target.ac.results.length > target.ac.selected) {
					target.ac.input.value = target.ac.results[target.ac.selected].label;
					document.body.autocomplete.doOnSelect(target.ac.results[target.ac.selected]);
					document.body.autocomplete.closeSelector();
				}
			}
		}
	};
	
	this.onKeyUpEvent = function(e) {
		var target = e.target || e.srcElement;
		if (target.ac) {
			var keycode = e.keyCode;
			if ((keycode > 64 && keycode < 91 || keycode === 46 || keycode === 8)) { // WORDS + BACKSPACE
				target.ac.openSelector();
				if (target.ac.input.value.length >= 2) {
					if (target.ac.withCat) {
						var cat1Value = '';
						if (target.ac.cat1 != null) {
							cat1Value = target.ac.cat1.value;
						}
						var cat2Value = '';
						if (target.ac.cat2 != null) {
							cat2Value = target.ac.cat2.value;
						}
						var cat3Value = '';
						if (target.ac.cat3 != null) {
							cat3Value = target.ac.cat3.value;
						}
						target.ac.search(cat1Value, cat2Value, cat3Value, target.ac.input.value);
					} else {
						target.ac.search('', '', '', target.ac.input.value);
					}
				}
			} else if (keycode === 38) { // UP
				target.ac.selectPrev();
//			} else if (keycode === 13) {
//				ac.input.value = ac.results[ac.selected];
			}
		}
	};
	
	this.onBlurEvent = function(e) {
		var target = e.target || e.srcElement;
		//target.ac.closeSelector();
		//target.ac.selector.style.display = 'none';
	};
	
	this.onFocusEvent = function(e) {
		var target = e.target || e.srcElement;
		if (target.ac) {
			target.ac.openSelector();
		} else if (e.srcElement) {
			target.ac.openSelector();
		}
	};
	
	this.search = function(cat1, cat2, cat3, searchTerm) {
		var ac = this;
		console.log('Search by='+searchTerm);
		YUI().use('aui-io-request', function(A) {
			A.io.request(ac.searchUrl, {
				method : 'GET',
				dataType : 'json',
				data: {
					_surgerymanager_WAR_drugrepportlet_term: searchTerm,
					_surgerymanager_WAR_drugrepportlet_cat1: cat1,
					_surgerymanager_WAR_drugrepportlet_cat2: cat2,
					_surgerymanager_WAR_drugrepportlet_sizeResult: ac.maxItems,
					_territorymanager_WAR_drugrepportlet_term: searchTerm,
					_territorymanager_WAR_drugrepportlet_cat1: cat1,
					_territorymanager_WAR_drugrepportlet_cat2: cat2,
					_territorymanager_WAR_drugrepportlet_sizeResult: ac.maxItems,
					_findrepresentatives_WAR_drugrepportlet_searchTerm: searchTerm,
					_findrepresentatives_WAR_drugrepportlet_cat1: cat1,
					_findrepresentatives_WAR_drugrepportlet_cat2: cat2,
					_findrepresentatives_WAR_drugrepportlet_cat3: cat3,
					_findrepresentatives_WAR_drugrepportlet_sizeResult: ac.maxItems
				},
				on : {
					success : function() {
						var response = this.get('responseData');
						console.log(response);
						ac.updateAutocomplete(response);
					}
				}
			});
		});
	};
}

