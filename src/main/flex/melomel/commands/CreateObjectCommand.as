/*
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @author Ben Johnson
 */
package melomel.commands
{
import melomel.commands.ICommand;

import flash.events.EventDispatcher;
import melomel.errors.MelomelError;

/**
 *	This class represents an action that creates an object of a given class.
 *	
 *	@see melomel.commands.parsers.CreateObjectCommandParser
 */
public class CreateObjectCommand implements ICommand
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *	Constructor.
	 *	
	 *	@param clazz      The class reference to instantiate from.
	 *	@param methodArgs  A list of arguments to pass to the constructor.
	 *	@param throwable  A flag stating if invalid class errors are thrown.
	 */
	public function CreateObjectCommand(clazz:Class=null,
										constructorArgs:Array=null,
										throwable:Boolean=true)
	{
		this.clazz           = clazz;
		this.constructorArgs = constructorArgs;
		this.throwable       = throwable;
	}
	

	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------

	/**
	 *	The class to instantiate from.
	 */
	public var clazz:Class;

	/**
	 *	A list of arguments to pass to the constructor.
	 */
	public var constructorArgs:Array;

	/**
	 *	A flag stating if the command will throw an error for an invalid class.
	 */
	public var throwable:Boolean;


	//--------------------------------------------------------------------------
	//
	//	Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *	Instantiates an object from a class.
	 *	
	 *	@return  The instantiated object.
	 */
	public function execute():Object
	{
		// Verify class exists
		if(!clazz) {
			if(throwable) {
				throw new MelomelError("Class reference is required for instantiation");
			}
			else {
				return null;
			}
		}

		// Instantiate and return
		var numberOfArgs:int = 0;
		if(constructorArgs != null){
			numberOfArgs = constructorArgs.length;
		}
		try {
			switch(numberOfArgs) {
			  case  0: return (new clazz());
			  case  1: return (new clazz(constructorArgs[0]));
			  case  2: return (new clazz(constructorArgs[0], constructorArgs[1]));
			  case  3: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2]));
			  case  4: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]));
			  case  5: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4]));
			  case  6: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5]));
			  case  7: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6]));
			  case  8: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7]));
			  case  9: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8]));
			  case 10: return (new clazz(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3], constructorArgs[4], constructorArgs[5], constructorArgs[6], constructorArgs[7], constructorArgs[8], constructorArgs[9]));
			}
			if(throwable) {
				throw new MelomelError("Class instantiation with more than 10 arguments is not supported");
			}
		}
		catch(e:Error) {
			if(throwable) {
				throw new MelomelError("Cannot create a new instance with " + numberOfArgs.toString() + " arguments");
			}
		}
		return null;
	}
}
}