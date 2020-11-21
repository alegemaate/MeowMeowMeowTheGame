package  
{
	/*
	 * Allan Legemaate, Spencer Allen, Ben Didone
	 * Meow Meow Meow the game
	 * 13/6/14
	 * The Game
	 */
	import org.flixel.*; //Allows you to refer to flixel objects in your code

	public class theGame extends FlxGame
	{
		public function theGame():void
		{
			// Creat screen
			super(640,480,menuScreen,1);
			
			// Display cursor
			FlxG.mouse.show();
		}
	}

}