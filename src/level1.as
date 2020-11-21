package  
{
	/*
	 * Allan Legemaate, Spencer Allen, Ben Didone
	 * Meow Meow Meow the game
	 * 13/6/14
	 * Level 1
	 */
	import org.flixel.*; //Get access to all the wonders flixel has to offer
	
	public class level1 extends FlxState {
		/********************
		 * Load all images
		 *******************/
		[Embed(source = "../assets/catWalk.png")] 
		private var catWalk:Class;
		
		[Embed(source = "../assets/catSlash.png")] 
		private var catSlash:Class;
		
		private var cat_:FlxSprite;
		private var slash_:FlxSprite;
		
		[Embed(source = "../assets/background.png")] 
		private var background:Class;
		private var background_:FlxSprite;
		private var background2_:FlxSprite;
		
		[Embed(source = "../assets/backgroundLightning.png")] 
		private var backgroundLight:Class;
		private var backgroundLight_:FlxSprite;
		
		[Embed(source = "../assets/foreground.png")] 
		private var foreground:Class;
		private var foreground_:FlxSprite;
		private var foreground2_:FlxSprite;
		
		[Embed(source = "../assets/midground.png")] 
		private var midground:Class;
		private var midground_:FlxSprite;
		private var midground2_:FlxSprite;
		
		[Embed(source = "../assets/rain.png")] 
		private var rainEffect:Class;
		
		[Embed(source = "../assets/barrier.png")] 
		private var barrier:Class;
		
		[Embed(source = "../assets/garbage.png")] 
		private var garbage:Class;
		
		// Groups
		private var barriers:FlxGroup;
		private var rain:FlxGroup;
		private var blockers:FlxGroup;
		
		// Debug text
		private var debugText:FlxText;
		
		/**********
		 * Sounds
		 *********/
		[Embed(source = "../assets/sfx/rainMusic.mp3")] 
		private var rainSound:Class;
	
		[Embed(source = "../assets/sfx/thunder.mp3")] 
		private var thunderSound:Class;
		
		[Embed(source = "../assets/sfx/meow.mp3")] 
		private var meowSound:Class;
		
		[Embed(source = "../assets/sfx/swipe.mp3")] 
		private var swipeSound:Class;
	
		/*************
		 * Variables
		 ************/
		//text variables
		private var numberLives:FlxText;
		private var scoreDisplay:FlxText;
		
		//game state variables
		private var lives:Number;
		private var score:Number;
		private var thunderTimer:Number;
		private var _jump:Number = 0;
		private var isSlashing:Boolean = false;
		private var speed:Number;
		private var i:Number = 0;
		private var isJumping:Boolean = true;
		private var slashTime:Number = 0;
		
		private var emitter:FlxEmitter;
		
		/**************
		 * Constructor
		 *************/
		function level1() {
			super();
		}
		
		/**************************
		 * Convert int to string
		 **************************/
		public function intToString( number:int):String {
			return number.toString();
		}
		
		
		/*****************
		 * Make barriers
		 ****************/
		public function makeBarriers( amount:int):void {
			// Create asked amount
			for ( i = 0; i < amount; i++) {
			    var barrier_:FlxSprite = new FlxSprite(i * 320, 400 + Math.random()*60, barrier);
				barrier_.immovable = true;
				this.add(barrier_);
				barriers.add(barrier_);
			}
			
			/***************
			 * Sort through barriers and organize by height to create step effect
			 ***************/
			for ( i = 0; i < amount - 1; i++) {
				if ( barriers.members[i].y > barriers.members[(i + 1)].y) {
					barriers.members[i].y = barriers.members[(i + 1)].y - 1;
				}
			}
		}
		
		
		/*****************
		 * Make garbage
		 ****************/
		public function makeGarbage( amount:int):void {
			// Create asked amount
			for ( i = 0; i < amount; i++) {
			    var garbage_:FlxSprite = new FlxSprite(640, 0, garbage);
				garbage_.immovable = false;
				garbage_.mass = 1;
				garbage_.acceleration.y = 600;
				this.add(garbage_);
				blockers.add(garbage_);
			}
		}
		
		
		/*****************
		 * Setup Game
		 ****************/
		override public function create():void {
			super.create();
			
			// Debug mode!
			FlxG.debug = true; 
			
			
			/*******************
			 * Groups (arrays)
			 *******************/
			// Add the barriers to our group
			barriers = new FlxGroup();
			rain = new FlxGroup();
			blockers = new FlxGroup();
			
			
			/**************
			 * Parallax
			 *************/
			// Background
			background_ = new FlxSprite( 0, 0, background);
			background2_ = new FlxSprite( 1280, 0, background);
			this.add(background_);
			this.add(background2_);
			
			// Lightning background
			backgroundLight_ = new FlxSprite( 0, 0, backgroundLight);
			backgroundLight_.visible = false;
			this.add(backgroundLight_);
			
			// Midground
			midground_ = new FlxSprite( 0, 0, midground);
			midground2_ = new FlxSprite( 2560, 0, midground);
			this.add(midground_);
			this.add(midground2_);
			
			// Background
			foreground_ = new FlxSprite( 0, 0, foreground);
			foreground2_ = new FlxSprite( 5120, 0, foreground);
			this.add(foreground_);
			this.add(foreground2_);
			
			// Make some barriers
			makeBarriers( 3);
			
			
			/*********
			 * Cat
			 ********/
			cat_ = new FlxSprite(64, 128, null);
			cat_.loadGraphic(catWalk, true, true, 100, 100, true);
			cat_.addAnimation("catWalking", [0, 1, 2, 3], 10, true);
			cat_.addAnimation("catJumping", [0, 0, 0, 0], 10, true);
			cat_.play("catWalking");
			cat_.acceleration.y = 2000;
			this.add(cat_);
			
			slash_ = new FlxSprite(0, 0, null);
			slash_.loadGraphic(catSlash, true, true, 55, 100, true);
			slash_.addAnimation("catSlash", [0, 1], 2, true);
			slash_.addAnimation("catStopSlash", [2, 2], 10, true);
			this.add(slash_);
			
			/**************
			 * Variables
			 *************/
			lives = 3;
			_jump = 0;
			speed = 6;
			thunderTimer = 0;
			score = 0;
			
			numberLives = new FlxText(0, 20, 100, "Lives:" + lives);
			numberLives.setFormat (null, 16, 0xFFFFFFFF, "right");
			this.add(numberLives);
			
			scoreDisplay = new FlxText(0, 40, 100, "Score:" + score);
			scoreDisplay.setFormat (null, 16, 0xFFFFFFFF, "right");
			this.add(scoreDisplay);
			
			// Play song
			FlxG.play(rainSound, 1, true);
			
			
			/******************
			 * Rain Particles
			 ******************/
			emitter = new FlxEmitter( 0, 0, 800); //x and y of the emitter

			emitter.makeParticles(rainEffect, 800, 0, false, 0);
			
			emitter.minRotation = 0;
			emitter.maxRotation = 0;
			emitter.width = 1280;
			emitter.setXSpeed( -320, -320);
			
			emitter.setYSpeed( 320, 320);
			
			add(emitter);
			emitter.start( false, 2, 0.0025, 0);
			
			// Text
			debugText = new FlxText( 0, 0, 40, "swag");
			add(debugText);
		}
		
		/***********
		 * Speed Up
		 ***********/
		public function speedUp( speedIncrease:int):void {
			speed += speedIncrease;
		}
		
		/*****************
		 * Create thunder
		 ****************/
		public function createThunder():void {
			// Random thunder
			if (  int(Math.random() * 800) == 1 && thunderTimer == 0) {
				thunderTimer = FlxG.elapsed;
			}
			
			if ( thunderTimer > 0) {
				thunderTimer += FlxG.elapsed;
				if ( thunderTimer > 0) {
					backgroundLight_.visible = true;
				}
				if ( thunderTimer > 0.2) {
					backgroundLight_.visible = false;
				}
				if ( thunderTimer > 1.0) {
					FlxG.play(thunderSound, 1, false);
					thunderTimer = 0;
				}
			}
		}
		
		/********************
		 * Scroll background
		 *******************/
	    public function scrollBackground():void {
			// Background scroll
			if ( background_.x - speed/2 < -1280 ) {
				background_.x = 1280;
			}
			if ( background2_.x - speed/2 < -1280) {
				background2_.x = 1280;
			}
			background_.x -= speed / 2;
			background2_.x -= speed / 2;
			
			// Midground scroll
			if ( midground_.x - speed/1.6 < -2560 ) {
				midground_.x = 2560;
			}
			if ( midground2_.x - speed/1.6 < -2560) {
				midground2_.x = 2560;
			}
			midground_.x -= speed / 1.6;
			midground2_.x -= speed / 1.6;
			
			// Foreground scroll
			if ( foreground_.x - speed/1.5 < -5120 ) {
				foreground_.x = 5120;
			}
			if ( foreground2_.x - speed/1.5 < -5120) {
				foreground2_.x = 5120;
			}
			foreground_.x -= speed / 1.5;
			foreground2_.x -= speed / 1.5;
			
			// Incrase speed
			emitter.setXSpeed( -320 - 25 * speed, -320 - 25 * speed);
		}
		
		/***************
		 * Update Game
		 **************/
		override public function update():void {
			// Debug the timer
			debugText.text = String(cat_.velocity.y);
			
			// Always call this at the start of the function
			super.update();
			
			// Create thunder
			createThunder();
			
			// Scroll background
			scrollBackground();
			
			// Move barriers
			for ( i = 0; i < barriers.length; i++) {
				barriers.members[i].x -= speed;
				if ( barriers.members[i].x < -1 * barriers.members[i].width) {
					barriers.members[i].x = 640;
					barriers.members[i].y = 350 + Math.random() * 110;
				}
			}
			
			/***********
			 * Slashing
			 ***********/
			if ( FlxG.keys.justPressed("RIGHT")) {
				slash_.play("catSlash");
				isSlashing = true;
				slashTime = 0.40;
				FlxG.play( swipeSound, 1, false);
			}
			if ( slashTime > 0) {
				slashTime -= FlxG.elapsed;
			}
			if ( slashTime <= 0) {
				slash_.play("catStopSlash");
				isSlashing = false;
				slashTime = 0;
			}
			slash_.x = cat_.x + 90;
			slash_.y = cat_.y;
			 
			
			/************
			 * Jumping
			 ***********/
			// Time jumping for
			if ( !isJumping || _jump > 0) {
				if(FlxG.keys.UP || FlxG.mouse.pressed()) {
					if (_jump >= 0.5) {
						//You can't jump for more than 0.5 second
						_jump = 0; 
					}
					else {
						_jump += FlxG.elapsed;
						cat_.y -= 1;
						cat_.velocity.y = -350;
					}
				}
				else {
					_jump = 0;
				}
            }
			
			/***********
			 * Collide
			 **********/
			if ( FlxG.collide(cat_, barriers)) {
				cat_.play("catWalking");
				isJumping = false;
			}
			else {
				isJumping = true;
				cat_.play("catJumping");
			}
			
			// Garbage with barriers
			FlxG.collide(blockers, barriers);
			
			// Cut garbage
			for ( i = 0; i < blockers.length; i++){
				if ( isSlashing && FlxG.collide(slash_, blockers.members[i])) {
					// make sure box hasnt been hit
					if( blockers.members[i].acceleration.y != -1000){
						score += 5;
					}
					
					blockers.remove(blockers.members[i]);
					remove(blockers.members[i]);
					
				}
			}
			
			// Run into garbage
			FlxG.collide(blockers, cat_);
			
			/**********
			 *  Die
			 **********/
			if ( cat_.y > 480 || cat_.x + cat_.width < 0 ) {
				cat_.y = 0;
				cat_.x = 64;
				FlxG.play(meowSound, 1, false);
				lives -= 1;
				isJumping = true;
				
				numberLives.text = "Lives:" + intToString(lives);
				
				if ( lives <= 0) {
					if ( score > globals.bestScore) {
						globals.bestScore = int(score);
					}
					FlxG.switchState(new menuScreen());
				}
			}
			
			// Display score
			scoreDisplay.text = "Score:" + intToString(score);
			
			// Increase score
			score += FlxG.elapsed;
			
			/****************
			 * Make Garbage
			 ****************/
			if ( int( Math.random() * 200) == 1){
				makeGarbage( 1);
			}
			
			/*****************
			 * Speed up Game
			 *****************/
			 if ( speed < 10) {
				 speed += 0.001;
			 }
		}
	}
}