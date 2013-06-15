$( document ).ready( function() {

	if ( window.innerWidth < 1280 ) {
    	return;
    }
	
    var navUl = $( 'nav ul' );
    navUl.append( '<li id="theme-switcher"></li>');
    
    var	li = $( '#theme-switcher' ),
		themes = [
			{ id: 'darkgrey', color: '#D4D4D4' },
			{ id: 'deadcream', color: '#000' }
		],
        i, a, visible = false, selected;

    for ( i in themes ) {
    	if ( themes.hasOwnProperty( i ) ) {
			a = $( createElem('a') );
			a.addClass( 'tile' )
				.attr( 'href', '#' )
				.attr( 'id', themes[ i ].id )
				.css( 'background-color', themes[ i ].color )
				.appendTo( li );
    	}
    }
    
    li.click( function( e ) {
    	var target = e.target;
    	
		if ( !visible && target == selected ) {
			visible = true;
			li.addClass( 'open' );

		} else if ( visible && target.nodeName.toLowerCase() == 'a' ) {
			visible = false;

			getStyleheet( selected[ 0 ].id ).disabled = true;
			selected.removeClass( 'selected' );

			( selected = $( target ) ).addClass( 'selected' );
			getStyleheet( selected[ 0 ].id ).disabled = false;

			li.removeClass( 'open' );
		}
	} );

	selected = $( 'deadcream' );
	selected.addClass( 'selected' );

} );
