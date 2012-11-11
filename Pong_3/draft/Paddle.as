﻿package  {	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.display.DisplayObject;	import flash.geom.Point;	public class Paddle extends MovieClip{		private var speed:int;		private var dirY:int =0;		private var theStage:DisplayObject;		private var stageH:int;		private var stageW:int;		private var downKeyCode:int;		private var upKeyCode:int;				private var paddledown:Boolean;		private var paddleup:Boolean;				private var _ball:Ball;		private var normal:Point;		private var bounce_angle:Number = 15;				public function Paddle(theStage:DisplayObject,posX:int, posY:int, w:int, h:int, normal:Point, downKeyCode:int=83, upKeyCode:int=87, speed:int=10) {			// constructor code			this.speed = speed;			this.x = posX;			this.y = posY;			this.stageH = h;			this.stageW = w;			this.paddledown = false;			this.paddleup = false;			this.downKeyCode = downKeyCode;			this.upKeyCode = upKeyCode;			this.normal = normal;			//this.ball = ball;					}				public function init():void {			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown);			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup);			this.stage.addEventListener(Event.ENTER_FRAME, checkLoop);				}				public function set ball(b:Ball):void {			this._ball = b;		}				public function get ball():Ball {			return this._ball;		}				public function keydown(keyEvent:KeyboardEvent) {			// w - 87			if (keyEvent.keyCode==this.upKeyCode) {				this.paddleup = true;				//this.dirY = this.speed * -1;							}			//s - 83			if (keyEvent.keyCode==this.downKeyCode) {				this.paddledown = true;				//this.dirY = this.speed;			}		}		public function keyup(keyEvent:KeyboardEvent):void{			if (keyEvent.keyCode == this.downKeyCode) {				this.paddledown = false;			}			if (keyEvent.keyCode == this.upKeyCode) {				this.paddleup = false;			}		}				private function checkLoop(e:Event):void {			var halfHeight:Number = this.height / 2.0;			this.dirY = 0;			if (this._ball != null) {										if ( (this.ball.nextPosition.x - (this.ball.width/2.0) <= this.x + this.width && this.ball.nextPosition.x - (this.ball.width/2.0) >= this.x) ||				 (this.ball.nextPosition.x + (this.ball.width/2.0) <= this.x + this.width && this.ball.nextPosition.x + (this.ball.width/2.0) >= this.x) ||				 (this.ball.x - (this.ball.width/2.0) < this.x && this.ball.nextPosition.x - (this.ball.width/2.0) > this.x + this.width ) ||				 (this.ball.x + (this.ball.width/2.0) > this.x + this.width && this.ball.nextPosition.x + (this.ball.width/2.0) < this.x ) ) {								if ( this.ball.nextPosition.y - this.ball.height/2.0 <= this.y + this.height && this.ball.nextPosition.y + this.ball.height/2.0 >= this.y) {					// figure out normal					// figure out normal					var offsetNormal:Point = this.normal.clone();					var offset:Number; //((this.ball.y - (this.y+this.height/2.0)) / (this.height/2.0 + this.ball.height/2.0)) * this.bounce_angle;					var a:Number;					var b:Number;										if (this.ball.x  < this.x) {						// Is the ball left of the paddle						a = this.ball.y - (this.y + this.height/2.0);						b = (this.height/2.0 + this.ball.height/2.0);						offset = a / b;						offsetNormal = new Point(-1,0);						this.ball.x = (this.x - this.ball.width/2.0) - 1.0 ;					} else if (this.ball.x > this.x + this.width) {						// Is the ball right of the paddle						a = this.ball.y - (this.y + this.height/2.0);						b = (this.height/2.0 + this.ball.height/2.0);						offset = a / b;						offsetNormal = new Point(1,0);						this.ball.x = (this.x + this.width) + (this.ball.width/2.0) + 1.0;										} else {						trace("something went wrong");					}										// offset angel					var dir:Number = Math.atan2(offsetNormal.y, offsetNormal.x);					dir += offset * (this.bounce_angle * (Math.PI/180));										offsetNormal.x = Math.cos(dir);					offsetNormal.y = Math.sin(dir);										this.ball.bounce(this.ball.vector,offsetNormal.clone());				}			}			}			// cal paddle movement			if (this.paddledown) {				this.dirY += this.speed;			}			if (this.paddleup) {				this.dirY += this.speed * -1;			}						// move paddle			if(this.y+this.dirY < 0) {				this.y = 0;				this.dirY = 0;			} else if (this.y+this.dirY > this.stageH-this.height){				this.y = this.stageH - this.height;				this.dirY = 0;			} else {				this.y += this.dirY;			}					}	}	}