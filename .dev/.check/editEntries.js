//
//	@Naming scheme
//		word 		(a.word)
//		sentence    (tr)
//		phblock 	(div.phblock)
//		phentry 	(form.phentry)
//		betablock 	(div.betablock)
//	
//	@Authors
//		SCHWA team; 
//		programmer s.bugaj@samsung.com	
//
//	@Bad choices
//		I made several bad choices which I'm awere of.
// 		Most of them are in topic of choice of side of computations
// 		server vs client - precisely much work done on client side should be
//		done on server side (or in preprocessing part)
//



$(function() {
	//
	////
	//	GLOBAL VARIABLES, GENERAL FUNCTIONS
	////
	//

	var offset;
	var stackOfFunctionsToCallWhenClickedESC = [];

	var focusedOnOneWord = false;
	var focusedWordID = -1;

	function space() { return "&nbsp"; }
	var contains = function(needle) {
		// Per spec, the way to identify NaN is that it is not equal to itself
		var findNaN = needle !== needle;
		var indexOf;

		if(!findNaN && typeof Array.prototype.indexOf === 'function') {
			indexOf = Array.prototype.indexOf;
		} else {
			indexOf = function(needle) {
				var i = -1, index = -1;

				for(i = 0; i < this.length; i++) {
					var item = this[i];

					if((findNaN && item !== item) || item === needle) {
						index = i;
						break;
					}
				}

				return index;
			};
		}

		return indexOf.call(this, needle) > -1;
	};


	//
	////
	//	PHBLOCK, PHENTRY
	////
	//

	/*
		formsDiv__curr
		list of phforms
	*/
	function phblock__curr__getHeaderStr () 
	{
		return "<h3><center>Current G2P:</center></h3>";
	}
	function phentry__curr (word, form)
	{
		return  "" +
			"<form class=\"phentry\" elementType=\"current\" wordOrtographically=\"" + word + "\">" +
				"<span state=\""+ "zero" +
					"\" class=\"state-zero\">&nbsp;</span>" + space() + 
				"<input type=\"text\" name=\"forms\" size=\"15\" value=\"" + 
					form +"\" readonly>" +
				"<input type=\"submit\" class=\"remove\" value=\"-\">" +
				"<span class=\"copyButton\">&darr;</span>" + 
			"</form>"
	}

	/*
		formsDiv__updates
		list of udpates to dicionaries 
	*/
	function phblock__updates__getHeaderStr ()
	{
		return "<center><h3>Updates:</h3></center>";
	}
	function phentry__updates (word, initialValue )
	{
		/* 
			@word <- wordOrtographically
			@initialValue <- initial photic form (may be empty "")
		*/
		return 	"" +
			"<form class=\"phentry\" elementType=\"updates\" wordOrtographically=\"" + word + "\">" +
				"<span state=\""+ "before-adding" 
					+"\" class=\"state-zero\">&nbsp;</span>" + space() + 
				"<input type=\"text\" name=\"forms\" size=\"15\" value=\"" + initialValue +  "\">" +
				"<input type=\"submit\" class=\"add\" value=\"+\">" +
				"<span class=\"copyButtonEmpty\">&nbsp;</span>" +
			"</form>"
	}

	// To change state of phentry after adding, removing phforms
	/*
		@ARGS_IN
			@indicatorElement 	span element 		direct child of >>phentry<<
			@submitButton 		input [type=submit] direct child of >>phentry<<
			@newState			String {'removed', 'added', 'zero'}
			@ifshowIndicator 	Boolean

			Look below
			e.g.
			<form 
				class="phentry" 
				elementtype="current" 
				wordortographically="daddy">

				@indicatorElement↓
				<span state="zero" class="state-zero"> ...

				<input type="text" name="forms" value="d ee d ii">

				@submitButton↓
				<input type="submit" class="remove" value="-">

				<span class="copyButton">↓</span>
			</form>
	*/
	function changeState_phentry(indicatorElement, submitButton, newState, ifshowIndicator) 
	{
		if 	( newState == "removed" ) {
			indicatorElement.attr('class', 'state-removed');
			indicatorElement.attr('state', 'removed');
			if ( ifshowIndicator == "true" ) {
				indicatorElement.text("R" );
			}
			else {
				indicatorElement.text(" " );
			}
			//---
			submitButton.attr( "value", "+" );
	        submitButton.attr('class', 'add');
		}

		if ( newState == "added" 	) {
			indicatorElement.attr('class', 'state-added');
			indicatorElement.attr('state', 'added');
			if ( ifshowIndicator == "true" ) {
				indicatorElement.text("A" );
			}
			else {
				indicatorElement.text(" " );
			}
			//---
			submitButton.attr( "value", "-" );
	        submitButton.attr('class', 'remove');
		} 
		
		if ( newState == "zero"  	) {
			indicatorElement.attr('class', 'state-zero');
			indicatorElement.attr('state', 'zero');
			indicatorElement.html("&nbsp;" );
			//---
			submitButton.attr( "value", "-" );
	        submitButton.attr('class', 'remove');
		} 
	}

	/*
		copy text from first phentry in current to the last phentry in updates;
		---
	*/
	function copyContentDown_phentry(e) {
		parental_phblock = $(this).parent().parent();
		last_phentry = 
			parental_phblock.children("[elementType='updates']").last();

		valueToInsert = $(this).parent().children("[type='text']").attr('value');
		valueToInsert = valueToInsert.trim();
			
		last_phentry.children("[type='text']").attr('value', valueToInsert);
	}

	function addNew_phentry_onBottomOfUpdates( phentry, phformToSet ) {
		parentDiv = $(phentry).parent();
		word = $(phentry).attr('wordOrtographically');
		parentDiv.append( 
			phentry__updates(word, phformToSet)
		); 
		parentDiv.children().last().hide()
			.slideDown("slow").unbind('submit')
			.submit( submit_phentry );

		$(phentry).children("span.copyButtonEmpty").each(function() {
			$(this).addClass('copyButton')
				.removeClass('copyButtonEmpty');
			$(this).unbind('click').click(copyContentDown_phentry);
			$(this).html("&darr;");
		});
	}

	/*
		To synchronize with server part
		on content of phblock
	*/
	function submit_synchronizeWordState (wordStr/*STRING*/, phblock/*HTML*/, sentences/*[STRING, STRING]*/) 
	{
		/*
			state about added to future g2p, and removed from current g2p

			It do the same job each time to simplify things (if second time is called):
			(1) (re)set states of current ph forms
			(2) delete all updates entries and add all from XML result
			(3) check if that word has been notified to BETA as AmbigOrt or WrongRef or ...
		*/	

		recordingURL = findRecordingURLFromWord( findWordFromPHBlock(phblock) );

		$.ajax(
        	{
        		url: "currentStateForWord",
        		method: "GET",
        		// async:false,
        		success: function(result) {
        			var parsedResult = $.parseXML(result);
        			$xml = $(parsedResult);
        			
        			/* (1) */
        			deleted /*XML array*/ = $xml.find('removed').find('form'); 
        			deleted.each( function(i, deletemItem) {
        				formsInput = phblock.children("[elementType='current']");
        				formsInput.each( function(i, g2p_htmlForms) {
        					if ($(g2p_htmlForms).children("[type='text']").attr('value') 
        							== deletemItem.childNodes[0].nodeValue) 
        					{
        						changeState_phentry(
        							$(g2p_htmlForms).children("*[class^='state']"),
        							$(g2p_htmlForms).children("input.remove"),
        							"removed",
		        					"true"
        						);
        					}
        				});
        			});

        			/* (2) */
        			inserted /*XML array*/ = $xml.find('inserted').find('form');
        			/* Here updates entries are deleted */
        			phblock.children("[elementType='updates']").remove();	
        			inserted.each( function(i, insertedItem) {
        				phblock.append( phentry__updates(wordStr, "") );
        				formInput = 
        					phblock.children("[elementType='updates']")
        					.last();
        				changeState_phentry(
							$(formInput).children("*[class^='state']"),
							$(formInput).children("input.add"),
							"added",
	        				"true"
						);
						$(formInput).children("[type='text']").attr(
							"value", insertedItem.childNodes[0].nodeValue);
						$(formInput).children("span.copyButtonEmpty").each(function() {
        					$(this).addClass('copyButton')
        						.removeClass('copyButtonEmpty');
							$(this).unbind('click').click(copyContentDown_phentry);
							$(this).html("&darr;");
						});
        			});
        			var valueToPut = $(phblock.children("[elementType='current']")[0])
						.children("[type='text']").attr('value').trim(); 
        			phblock.append( 
        				phentry__updates(wordStr, valueToPut)
        			);
        			phblock.children("[elementType='updates']")
        				.unbind('submit').submit( submit_phentry );

        			/* (3) */
        			ifAmbigOrtNotified = 
        				$xml.find('BETAnotification')
        				.find('ambigOrt')[0].textContent; 
        			ifWrongRefNotified = 
        				$xml.find('BETAnotification')
        				.find('wrongRef')[0].textContent; 
        			ifMismatchNotifiedNotified = 
        				$xml.find('BETAnotification')
        				.find('mismatchRecording')[0].textContent; 

        			notifyLampAmbigOrt 			= $(phblock.children("span.notifyLamp")[0]);
        			notifyLampWrongRef 			= $(phblock.children("span.notifyLamp")[1]);
        			notifyLampMismatchRecording = $(phblock.children("span.notifyLamp")[2]);
        			if( ifAmbigOrtNotified == "True" ) {
        				notifyLampAmbigOrt.attr("state", "Added");
        			}
        			if( ifWrongRefNotified == "True" ) {
        				notifyLampWrongRef.attr("state", "Added");
        			}
        			if( ifMismatchNotifiedNotified == "True" ) {
        				notifyLampMismatchRecording.attr("state", "Added");
        			}
            	},

            	data: 	"languageCode=" + G2P_LANGUAGE_CODE + 
            			"&" + "word=" + wordStr +
            			"&" + "recordingURL=" + recordingURL + 
            			"&" + "sentenceA=" + sentences[0] +
            			"&" + "sentenceB=" + sentences[1] 
            			
        	}
        );
	}

	/*
		Notes:
		add suggestions of course only once (when firsting hovering a word);
		Do not suggest things which already are in any entry;
	*/
	function submit_suggestions (word, phblock) {
		// if ( phblock.attr('ifSuggestionShown') != 'FALSE' ) {
		// 	return;
		// } 

		//	Make array with suggestions which should be
		//	ignored; Because: 
		//	Do not suggest things which are already in current part or added;
		
		var old 	= getAllCurrentFormsAsArrayOfStrings(phblock);
		var added 	= getAllAddedFormsAsArrayOfStrings  (phblock);
		var suggestionsToIgnore = $.merge( old, added );

		//	Communicating with server
		$.ajax(
        	{
        		url: "suggestions",
        		method: "GET",
        		success: function(result) {
        			var parsedResult = $.parseXML(result);
        			$xml = $(parsedResult);
        			
        			suggestions = $xml.find('suggestions').find('suggestion');
            		suggestions.each( function(i, suggestion) {
            			suggestion = suggestion.childNodes[0].nodeValue;

            			//	if in suggestionsToIgnore do not add
            			if( !contains.call(suggestionsToIgnore, suggestion) ) {
	            			
	            			//
	            			// find where to insert suggestions 
	            			// (after last added element
	            			//	or as first ones if not added exists)
            				//
            				var elementToInsertAfter;
            				var tmp = 
            					phblock.children("form[elementType='updates']").last().children("span[state='added']");
            				if ( tmp.length == 0 ) {
            					elementToInsertAfter = phblock.children("form[elementType='updates']").first().prev();
            				}
            				else {
            					elementToInsertAfter = tmp.parent();
            				}

            				var newElement = phentry__updates(word, "");
            				$(newElement).insertAfter(elementToInsertAfter);
	        				elementToInsertAfter.next().children("input[type='text']").first().attr(
								"value", suggestion);
            			}
            		});

            		phblock.children("[elementType='updates']")
        				.unbind('submit').submit( submit_phentry );

        			phblock.attr('ifSuggestionShown', 'TRUE');

            	},

            	data: 	"languageCode=" + G2P_LANGUAGE_CODE + 
            			"&" + "word=" + word
        	}
        );	
	}

	// Here we have a lot of code... 
	/*
		We have a lot of code because we need to check 
		whether

	*/
	function submit_phentry ( event ) 
	{
		//
		////
		//	Here we need prepare few variables:
		//		(this_phentry, wordOrtographically, 
		//		stateIndicatorState, stateIndicator)
		////
		//
		event.preventDefault();
		this_phentry = $(this);
		parental_phblock = this_phentry.parent();
		wordOrtographically = $(this_phentry).attr('wordOrtographically');
		stateIndicator = $(this_phentry).children("*[class^='state']");
		stateIndicatorState = 
			$(this_phentry).children("*[class^='state']").attr('state');
		formBlockType =  $(this_phentry).attr('elementType');

		form = $(this).children( "[name='forms']" ).attr("value");
		if (form == "") return;

		//	Prepare old forms
		var oldFormsArray = getAllCurrentFormsAsArrayOfStrings( parental_phblock );
		oldForms = oldFormsArray.join("*");


		//
		////
		//	Check whether 
		//	is not the case that
		//	that form exists in current part or
		//	has been already added;
		////
		//
		if ( stateIndicatorState == "before-adding" ) {
			//prepare already added forms;
			var addedFormsArray = getAllAddedFormsAsArrayOfStrings( parental_phblock );

			if (  contains.call(oldFormsArray, form) ) {
				window.alert("I'm afraid that cannot be done.. That form is listed in above entries block.");
				return;
			}
			if (  contains.call(addedFormsArray, form)  ) {
				window.alert("I'm afraid that cannot be done.. That form has been already added.");
				return;
			}
		}



		//
		////
		//	Call ajax
		////
		//
        $.ajax(
        	{
        		url: "editEntry",
        		method: "GET",
        		success: function(result) {
        			if (result != "OK") {
        				window.alert(result);
        				return;
        			}
        			if (stateIndicator.attr('state') == 'before-adding' && 
        				formBlockType == "updates") 
        			{
        				changeState_phentry( 
        					$(this_phentry).children("*[class^='state']"), 
        					$(this_phentry).children("input.add"),
        					"added",
        					"true"
        				);

        				$(this_phentry).children("[name='forms']")
        					.attr("readonly", "true");

        				var phformToSet = $(this_phentry)
        					.children("[type='text']").attr('value');
        					
        				addNew_phentry_onBottomOfUpdates(this_phentry, phformToSet);
        				return;
        			}

        			if (stateIndicator.attr('state') == 'added' 
        				&& formBlockType == "updates") 
        			{
        				parentDiv = $(this_phentry).parent();
        				word = $(this_phentry).attr('wordOrtographically');
        				$(this_phentry).fadeTo("fast", 0.0, function() {
        					$(this).slideUp("fast", function() {
        						$(this).remove();
        					});	
        				});
        				
        				return;
        			}

        			if (stateIndicator.attr('state') == 'zero') {
        				changeState_phentry( 
        					$(this_phentry).children("*[class^='state']"),
        					$(this_phentry).children("input.remove"),
        					"removed",
        					"true"
        				);
        				return;
        			}

        			if (stateIndicator.attr('state') == 'removed' 
        				&& formBlockType == "current") 
        			{
        				changeState_phentry( 
        					$(this_phentry).children("*[class^='state']"), 
        					$(this_phentry).children("input.add"),
        					"zero",
        					"false" 
        				);
        				return;
        			}

        			if (stateIndicator.attr('state') == 'removed' 
        				&& formBlockType == "updates") 
        			{
        				changeState_phentry(
        					$(this_phentry).children("*[class^='state']"),
        					$(this_phentry).children("input.add"),
        					"zero",
        					"true" 
        				);
        				return;
        			}

            	},

            	// language code (e.g. fr-FR)
            	// state (before-adding, zero, removed, added)
            	// word
            	// form
            	// oldForms
            	data: 	$(this_phentry).serialize() + "&" +
            			"languageCode=" + G2P_LANGUAGE_CODE + "&" +
            			"state=" + stateIndicatorState + "&" +
            			"word=" + encodeURIComponent(wordOrtographically) + "&" +
            			"oldForms=" + oldForms
        	}
        );
    }

 	function hide_phblock(phblock) 
    {
    	phblock.hide();
    	focusedOnOneWord = false;
    }

    //	get all current phforms as array of strings
	function getAllCurrentFormsAsArrayOfStrings(phblock) {
		// Prepare oldForms
		var oldForms = [];
		phblock.children("[elementtype='current']")
			.children("[type='text']").each( function() {
				oldForms.push($(this).attr("value"));
			});
		oldFormsArray = oldForms;
		return oldFormsArray;
	}

	//	get all already added forms (from updates part that ones in added state)
	function getAllAddedFormsAsArrayOfStrings(phblock) {
		var addedFormsArray = []
		phblock.children("[elementtype='updates']")
			.each( function() {

				/* 	Class should be added to that span element 
					it may not be first child in the future;
				*/
				spanElementWithState = $(this).children().first()

				if ( spanElementWithState.attr('state') == "added" ) {
					addedFormsArray.push(
						$(this).children("[type='text']").attr("value")
					);
				}
			});
		return addedFormsArray;
	}



	//
	////
	//	BETA NOTIFICATION
	////
	//
	/*
		div.buttonWrongRef
		div.buttonAmbigOrt
		div.betaNotificationDetails <- pops when clicked on button*
	*/

	//Used for guessing second form for AmbigOrt or WrongRef -> the most similar word;
	LDistanceFun = function(a, b){
		if(a.length == 0) return b.length; 
		if(b.length == 0) return a.length; 

		var matrix = [];

		// increment along the first column of each row
		var i;
		for(i = 0; i <= b.length; i++){
			matrix[i] = [i];
		}

		// increment each column in the first row
		var j;
		for(j = 0; j <= a.length; j++){
			matrix[0][j] = j;
		}

		// Fill in the rest of the matrix
		for(i = 1; i <= b.length; i++){
			for(j = 1; j <= a.length; j++){
				if(b.charAt(i-1) == a.charAt(j-1)){
					matrix[i][j] = matrix[i-1][j-1];
				} else {
					matrix[i][j] = Math.min(matrix[i-1][j-1] + 1, // substitution
										Math.min(matrix[i][j-1] + 1, // insertion
										matrix[i-1][j] + 1)); // deletion
				}
			}
		}
		return matrix[b.length][a.length];
	};

	function buttonWrongRef () {
		return "<span class=\"notifyLamp\" state=\"Zero\" notifType=\"wrongRef\">&nbsp;&nbsp;</span>&nbsp;<div class=buttonWrongRef popped=\"FALSE\">" +
			"WrongRef" + "</div>"
	}
	function buttonAmbigOrt () {
		return "<span class=\"notifyLamp\" state=\"Zero\" notifType=\"ambigOrt\">&nbsp;&nbsp;</span>&nbsp;<div class=buttonAmbigOrt popBlockState=\"hidden\">" +
			"AmbigOrt" + "</div>"
	}
	function buttonMismatchRecording () {
		return "<span class=\"notifyLamp\" state=\"Zero\" notifType=\"mismatchRecording\">&nbsp;&nbsp;</span>&nbsp;<div class=buttonMismatchRecording popBlockState=\"hidden\">" +
			"MismatchRec" + "</div>"
	}
	//----
	//----
	function guessByMinDistance (phblock) {
		/* 
			Check whether is possible to guess the variant
		*/
		wordID = phblock.attr('id').substring(1);
		word = $('#'+wordID);
		word_ = word.attr('wordortographically');
		sentence = word.parentsUntil("tr").last();
		if (word.parent().is("span")) {
			word = word.parent();
		}
		
		//Check if the word is clicked in REF or in DIFF
		var ifOnDiffSide = word.prevUntil("a.recording").is("br") //FALSE->REF, TRUE->DIFF
		
		sentenceRecordingA = word.prevAll('a.recording').first();
		brMiddle = sentenceRecordingA.nextAll('br').first();
		brEnd    = brMiddle.nextAll('br').first();
		var refsentence  = []
		var diffsentence = []
		it = sentenceRecordingA
		while( it[0] !== brMiddle[0] ) {
			if ( it.is('a.word') ) {
				refsentence.push(it.attr('wordortographically'))
			}
			it = it.next()
		}
		while( it.length != 0 && it[0] !== brEnd[0] ) {
			if ( it.is('a.word') ) {
				diffsentence.push(it.attr('wordortographically'))
			}
			if ( it.is('span') ) {
				it.children('a.word').each(function() {
					diffsentence.push( $(this).attr('wordortographically') );
				});
			}
			it = it.next()
		}
		diffdistances = []
		var diffMin = 100
		var diffMinWord
		$.each(diffsentence, function(index, value) {
			dist = LDistanceFun(word_, value);
			diffdistances.push(dist);
			if (dist < diffMin && dist > 0 ) {
				diffMin = dist;
				diffMinWord = value;
			}
		});
		refdistances = []
		var refMin = 100 
		var refMinWord
		$.each(refsentence, function(index, value) {
			dist = LDistanceFun(word_, value);
			refdistances.push(dist);
			if (dist < refMin && dist > 0) {
				refMin = dist;
				refMinWord = value;
			}
		});

		var initialValueVariants="";
		if ( ifOnDiffSide && refMin < 100) {
			initialValueVariants = refMinWord;
		}
		else if (diffMin < 100) {
			initialValueVariants = diffMinWord;
		}
		/*END*/

		

		return initialValueVariants;
	}

	function callback__buttonWrongRef (obj) {
		var parental_phblock = $(this).parent();
		
		word = findWordFromPHBlock(parental_phblock);
		recordingURL = findRecordingURLFromWord(word);

		//Check if the word is clicked in REF or in DIFF
		var ifOnDiffSide = word.prevUntil("a.recording").is("br") //FALSE->REF, TRUE->DIFF

		if (ifOnDiffSide) { 
			window.alert("This option is allowed only when clicked on word in REFERENCE part.");
			return; 
		}

		if ( $(this).attr("popped") == "TRUE" ) {
			var detailsBlock = $(this).parent().children("div.betaNotificationDetails");
			hide_betablock( detailsBlock, $(this) );
			return;
		}


		wrongRef = word.text();
		correctedRef = "";
		/* 
			Check whether is possible to guess the variant
		*/
		correctedRef = guessByMinDistance($(this).parent());
		if (correctedRef != "") {
			wordWithKeptCase = word.text();
			firstLetter = wordWithKeptCase[0];
			if ( firstLetter == firstLetter.toUpperCase() ){
				correctedRef = correctedRef[0].toUpperCase() + correctedRef.substr(1);
			}
		}
		/*END*/

		var form = "" +
			"<div class=\"betaNotificationDetails\">" +
				// "<div class=\"betaNotificationDetailsTitle\">WrongRef</div>" +
				"<form class=\"BETA\">" +
					"<input type=\"hidden\" name=\"languageCode\" size=\"15\" value=\"" + G2P_LANGUAGE_CODE + "\">" +
					"<input type=\"hidden\" name=\"fullRecordingURL\" size=\"15\" value=\"" + recordingURL + "\">" +
					"<span class=\"checkBoxDescription\">wrong ref.:</span><br>" + "<input type=\"text\" name=\"wrongRef\" size=\"15\" value=\"" + wrongRef + "\">" +
					"<span class=\"checkBoxDescription\">corrected ref.:</span><br>" + "<input type=\"text\" name=\"correctedRef\" size=\"15\" value=\"" + correctedRef + "\"><br>" +
					"<input type=\"checkbox\" size=\"15\" name=\"needsVerification\" value=\"False\" unchecked \"> <span class=\"checkBoxDescription\">Needs verification?</span> <br>" +
					"<input type=\"checkbox\" size=\"15\" name=\"globallySafe\" value=\"True\" unchecked \"> <span class=\"checkBoxDescription\">Globally safe?</span> <br>" +
					"<input type=\"submit\" value=\"notifyBeta!\">" +
				"</form>"
			"</div>"

		$(this).parent().append(form);
		
		var addedBlock = $(this).parent().children("div.betaNotificationDetails");
		addedBlock.children("form").unbind('submit').submit(submit__buttonWrongRef);
		addedBlock.children("form").removeAttr('onsubmit');
		
		offset = $(this).offset();
		poffset = $(this).parent().offset();
		addedBlock.css('top', offset.top - poffset.top - addedBlock.height()/2 )
			.css('left', offset.left - poffset.left + $(this).width() + 10);


		var detailsBlock = $(this).parent().children("div.betaNotificationDetails");	
		var button = $(this).parent().children("div.buttonWrongRef");
		detailsBlock.hide()
			.fadeIn(1000);
		stackOfFunctionsToCallWhenClickedESC.push( function() { hide_betablock( detailsBlock, button) }  );
		$(this).attr("popped", "TRUE")
	}
	function callback__buttonAmbigOrt (obj) {
		if ( $(this).attr("popped") == "TRUE" ) {
			var detailsBlock = $(this).parent().children("div.betaNotificationDetails");
			hide_betablock( detailsBlock, $(this) );
			return;
		}


		variant0 = $(this).parent().attr("wordortographically");
		initialValueVariants = "";

		/* 
			Check whether is possible to guess the variant
		*/
		initialValueVariants = guessByMinDistance($(this).parent());
		/*END*/

		var form = "" +
			"<div class=\"betaNotificationDetails\">" +
				// "<div class=\"betaNotificationDetailsTitle\">AmbigOrt</div>" +
				"<form class=\"BETA\">" +
					"<input type=\"hidden\" name=\"languageCode\" size=\"15\" value=\"" + G2P_LANGUAGE_CODE + "\">" +
					"<span class=\"checkBoxDescription\">variant0:</span><br>" + "<input type=\"text\" name=\"variant0\" size=\"15\" value=\"" + variant0 + "\">" +
					"<span class=\"checkBoxDescription\">variant1:</span><br>" + "<input type=\"text\" name=\"variants\" size=\"15\" value=\""+ initialValueVariants +"\">" +
					"<input type=\"submit\" value=\"notifyBeta!\">" +
				"</form>"
			"</div>"

		$(this).parent().append(form);
		
		var addedBlock = $(this).parent().children("div.betaNotificationDetails");
		addedBlock.children("form").unbind('submit').submit(submit__buttonAmbigOrt);
		addedBlock.children("form").removeAttr('onsubmit');
		
		offset = $(this).offset();
		poffset = $(this).parent().offset();
		addedBlock.css('top', offset.top - poffset.top - addedBlock.height()/2 )
			.css('left', offset.left - poffset.left + $(this).width() + 10);

		var detailsBlock = $(this).parent().children("div.betaNotificationDetails");
		var button = $(this).parent().children("div.buttonAmbigOrt");
		stackOfFunctionsToCallWhenClickedESC.push( function() { hide_betablock(detailsBlock, button) }  );
		detailsBlock.hide()
			.fadeIn(1000);

		$(this).attr("popped", "TRUE")
	}
	function callback__buttonMismatchRecording (obj) {
		var parental_phblock = $(this).parent();
		
		word = findWordFromPHBlock(parental_phblock);
		recordingURL = findRecordingURLFromWord(word);

		if ( $(this).attr("popped") == "TRUE" ) {
			var detailsBlock = $(this).parent().children("div.betaNotificationDetails");
			hide_betablock( detailsBlock, $(this) );
			return;
		}

		var form = "" +
			"<div class=\"betaNotificationDetails\">" +
				// "<div class=\"betaNotificationDetailsTitle\">WrongRef</div>" +
				"<form class=\"BETA\">" +
					"<input type=\"hidden\" name=\"languageCode\" size=\"15\" value=\"" + G2P_LANGUAGE_CODE + "\">" +
					"<input type=\"hidden\" name=\"fullRecordingURL\" size=\"15\" value=\"" + recordingURL + "\">" +
					"<input type=\"submit\" value=\"notifyBeta!\">" +
				"</form>"
			"</div>"

		$(this).parent().append(form);
		
		var addedBlock = $(this).parent().children("div.betaNotificationDetails");
		addedBlock.children("form").unbind('submit').submit(submit__buttonMismatchRecording);
		addedBlock.children("form").removeAttr('onsubmit');
		
		offset = $(this).offset();
		poffset = $(this).parent().offset();
		addedBlock.css('top', offset.top - poffset.top - addedBlock.height()/2 )
			.css('left', offset.left - poffset.left + $(this).width() + 10);


		var detailsBlock = $(this).parent().children("div.betaNotificationDetails");	
		var button = $(this).parent().children("div.buttonMismatchRecording");
		detailsBlock.hide()
			.fadeIn(1000);
		stackOfFunctionsToCallWhenClickedESC.push( function() { hide_betablock( detailsBlock, button) }  );
		$(this).attr("popped", "TRUE")
	}
	//----
	function submit__buttonWrongRef (obj) {
		myform = $(this).parent();
		button = myform.parent().children("div.buttonAmbigOrt");
		obj.preventDefault();

		// $(this).children("[type='text']").attr("value", val.toLowerCase());

		$.ajax(
        	{
        		url: "notifyWrongRef",
        		type: "GET",
        		success: function(result) {
					var top = stackOfFunctionsToCallWhenClickedESC.pop();
					top();
            	},
            	data: 	$(this).serialize()	
        	}
        );
	}
	function submit__buttonAmbigOrt (obj) {
		myform = $(this).parent();
		button = myform.parent().children("div.buttonAmbigOrt");
		obj.preventDefault();

		/* Check whether if any form is provided */

		var val = $($(this).children("[type='text']")[1]).attr("value");
		var val0 = $($(this).children("[type='text']")[0]).attr("value");

		if (val0 == "" | val == "" || val == "<write_other_variants>" /*|| val.indexOf(' ') >= 0*/) {
			window.alert("You need to write something..");
			return;
		}

		$($(this).children("[type='text']")[0]).attr("value", val0.toLowerCase());
		$($(this).children("[type='text']")[1]).attr("value", val.toLowerCase());

		$.ajax(
        	{
        		url: "notifyAmbigOrt",
        		type: "GET",
        		success: function(result) {
        			var top = stackOfFunctionsToCallWhenClickedESC.pop();
					top();
            	},
            	data: $(this).serialize()
        	}
        );
	}
	function submit__buttonMismatchRecording (obj) {
		myform = $(this).parent();
		button = myform.parent().children("div.buttonMismatchRecording");
		obj.preventDefault();

		// $(this).children("[type='text']").attr("value", val.toLowerCase());
		$.ajax(
        	{
        		url: "notifyMismatchRecording",
        		type: "GET",
        		success: function(result) {
					var top = stackOfFunctionsToCallWhenClickedESC.pop();
					top();
            	},
            	data: 	$(this).serialize()	
        	}
        );
	}
	//----
	function hide_betablock(detailsBlock, button) {
		button.attr("popped", "FALSE");
		detailsBlock.fadeOut("slow", function() {
			detailsBlock.remove();
		});
	}
    


    //
	////
	//	OTHERS
	////
	//

	/*
		Adding audio controls; that should be done on server part or 
		just in time of generating result file by aer/ae2 scripts;
	*/
	function refRecordings_insertAudioPlayerInline() {
		$('a.recording').each(function() {
			url = $(this).attr('href');
			newurl = 'getRecording' + "/?audio=" + url
			$(this).attr('href', 'getRecording' + "/?audio=" + url);

			var musicControl = "" +
				"<div class=\"audioControls\"><audio id=\"player1\" preload=\"none\" controls tabindex=\"0\">" +
					"<source src=\"" + newurl + "\" type=\"audio/wav\">"
				"</audio></div>"
			$(musicControl).insertBefore($(this));

			$(this).parent().children("div.audioControls").css("z-index",0);
		});
	}

	//	add atribute to both word and phentry with name wordOrtographically
	/*
		that's useful to have
		---
	*/
	function pinAttribute_wordOrtographically() {
		$('a.word').each(function() {
			word = $(this).html();
			word = word.replace(/<\/?[^>]+(>|$)/g, "").trim();
			word = word.replace(/(\.|!)+\s*$/, "");
			word = word.replace(/(¡|¿)/, "");
			word = word.toLowerCase();
			word = $.trim(word);

			referencing_phblock = 
				$("div.phblock#d".concat($(this).attr('id')));
			referencing_phblock.attr('wordOrtographically', word);
			$(this).attr('wordOrtographically', word);
		});
	}

	function buttonCloseWindow () {
		return "<div class=buttonCloseWindow><span class=buttonCloseWindow>✖</span></div>";
	}

	//	Transform initial simple-div-listOf-pforms to complex one; 
	//	but NOTE that suggestions and synchronizatation with server state
	//	is done only when hover a word NOT in that function ↓
	/*
		Of course that should be done on server side;
		
		Add title of the whole phblock
		Add WrongRef and AmbigOrt buttons
		Add G2P Part
		Add Updates Part
	*/
	function prepare_phblock() {
		$('div.phblock').each(function() {
			$(this).css("z-index",5);
			$(this).attr('ifSuggestionShown', 'FALSE');
			word = $(this).attr('wordOrtographically');
			phblock = $(this);
			idOnlyNumber = $(this).attr('id');
			idOnlyNumber = idOnlyNumber.substring(1, idOnlyNumber.length);
			G2PForms = $(this).html().split(/<br>/);
			G2PFormsCount = G2PForms.length;
			$(this).empty();
			
			/* Add G2P Part */
			$(this).append(phblock__curr__getHeaderStr());
			$(G2PForms).each(function(index, value) {
				$(phblock)
					.append(phentry__curr(word, value.trim()));
			});

			/* Add Updates Part */
			$(this).append("<br>");
			$(this).append(phblock__updates__getHeaderStr());
			$(this).append( phentry__updates(word, G2PForms[0].trim()) );

			$(this).children("form").children("span.copyButton").each(function() {
				$(this).unbind('click').click(copyContentDown_phentry);
			});


			/*
				Prepare updates linkage
			*/
			if (typeof updatesLinkage !== 'undefined' && updatesLinkage.length != 0) {
				ul_  = updatesLinkage[idOnlyNumber-updatesLinkage__offset];

				updatesLinkageDiv = document.createElement('div');
				updatesLinkageDiv.className = "updatesLinkageDiv";
				title = document.createElement('div');
				title.className = "updatesLinkageTitle"
				title.textContent = "Last iteration modification:"
				updatesLinkageDiv.appendChild(title);

				ifEmpty = 1;
				if (ul_[1].length != 0) {
					ifEmpty = 0;
					ul_[1].forEach(function(entry) {
						ediv = document.createElement('div');
						ediv.className = "updatesLinkageRemoved";
						ediv.textContent = entry;
						updatesLinkageDiv.appendChild(ediv);
					});
				}
				if (ul_[2].length != 0) {
					ifEmpty = 0;
					ul_[2].forEach(function(entry) {
						ediv = document.createElement('div');
						ediv.className = "updatesLinkageAdded";
						ediv.textContent = entry;
						updatesLinkageDiv.appendChild(ediv);
					});
				}
				updatesLinkageDiv = updatesLinkageDiv.innerHTML;
				updatesLinkageDiv += "<hr>";
				if (ifEmpty == 1) {
					updatesLinkageDiv = "";
				}
			}
			else {
				updatesLinkageDiv = "";
			}


			/*
				Add title of the div;
				Add WrongRef and AmbigOrt buttons;
			*/
			$(this).prepend(
				"<div class=\"WORD\">"
				+ $(this).attr('wordOrtographically') 
				+ "</div><hr>" + updatesLinkageDiv);

			// $(this).prepend("<p>DUPA</p>");
			$(this).prepend(buttonAmbigOrt() + space() + "<br>" + buttonWrongRef() + "<br>" + buttonMismatchRecording() + "<br>");
			$(this).children("div.buttonAmbigOrt").click(callback__buttonAmbigOrt);
			$(this).children("div.buttonWrongRef").click(callback__buttonWrongRef);
			$(this).children("div.buttonMismatchRecording").click(callback__buttonMismatchRecording);

			$(this).prepend( buttonCloseWindow() );
			$(this).children("div.buttonCloseWindow").children("span.buttonCloseWindow").click(function () {
				var top = stackOfFunctionsToCallWhenClickedESC.pop();
				top();
			});
		});
	}

	//	Only when word is hover suggestions and synchronization are communicated;
	/*
		Clicking, hovering, etc.

		When hover a word phblock pops out;
		there is stack of current ~windows (precisely: functions to close them)
	*/
	function bind_clickhoveretc () {
		$('a.word').hover(function(e) {
				/*
					Ask just in time; 

					submit_synchronizeWordState is called each time 
					hover event occur;

					It do the same job each time to simplify things:
					delete all updates entries and again what it should add;
				*/
				if (focusedOnOneWord == false) {
					phblock = $("div.phblock#d".concat($(this).attr('id')));
					word = phblock.attr('wordOrtographically');

					//---
					sentences = findSentencesFromWord_varC($(this));
					submit_synchronizeWordState( $(this).text(), phblock, sentences);
					submit_suggestions(word, phblock);

					stackOfFunctionsToCallWhenClickedESC.push( function() { hide_phblock(phblock); } );
					phblock.show();
					offset = jQuery(this).offset();
				}
			}, 
			function() {
				if (focusedOnOneWord == false) {
					var top = stackOfFunctionsToCallWhenClickedESC.pop();
					top();
				}
			}
		);
		$('a.word').click(function(e) {
			if (focusedOnOneWord == false) {
				focusedOnOneWord = true;
				focusedWordID = $(this).attr('id');
			}
			else {
				if ( focusedWordID ==  $(this).attr('id') ) {
					var top = stackOfFunctionsToCallWhenClickedESC.pop();
					top();
				}
			}
		});
		$(document).keyup(function(e) {
		    if (e.keyCode == 27) { 
		    	var top = stackOfFunctionsToCallWhenClickedESC.pop();
		    	top();
		    }
		});
		$('a.word').mousemove(function(e) {
			if (focusedOnOneWord == false) {
				$("div.phblock#d".concat($(this)
					.attr('id'))).css('top', offset.top+20)
					.css('left', offset.left+20);
			}
		});
	}

	function findRecordingURLFromWord(word/*a.word*/) {
		var blockToSearchFrom = word;
		if ( word.parent('span').length == 1 ) {
			blockToSearchFrom= word.parent();
		}

		var recordingURL;
		
		if (blockToSearchFrom.prevUntil('a.recording').length == 0) {
			recordingURL = blockToSearchFrom.prev().attr("href");
		}
		else {
			recordingURL = blockToSearchFrom.prevUntil('a.recording').last().prev().attr("href");
		}

		return recordingURL;
	}

	function findWordFromPHBlock(phblock) {
		var parental_phblock = phblock;
		var id__parental_phblock = parental_phblock.attr("id");
		var id__word = id__parental_phblock.substring(1);
		var word = $("a#"+id__word);
		return word;
	}
	
	function findSentencesFromWord_varA(word/*a.word*/) {
		/* 
			Check whether is possible to guess the variant
		*/
		word_ = word.attr('wordortographically');
		sentence = word.parentsUntil("tr").last();
		if (word.parent().is("span")) {
			word = word.parent();
		}
		
		//Check if the word is clicked in REF or in DIFF
		var ifOnDiffSide = word.prevUntil("a.recording").is("br") //FALSE->REF, TRUE->DIFF
		
		sentenceRecordingA = word.prevAll('a.recording').first();
		brMiddle = sentenceRecordingA.nextAll('br').first();
		brEnd    = brMiddle.nextAll('br').first();
		
		var refsentence  = []
		var diffsentence = []
		it = sentenceRecordingA
		while( it[0] !== brMiddle[0] ) {
			if ( it.is('a.word') ) {
				refsentence.push(it.attr('wordortographically'))
			}
			it = it.next()
		}
		while( it.length != 0 && it[0] !== brEnd[0] ) {
			if ( it.is('a.word') ) {
				diffsentence.push(it.attr('wordortographically'))
			}
			if ( it.is('span') ) {
				it.children('a.word').each(function() {
					diffsentence.push( $(this).attr('wordortographically') );
				});
			}
			it = it.next()
		}
		
		return [ refsentence, diffsentence ]
	}
	function findSentencesFromWord_varB(word) {
		if (word.parent().is("span")) {
			word = word.parent();
		}

		sentences = word.parent().text().split("REF:")[1].split("DIFF:")
		refsentence  = sentences[0].trim().toLowerCase();
		diffsentence = sentences[1].trim().toLowerCase();
		
		var ifOnDiffSide = word.prevUntil("a.recording").is("br") //FALSE->REF, TRUE->DIFF
		var wordSide = 0
		if (ifOnDiffSide) { wordSide = 1; }
		else { wordSide = 0; } 

		return [refsentence, diffsentence, wordSide]
	}
	function findSentencesFromWord_varC(word) {
		if (word.parent().is("span")) {
			word = word.parent();
		}

		//which sentence in wordStat;
		sentenceNumber = word.prevAll('a.recording').length;

		wholeTextOfElement = $(word).parent().text();

		if ( wholeTextOfElement.indexOf('DIFF:') >= 0 ) {
			sentences = $(word).parent().text().split("REF:")[sentenceNumber].split("DIFF:")
		}
		else {
			sentences = $(word).parent().text().split("REF:")[sentenceNumber].split("HYP:")
		}

		refsentence  = sentences[0].trim().toLowerCase();
		diffsentence = sentences[1].trim().toLowerCase();
		
		var ifOnDiffSide = word.prevUntil("a.recording").is("br") //FALSE->REF, TRUE->DIFF
		if (!ifOnDiffSide ) { return [refsentence, diffsentence]; }
		else { return [diffsentence, refsentence]; } 
	}


   	//
	////
	//	WHEN DOCUMENT IS READY
	////
	//
	/*
		1. Transform simple to complex phblock
		2. Callbacks for hovering word or pressing ESC
	*/

	$('document').ready(function(e) {
		var timerStart = Date.now();

		// Add audio players inline for each REF recording
		refRecordings_insertAudioPlayerInline();

		// Prevent default for HTML:A
		$('a.word').click(function(e) {
		    /*
		    	we dont want to do any action when clicking on a word;
		    	honestly, we should replace a href html block with just
		    	span element with a some constant class;
		    */
		    e.preventDefault();
		});

		// Add attributes for word and phblock
		pinAttribute_wordOrtographically();
		
		// Transform simple to complex phblock
		prepare_phblock();

		// Setting callback for submitting any phentry (HTML:FORM)
		$("form.phentry").unbind('submit').submit( submit_phentry );

		// Clicking, hovering, etc
		bind_clickhoveretc();

		var timerEnd = Date.now();
		console.log('time %f',  timerEnd - timerStart);
	});	
});