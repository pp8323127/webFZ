public class GetRound
{
   
   /**
   * Method to round a double value to the given precision
   * @param <b>val</b> The double to be rounded
   * @param <b>precision</b> Rounding precision
   * @return <b>double</b> The rounded value
   */
  public static double round( double val, int precision ) 
  {
    // Multiply by 10 to the power of precision and add 0.5 for rounding up
    // Take the nearest integer smaller than this value
    val = Math.floor( val * Math.pow( 10, precision ) + 0.5 );
    
    // Divide it by 10**precision to get the rounded value
    return val / Math.pow( 10, precision );
  }
}