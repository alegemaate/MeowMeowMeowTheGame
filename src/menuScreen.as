package 
{
	/*
	 * Allan Legemaate, Spencer Allen, Ben Didone
	 * Meow Meow Meow the game
	 * 13/6/14
	 * Menu
	 */
	
	import org.flixel.*; //Get access to all the wonders flixel has to offer
	
	public class  menuScreen extends FlxState
	{
		// Images
		[Embed(source = "../assets/menu.png")] 
		private var menu:Class;
		private var menu_:FlxSprite;
		
		[Embed(source = "../assets/thoughts.png")] 
		private var thoughts:Class;
		private var thoughts_:FlxSprite;
		
		[Embed(source = "../assets/thoughtBubble.png")] 
		private var thoughtBubble:Class;
		private var thoughtBubble_:FlxSprite;
		
		[Embed(source = "../assets/rain.png")] 
		private var rainEffect:Class;
		
		// Music
		[Embed(source = "../assets/sfx/rain.mp3")] 
		private var rainSound:Class;
		
		// Create text ( string function)
		public function createText( size:int, newX:int, newY:int, newText:String):void {
			// Add text to title
			var instructions:FlxText;
			instructions = new FlxText(newX, newY, FlxG.width, newText);
			instructions.setFormat (null, size, 0xFFFFFFFF, "center");
			this.add(instructions);
		}
		
		override public function create():void
		{
			// Background
			menu_ = new FlxSprite( 0, 0, menu);
			this.add(menu_);
			
			// Animated thoguhts bubble
			thoughtBubble_ = new FlxSprite( 98, 154, thoughtBubble);
			this.add(thoughtBubble_);
			
			thoughts_ = new FlxSprite( 98, 154, null);
			thoughts_.loadGraphic(thoughts, true, true, 118, 118, true);
			thoughts_.addAnimation("thoughtAnimation", [0, 1, 2, 3, 4], 0.4, true);
			thoughts_.play("thoughtAnimation");
			this.add(thoughts_);
			
			// Instruction Text
			createText( 16, 0, FlxG.height - 170, "Press Space To Play");
			createText( 12, 0, FlxG.height - 150, "Best Score:" + globals.bestScore);
			
			// Play music
			FlxG.play(rainSound, 1, true);
			
			// Rain effects
			var emitter:FlxEmitter = new FlxEmitter( 0, 0, 800); //x and y of the emitter

			emitter.makeParticles(rainEffect, 800, 0, false, 0);
			
			emitter.minRotation = 0;
			emitter.maxRotation = 0;
			emitter.width = 1280;
			emitter.setXSpeed( -500, -500);
			emitter.setYSpeed( 320, 320);
			
			add(emitter);
			emitter.start( false, 2, 0.0025, 0);
 
		} // end function create

 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new level1());
			}
 
		} // end function update
 
 
		public function menuScreen()
		{
			super();
 
		}  // end function 	
	}
	
}