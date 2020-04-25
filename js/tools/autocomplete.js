// *** //

function AutoComplete(config) {
	this.results = [];
	this.maxItems = config.maxItems;
	this.inputId = config.inputId;
	this.cat1Id = config.cat1Id;
	this.cat2Id = config.cat2Id;
	this.searchUrl = config.searchUrl;
	this.input = document.getElementById(this.inputId);
	this.cat1 = document.getElementById(this.cat1Id);
	this.cat2 = document.getElementById(this.cat2Id);
	this.selected = -1;
	this.selector = document.createElement('div');
	this.environment = config.environment;
	
	this.init = function() {
		var rect = this.input.getBoundingClientRect();
		var selectorWidth = rect.right - rect.left - 2;
		var selectorLeftPos = rect.left;
		var selectorTopPos = rect.bottom;
		this.selector.style.width = selectorWidth + 'px';
		this.selector.style.left = selectorLeftPos + 'px';
		this.selector.style.top = selectorTopPos + 'px';
		this.selector.className = 'autocomplete-selector-box';
		this.selector.id = 'autocomplete-selector';
		document.body.appendChild(this.selector);
		document.body.autoComplete = this;
		// this.input.ac = this;
		addEvent('keydown', this.input, this.onKeyDownEvent);
		addEvent('keyup', this.input, this.onKeyUpEvent);
		addEvent('blur', this.input, this.onBlurEvent);
		addEvent('focus', this.input, this.onFocusEvent);
		addEvent('click', document.body, function(e) {
			var target = e.target || e.srcElement;
			if (target.id !== 'autocomplete-selector') {
				document.body.autoComplete.closeSelector();
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
			var value = r[i];
			this.selector.appendChild(this.buildItem(value, 'result-item-' + i));
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
	
	this.buildItem = function(name, id) {
		var item = document.createElement('div');
		item.id = id;
		item.innerHTML = name;
		item.className = 'autocomplete-no-selected-item-box';
		addEvent('click', item, function (e) {
			var target = e.target || e.srcElement;
			document.body.autoComplete.input.value = target.innerHTML;
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
		this.selector.style.display = '';
	};
	
	this.closeSelector = function() {
		this.cleanBox(this.selector);
		this.selector.style.display = 'none';
		this.results = [];
		this.selected = -1;
	};
	
	this.onKeyDownEvent = function(e) {
		var ac = document.body.autoComplete;
//		if (e.target) {
//			ac = e.target.ac;
//		} else if (e.srcElement) {
//			ac = e.srcElement.ac;
//		}
		
		if (ac) {
			var keycode = e.keyCode;
			if (keycode === 40) { // DOWN
				ac.selectNext();
			} else if (keycode === 27) { // ESC
				ac.closeSelector();
			} else if (keycode === 13) { // ENTER
				if (ac.results && ac.results.length > 0 && ac.results.length > ac.selected) {
					ac.input.value = ac.results[ac.selected];
				}
			}
		}
	};
	
	this.onKeyUpEvent = function(e) {
		var ac = document.body.autoComplete;
//		if (e.target) {
//			ac = e.target.ac;
//		} else if (e.srcElement) {
//			ac = e.srcElement.ac;
//		}
		
		if (ac) {
			var keycode = e.keyCode;
			if ((keycode > 64 && keycode < 91 || keycode === 46 || keycode === 8)) { // WORDS + BACKSPACE
				ac.openSelector();
				if (ac.input.value.length >= 2) {
					ac.search(ac.cat1.value, ac.cat2.value, ac.input.value);
				}
			} else if (keycode === 38) { // UP
				ac.selectPrev();
//			} else if (keycode === 13) {
//				ac.input.value = ac.results[ac.selected];
			}
		}
	};
	
	this.onBlurEvent = function(e) {
		if (e.target) {
			//e.target.ac.closeSelector();
			//e.target.ac.selector.style.display = 'none';
		} else if (e.srcElement) {
			// e.srcElement.ac.closeSelector();
			//e.srcElement.ac.selector.style.display = 'none';
		}
	};
	
	this.onFocusEvent = function(e) {
		if (e.target) {
			document.body.autoComplete.openSelector();
		} else if (e.srcElement) {
			document.body.autoComplete.openSelector();
		}
	};
	
	this.search = function(cat1, cat2, searchTerm) {
		var ac = document.body.autoComplete;
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
					_visitormanager_WAR_drugrepportlet_term: searchTerm,
					_visitormanager_WAR_drugrepportlet_cat1: cat1,
					_visitormanager_WAR_drugrepportlet_cat2: cat2,
					_visitormanager_WAR_drugrepportlet_sizeResult: ac.maxItems
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

