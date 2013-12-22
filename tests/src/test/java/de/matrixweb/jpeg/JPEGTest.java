package de.matrixweb.jpeg;

import java.io.File;
import java.io.IOException;

import jpeg.Jpeg;
import jpeg.Parser;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestName;

import com.google.common.base.Charsets;
import com.google.common.io.Files;

import static org.junit.Assert.*;

import static org.hamcrest.CoreMatchers.*;

/**
 * @author markusw
 */
@SuppressWarnings("javadoc")
public class JPEGTest {

  @Rule
  public TestName name = new TestName();

  private Parser parser;

  @Before
  public void setUp() {
    this.parser = new Parser();
  }

  @Test
  public void testParse() {
    final long start = System.currentTimeMillis();
    final Jpeg r = this.parser.Jpeg("Rule:'a';");
    final long end = System.currentTimeMillis();
    System.out.println("Parser Time for Test " + this.name.getMethodName()
        + ": " + (end - start) + "ms");
    assertThat(r, is(notNullValue()));
  }

  @Test
  public void testParse2() {
    final long start = System.currentTimeMillis();
    final Jpeg r = this.parser.Jpeg("Rule:Rule2|'a';\nRule2:'b';");
    final long end = System.currentTimeMillis();
    System.out.println("Parser Time for Test " + this.name.getMethodName()
        + ": " + (end - start) + "ms");
    assertThat(r, is(notNullValue()));
  }

  @Test
  public void testParseRange() {
    final long start = System.currentTimeMillis();
    final Jpeg r = this.parser.Jpeg("Rule: [\\]];");
    final long end = System.currentTimeMillis();
    System.out.println("Parser Time for Test " + this.name.getMethodName()
        + ": " + (end - start) + "ms");
    assertThat(r, is(notNullValue()));
    // final Expression e =
    // r.getRules().get(0).getBody().getExpressions().get(0);
    // final CharRange range = (CharRange) ((RangeExpression)
    // ((AssignableExpression) e)
    // .getExpr()).getRanges().get(0);
    // assertThat(range.get_char().getParsed(), is("]"));
  }

  @Test
  public void testJpegGrammar() throws IOException {
    final long start = System.currentTimeMillis();
    final Jpeg r = this.parser.Jpeg(Files.toString(new File(
        "../parser/src/test/resources/de/matrixweb/jpeg/jpeg.jpeg"),
        Charsets.UTF_8));
    final long end = System.currentTimeMillis();
    System.out.println("Parser Time for Test " + this.name.getMethodName()
        + ": " + (end - start) + "ms");
    assertThat(r, is(notNullValue()));
  }

  @Test
  public void testEcmaScriptGrammar() throws IOException {
    final long start = System.currentTimeMillis();

    final String parser = JPEG.generate(new File(
        "src/test/resources/ecmascript.jpeg"), "ecmascript");
    final long end = System.currentTimeMillis();
    System.out.println("Parser Time for Test " + this.name.getMethodName()
        + ": " + (end - start) + "ms");
    assertThat(parser, is(notNullValue()));
  }

}
