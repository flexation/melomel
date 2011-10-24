package melomel.commands.parsers
{
import melomel.commands.CreateObjectCommand;
import melomel.core.ObjectProxyManager;

import org.flexunit.Assert;
import org.flexunit.async.Async;

import flash.geom.Point;

public class CreateObjectCommandParserTest
{
	//---------------------------------------------------------------------
	//
	//  Setup
	//
	//---------------------------------------------------------------------

	private var parser:ICommandParser;
	private var command:CreateObjectCommand;
	private var manager:ObjectProxyManager;
	
	[Before]
	public function setUp():void
	{
		manager = new ObjectProxyManager();
		parser = new CreateObjectCommandParser(manager);
	}

	[After]
	public function tearDown():void
	{
		parser  = null;
		command = null;
	}


	//---------------------------------------------------------------------
	//
	//  Methods
	//
	//---------------------------------------------------------------------
	
	//-----------------------------
	//  Parse
	//-----------------------------

	[Test]
	public function parseWithName():void
	{
		// Assign actual proxy id to the message
		var message:XML = <create class="flash.geom.Point"/>;

		// Parse message
		command = parser.parse(message) as CreateObjectCommand;
		Assert.assertEquals(command.clazz, Point);
	}

	[Test]
	public function parseWithConstructorArgs():void
	{
		// Assign actual proxy id to the message
		var message:XML = <create class="flash.geom.Point"><args><arg value="John"/><arg value="2" dataType="int"/></args></create>;

		// Parse message
		command = parser.parse(message) as CreateObjectCommand;
		Assert.assertEquals(command.constructorArgs.length, 2);
		Assert.assertEquals(command.constructorArgs[0], "John");
		Assert.assertEquals(command.constructorArgs[1], 2);
	}

	[Test(expects="melomel.errors.MelomelError")]
	public function parseWithoutMessageThrowsError():void
	{
		parser.parse(null);
	}

	[Test(expects="melomel.errors.MelomelError")]
	public function parseWithInvalidAction():void
	{
		var message:XML = <foo class="flash.geom.Point"/>;
		parser.parse(message);
	}

	[Test(expects="melomel.errors.MelomelError")]
	public function parseWithParametersThrowsError():void
	{
		parser.parse(<create/>);
	}

	[Test(expects="melomel.errors.MelomelError")]
	public function shouldThrowErrorIfInvalidClassAndThrowable():void
	{
		var message:XML = <create class="no.such.class"/>;
		command = parser.parse(message) as CreateObjectCommand;
	}

	[Test]
	public function shouldReturnNullIfInvalidClassAndNotThrowable():void
	{
		var message:XML = <create class="no.such.class" throwable="false"/>;
		command = parser.parse(message) as CreateObjectCommand;
		Assert.assertNull(command.clazz);
	}
}
}