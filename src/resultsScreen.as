package 
{
	import org.flixel.FlxSave;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class  resultsScreen extends FlxState
	{
		private var _save:FlxSave
	override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Your Results");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var results:FlxText;
			results = new FlxText(0, FlxG.height - 100, FlxG.width, "You completed "+ globals.levelCompleted + " level(s)!");
			results.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(results);
			
			//reset globals
			globals.levelCompleted = 0;
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press M To See Menu");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			//the following shows you how to save game state information onto the browsers memory
			_save = new FlxSave();//create the FlxSave object
			if (_save.bind("gameData") == true)//bind it to a name to represent your file
			{//if binding returns true then it means the file is available for data writing and reading
				_save.data.levelCompleted = globals.levelCompleted;//write to the save objects data by providing a property to write to and a value
				_save.flush();
				_save.close();
			}
			//that's it!!!! your info is saved
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("M"))
			{
				FlxG.switchState(new menuScreen());
				
			}
 
		} // end function update
 
 
		public function resultsScreen()
		{
			super();
 
		}  // end function 	
	}
	
}