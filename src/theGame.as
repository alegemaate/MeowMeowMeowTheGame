package  
{
	/*
	 * Allan Legemaate, Spencer Allen, Ben Didone
	 * Meow Meow Meow the game
	 * 13/6/14
	 * The Game
	 */
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass="Preloader")]  //Tells flixel to use the default preloader

	public class theGame extends FlxGame
	{
		public function theGame():void
		{
			// Creat screen
			super(640,480,menuScreen,1);
			forceDebugger = true;
			
			// Display cursor
			FlxG.mouse.show();
		}
	}

}