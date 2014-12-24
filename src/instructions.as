package 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class  instructions extends FlxState
	{
	override public function create():void
		{
			
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new menuScreen());
			}
 
		} // end function update
 
 
		public function instructions()
		{
			super();
 
		}  // end function 	
	}
	
}