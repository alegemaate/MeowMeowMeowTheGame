package  
{
	/*
	 * Allan Legemaate, Spencer Allen, Ben Didone
	 * Meow Meow Meow the game
	 * 13/6/14
	 * Stores global variables
	 */
	import flash.accessibility.Accessibility;
	import org.flixel.*; //Get access to all the wonders flixel has to offer
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	
	public class globals extends FlxState                //The class declaration for the main game state
	{
		
		/*
		 * 
		 * GLOBAL VARIABLES have the format:
			 * public static var name:type;
			 * 
		 * 
		 * */
		public static var levelCompleted:Number = 0;
		public static var bestScore:Number = 0;
		
		/*/leave this function alone	
		 * * Its the constructor of the class. Not necessary for you to understand in ICS3U.
		 * * 
		 * */
		public function globals() 
		{
			super();
		}
		
		
		
	}

}