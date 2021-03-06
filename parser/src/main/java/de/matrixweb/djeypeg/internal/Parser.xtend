package de.matrixweb.djeypeg.internal

import java.util.Set

import static extension de.matrixweb.djeypeg.internal.CharacterRange.*
import static extension de.matrixweb.djeypeg.internal.Parser.*

class Parser {
  
  package static Result<Object> CONTINUE = new SpecialResult(new Object)
  package static Result<Object> BREAK = new SpecialResult(null)
  
  package char[] chars
  
  package def Derivation parse(int idx) {
    new Derivation(this, idx, [
        return 
          if (idx < chars.length) new Result<Character>(chars.get(idx), parse(idx + 1), new ParseInfo(idx))
          else new Result<Character>(null, parse(idx), new ParseInfo(idx, 'Unexpected end of input'))
      ])
  }
  
  package def getLineAndColumn(int idx) {
    val nl = '\n'.charAt(0)
    
    var line = 1
    var column = 0
    if (idx > 0) 
      for (n : 0..(idx - 1))
        if (chars.get(n) === nl) { line = line + 1; column = 0 }
        else column = column + 1
    return line -> column
  }
  
  package static def Result<Terminal> __terminal(Derivation derivation, String str) {
    var n = 0
    var d = derivation
    while (n < str.length) {
      val r = d.dvChar
      d = r.derivation
      if (r.node == null || r.node != str.charAt(n)) {
        return new Result<Terminal>(null, derivation, new ParseInfo(d.index, "'" + str + "'"))
      }
      n = n + 1
    }
    new Result<Terminal>(new Terminal(str), d, new ParseInfo(d.index))
  }
  
  package static def Result<Terminal> __oneOfThese(Derivation derivation, CharacterRange range) {
    val r = derivation.dvChar
    return 
      if (r.node != null && range.contains(r.node)) new Result<Terminal>(new Terminal(r.node), r.derivation, new ParseInfo(r.derivation.index))
      else new Result<Terminal>(null, derivation, new ParseInfo(r.derivation.index, "'" + range + "'"))
  }

  package static def Result<Terminal> __oneOfThese(Derivation derivation, String range) {
    derivation.__oneOfThese(new CharacterRange(range))
  }

  package static def Result<Terminal> __any(Derivation derivation) {
    val r = derivation.dvChar
    return
      if (r.node != null) new Result<Terminal>(new Terminal(r.node), r.derivation, new ParseInfo(r.derivation.index))
      else  new Result<Terminal>(null, derivation, new ParseInfo(r.derivation.index, 'end of input'))
  }

  def Djeypeg Djeypeg(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvDjeypeg
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Rule Rule(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvRule
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Body Body(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvBody
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression Expression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression ChoiceExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvChoiceExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression SequenceExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvSequenceExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression SequenceExpressionExpressions(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvSequenceExpressionExpressions
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression ActionExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvActionExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def ActionOperator ActionOperator(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvActionOperator
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression AndPredicateExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvAndPredicateExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression NotPredicateExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvNotPredicateExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression OneOrMoreExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvOneOrMoreExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression ZeroOrMoreExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvZeroOrMoreExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression OptionalExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvOptionalExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression AssignableExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvAssignableExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression AssignableExpressionExpressions(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvAssignableExpressionExpressions
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def AssignmentOperator AssignmentOperator(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvAssignmentOperator
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression GroupExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvGroupExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression RangeExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvRangeExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def MinMaxRange MinMaxRange(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvMinMaxRange
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def CharRange CharRange(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvCharRange
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression AnyCharExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvAnyCharExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression RuleReferenceExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvRuleReferenceExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Expression TerminalExpression(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvTerminalExpression
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def InTerminalChar InTerminalChar(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvInTerminalChar
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def ID ID(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvID
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def EOI EOI(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvEOI
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def Comment Comment(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvComment
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def WS WS(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dvWS
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  def _ _(String in) {
    this.chars = in.toCharArray()
    val result = parse(0).dv_
    return
      if (result.derivation.dvChar.node == null) result.node
      else throw new ParseException(result.info.position.lineAndColumn, result.info.messages)
  }
  
  
}

package class DjeypegRule {

  /**
   * Djeypeg <- _ rules+=Rule+ EOI; 
   */
  package static def Result<? extends Djeypeg> matchDjeypeg(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Djeypeg node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 = d.dv_
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // rules+=Rule+ 
      var backup0 = node?.copy()
      var backup1 = d
      var loop0 = false
      
      do {
        // rules+=Rule
        val result1 = d.dvRule
        d = result1.derivation
        result = result1
        info.join(result1, false)
        if (result.node != null) {
          if (node == null) {
            node = new Djeypeg
          }
          node.add(result1.node)
        }
        
        if (result.node != null) {
          loop0 = true
          backup0 = node?.copy()
          backup1 = d
        }
      } while(result.node != null)
      if (!loop0) {
        node = backup0
        d = backup1
      } else {
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    if (result.node != null) {
      val result2 = d.dvEOI
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new Djeypeg()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Djeypeg>(node, d, result.info)
    }
    return new Result<Djeypeg>(null, derivation, result.info)
  }
  
  
}
package class RuleRule {

  /**
   * Rule <- name=ID _ ('[' _ returns=ID _ ']' _)? '<-' _ body=Body ';' _; 
   */
  package static def Result<? extends Rule> matchRule(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Rule node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // name=ID 
    val result0 = d.dvID
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new Rule
      }
      node.setName(result0.node)
    }
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // ('[' _ returns=ID _ ']' _)? 
      val backup0 = node?.copy()
      val backup1 = d
      
      val result2 =  d.__terminal('[')
      d = result2.derivation
      result = result2
      info.join(result2, false)
      
      if (result.node != null) {
        val result3 = d.dv_
        d = result3.derivation
        result = result3
        info.join(result3, false)
      }
      
      if (result.node != null) {
        // returns=ID 
        val result4 = d.dvID
        d = result4.derivation
        result = result4
        info.join(result4, false)
        if (result.node != null) {
          if (node == null) {
            node = new Rule
          }
          node.setReturns(result4.node)
        }
      }
      
      if (result.node != null) {
        val result5 = d.dv_
        d = result5.derivation
        result = result5
        info.join(result5, false)
      }
      
      if (result.node != null) {
        val result6 =  d.__terminal(']')
        d = result6.derivation
        result = result6
        info.join(result6, false)
      }
      
      if (result.node != null) {
        val result7 = d.dv_
        d = result7.derivation
        result = result7
        info.join(result7, false)
      }
      if (result.node == null) {
        node = backup0
        d = backup1
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    if (result.node != null) {
      val result8 =  d.__terminal('<-')
      d = result8.derivation
      result = result8
      info.join(result8, false)
    }
    
    if (result.node != null) {
      val result9 = d.dv_
      d = result9.derivation
      result = result9
      info.join(result9, false)
    }
    
    if (result.node != null) {
      // body=Body 
      val result10 = d.dvBody
      d = result10.derivation
      result = result10
      info.join(result10, false)
      if (result.node != null) {
        if (node == null) {
          node = new Rule
        }
        node.setBody(result10.node)
      }
    }
    
    if (result.node != null) {
      val result11 =  d.__terminal(';')
      d = result11.derivation
      result = result11
      info.join(result11, false)
    }
    
    if (result.node != null) {
      val result12 = d.dv_
      d = result12.derivation
      result = result12
      info.join(result12, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new Rule()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Rule>(node, d, result.info)
    }
    return new Result<Rule>(null, derivation, result.info)
  }
  
  
}
package class BodyRule {

  /**
   * Body <- (expressions+=ChoiceExpression _)+; // -- Expressions -------------------------------------------------------------- 
   */
  package static def Result<? extends Body> matchBody(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Body node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // (expressions+=ChoiceExpression _)+
    var backup0 = node?.copy()
    var backup1 = d
    var loop0 = false
    
    do {
      // expressions+=ChoiceExpression 
      val result0 = d.dvChoiceExpression
      d = result0.derivation
      result = result0
      info.join(result0, false)
      if (result.node != null) {
        if (node == null) {
          node = new Body
        }
        node.add(result0.node)
      }
      
      if (result.node != null) {
        val result1 = d.dv_
        d = result1.derivation
        result = result1
        info.join(result1, false)
      }
      
      if (result.node != null) {
        loop0 = true
        backup0 = node?.copy()
        backup1 = d
      }
    } while(result.node != null)
    if (!loop0) {
      node = backup0
      d = backup1
    } else {
      result = CONTINUE
      info.join(result, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new Body()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Body>(node, d, result.info)
    }
    return new Result<Body>(null, derivation, result.info)
  }
  
  
}
package class ExpressionRule {

  /**
   * Expression <- ActionExpression / AndPredicateExpression / AnyCharExpression / AssignableExpression / ChoiceExpression / NotPredicateExpression / OneOrMoreExpression / OptionalExpression / RangeExpression / RuleReferenceExpression / SequenceExpression / GroupExpression / TerminalExpression / ZeroOrMoreExpression ; 
   */
  package static def Result<? extends Expression> matchExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // ActionExpression\u000a            / AndPredicateExpression\u000a            / AnyCharExpression\u000a            / AssignableExpression\u000a            / ChoiceExpression\u000a            / NotPredicateExpression\u000a            / OneOrMoreExpression\u000a            / OptionalExpression\u000a            / RangeExpression\u000a            / RuleReferenceExpression\u000a            / SequenceExpression\u000a            / GroupExpression\u000a            / TerminalExpression\u000a            / ZeroOrMoreExpression\u000a
    val backup0 = node?.copy()
    val backup1 = d
    
    val result0 = d.dvActionExpression
    d = result0.derivation
    if (node == null) {
      node = result0.node
    }
    result = result0
    info.join(result0, false)
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result1 = d.dvAndPredicateExpression
      d = result1.derivation
      if (node == null) {
        node = result1.node
      }
      result = result1
      info.join(result1, false)
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result2 = d.dvAnyCharExpression
        d = result2.derivation
        if (node == null) {
          node = result2.node
        }
        result = result2
        info.join(result2, false)
        if (result.node == null) {
          node = backup4
          d = backup5
          val backup6 = node?.copy()
          val backup7 = d
          
          val result3 = d.dvAssignableExpression
          d = result3.derivation
          if (node == null) {
            node = result3.node
          }
          result = result3
          info.join(result3, false)
          if (result.node == null) {
            node = backup6
            d = backup7
            val backup8 = node?.copy()
            val backup9 = d
            
            val result4 = d.dvChoiceExpression
            d = result4.derivation
            if (node == null) {
              node = result4.node
            }
            result = result4
            info.join(result4, false)
            if (result.node == null) {
              node = backup8
              d = backup9
              val backup10 = node?.copy()
              val backup11 = d
              
              val result5 = d.dvNotPredicateExpression
              d = result5.derivation
              if (node == null) {
                node = result5.node
              }
              result = result5
              info.join(result5, false)
              if (result.node == null) {
                node = backup10
                d = backup11
                val backup12 = node?.copy()
                val backup13 = d
                
                val result6 = d.dvOneOrMoreExpression
                d = result6.derivation
                if (node == null) {
                  node = result6.node
                }
                result = result6
                info.join(result6, false)
                if (result.node == null) {
                  node = backup12
                  d = backup13
                  val backup14 = node?.copy()
                  val backup15 = d
                  
                  val result7 = d.dvOptionalExpression
                  d = result7.derivation
                  if (node == null) {
                    node = result7.node
                  }
                  result = result7
                  info.join(result7, false)
                  if (result.node == null) {
                    node = backup14
                    d = backup15
                    val backup16 = node?.copy()
                    val backup17 = d
                    
                    val result8 = d.dvRangeExpression
                    d = result8.derivation
                    if (node == null) {
                      node = result8.node
                    }
                    result = result8
                    info.join(result8, false)
                    if (result.node == null) {
                      node = backup16
                      d = backup17
                      val backup18 = node?.copy()
                      val backup19 = d
                      
                      val result9 = d.dvRuleReferenceExpression
                      d = result9.derivation
                      if (node == null) {
                        node = result9.node
                      }
                      result = result9
                      info.join(result9, false)
                      if (result.node == null) {
                        node = backup18
                        d = backup19
                        val backup20 = node?.copy()
                        val backup21 = d
                        
                        val result10 = d.dvSequenceExpression
                        d = result10.derivation
                        if (node == null) {
                          node = result10.node
                        }
                        result = result10
                        info.join(result10, false)
                        if (result.node == null) {
                          node = backup20
                          d = backup21
                          val backup22 = node?.copy()
                          val backup23 = d
                          
                          val result11 = d.dvGroupExpression
                          d = result11.derivation
                          if (node == null) {
                            node = result11.node
                          }
                          result = result11
                          info.join(result11, false)
                          if (result.node == null) {
                            node = backup22
                            d = backup23
                            val backup24 = node?.copy()
                            val backup25 = d
                            
                            val result12 = d.dvTerminalExpression
                            d = result12.derivation
                            if (node == null) {
                              node = result12.node
                            }
                            result = result12
                            info.join(result12, false)
                            if (result.node == null) {
                              node = backup24
                              d = backup25
                              val backup26 = node?.copy()
                              val backup27 = d
                              
                              val result13 = d.dvZeroOrMoreExpression
                              d = result13.derivation
                              if (node == null) {
                                node = result13.node
                              }
                              result = result13
                              info.join(result13, false)
                              if (result.node == null) {
                                node = backup26
                                d = backup27
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new Expression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class ChoiceExpressionRule {

  /**
   * ChoiceExpression[Expression] <- SequenceExpression ( &'/' {ChoiceExpression.choices+=current} ('/' _ choices+=SequenceExpression)* )? ; 
   */
  package static def Result<? extends Expression> matchChoiceExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 = d.dvSequenceExpression
    d = result0.derivation
    if (node == null) {
      node = result0.node
    }
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // (\u000a                                  &'/' {ChoiceExpression.choices+=current} \u000a                                  ('/' _ choices+=SequenceExpression)* \u000a                                )?\u000a
      val backup0 = node?.copy()
      val backup1 = d
      
      val backup2 = node?.copy()
      val backup3 = d
      val result1 =  d.__terminal('/')
      d = result1.derivation
      result = result1
      info.join(result1, true)
      node = backup2
      d = backup3
      if (result.node != null) {
        result = CONTINUE
        info.join(result, true)
      } else {
        result = BREAK
        info.join(result, true)
      }
      
      if (result.node != null) {
        val current = node
        node = new ChoiceExpression()
        (node as ChoiceExpression).add(current)
        result = CONTINUE
      }
      
      if (result.node != null) {
        // ('/' _ choices+=SequenceExpression)* \u000a                                
        var backup4 = node?.copy()
        var backup5 = d
        
        do {
          val result2 =  d.__terminal('/')
          d = result2.derivation
          result = result2
          info.join(result2, false)
          
          if (result.node != null) {
            val result3 = d.dv_
            d = result3.derivation
            result = result3
            info.join(result3, false)
          }
          
          if (result.node != null) {
            // choices+=SequenceExpression
            val result4 = d.dvSequenceExpression
            d = result4.derivation
            result = result4
            info.join(result4, false)
            if (result.node != null) {
              if (node == null) {
                node = new ChoiceExpression
              }
              (node as ChoiceExpression).add(result4.node)
            }
          }
          if (result.node != null) {
            backup4 = node?.copy()
            backup5 = d
          }
        } while (result.node != null)
        node = backup4
        d = backup5
        result = CONTINUE
        info.join(result, false)
      }
      if (result.node == null) {
        node = backup0
        d = backup1
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new ChoiceExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class SequenceExpressionRule {

  /**
   * SequenceExpression[Expression] <- SequenceExpressionExpressions _ ( &SequenceExpressionExpressions {SequenceExpression.expressions+=current} expressions+=SequenceExpressionExpressions _ )* ; 
   */
  package static def Result<? extends Expression> matchSequenceExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 = d.dvSequenceExpressionExpressions
    d = result0.derivation
    if (node == null) {
      node = result0.node
    }
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // (\u000a                                    &SequenceExpressionExpressions\u000a                                    {SequenceExpression.expressions+=current}\u000a                                    expressions+=SequenceExpressionExpressions\u000a                                    _\u000a                                  )*\u000a
      var backup0 = node?.copy()
      var backup1 = d
      
      do {
        val backup2 = node?.copy()
        val backup3 = d
        val result2 = d.dvSequenceExpressionExpressions
        d = result2.derivation
        if (node == null) {
          node = result2.node
        }
        result = result2
        info.join(result2, true)
        node = backup2
        d = backup3
        if (result.node != null) {
          result = CONTINUE
          info.join(result, true)
        } else {
          result = BREAK
          info.join(result, true)
        }
        
        if (result.node != null) {
          val current = node
          node = new SequenceExpression()
          (node as SequenceExpression).add(current)
          result = CONTINUE
        }
        
        if (result.node != null) {
          // expressions+=SequenceExpressionExpressions\u000a                                    
          val result3 = d.dvSequenceExpressionExpressions
          d = result3.derivation
          result = result3
          info.join(result3, false)
          if (result.node != null) {
            if (node == null) {
              node = new SequenceExpression
            }
            (node as SequenceExpression).add(result3.node)
          }
        }
        
        if (result.node != null) {
          val result4 = d.dv_
          d = result4.derivation
          result = result4
          info.join(result4, false)
        }
        if (result.node != null) {
          backup0 = node?.copy()
          backup1 = d
        }
      } while (result.node != null)
      node = backup0
      d = backup1
      result = CONTINUE
      info.join(result, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new SequenceExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class SequenceExpressionExpressionsRule {

  /**
   * SequenceExpressionExpressions[Expression] <- ActionExpression / AndPredicateExpression / NotPredicateExpression / OneOrMoreExpression / ZeroOrMoreExpression / OptionalExpression / AssignableExpression ; 
   */
  package static def Result<? extends Expression> matchSequenceExpressionExpressions(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // ActionExpression\u000a                                            / AndPredicateExpression\u000a                                            / NotPredicateExpression\u000a                                            / OneOrMoreExpression\u000a                                            / ZeroOrMoreExpression\u000a                                            / OptionalExpression\u000a                                            / AssignableExpression\u000a
    val backup0 = node?.copy()
    val backup1 = d
    
    val result0 = d.dvActionExpression
    d = result0.derivation
    if (node == null) {
      node = result0.node
    }
    result = result0
    info.join(result0, false)
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result1 = d.dvAndPredicateExpression
      d = result1.derivation
      if (node == null) {
        node = result1.node
      }
      result = result1
      info.join(result1, false)
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result2 = d.dvNotPredicateExpression
        d = result2.derivation
        if (node == null) {
          node = result2.node
        }
        result = result2
        info.join(result2, false)
        if (result.node == null) {
          node = backup4
          d = backup5
          val backup6 = node?.copy()
          val backup7 = d
          
          val result3 = d.dvOneOrMoreExpression
          d = result3.derivation
          if (node == null) {
            node = result3.node
          }
          result = result3
          info.join(result3, false)
          if (result.node == null) {
            node = backup6
            d = backup7
            val backup8 = node?.copy()
            val backup9 = d
            
            val result4 = d.dvZeroOrMoreExpression
            d = result4.derivation
            if (node == null) {
              node = result4.node
            }
            result = result4
            info.join(result4, false)
            if (result.node == null) {
              node = backup8
              d = backup9
              val backup10 = node?.copy()
              val backup11 = d
              
              val result5 = d.dvOptionalExpression
              d = result5.derivation
              if (node == null) {
                node = result5.node
              }
              result = result5
              info.join(result5, false)
              if (result.node == null) {
                node = backup10
                d = backup11
                val backup12 = node?.copy()
                val backup13 = d
                
                val result6 = d.dvAssignableExpression
                d = result6.derivation
                if (node == null) {
                  node = result6.node
                }
                result = result6
                info.join(result6, false)
                if (result.node == null) {
                  node = backup12
                  d = backup13
                }
              }
            }
          }
        }
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new SequenceExpressionExpressions()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class ActionExpressionRule {

  /**
   * ActionExpression[Expression] <- '{' _ type=ID _ ('.' property=ID _ op=ActionOperator _ 'current' _)? '}' _; 
   */
  package static def Result<? extends Expression> matchActionExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('{')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // type=ID 
      val result2 = d.dvID
      d = result2.derivation
      result = result2
      info.join(result2, false)
      if (result.node != null) {
        if (node == null) {
          node = new ActionExpression
        }
        (node as ActionExpression).setType(result2.node)
      }
    }
    
    if (result.node != null) {
      val result3 = d.dv_
      d = result3.derivation
      result = result3
      info.join(result3, false)
    }
    
    if (result.node != null) {
      // ('.' property=ID _ op=ActionOperator _ 'current' _)? 
      val backup0 = node?.copy()
      val backup1 = d
      
      val result4 =  d.__terminal('.')
      d = result4.derivation
      result = result4
      info.join(result4, false)
      
      if (result.node != null) {
        // property=ID 
        val result5 = d.dvID
        d = result5.derivation
        result = result5
        info.join(result5, false)
        if (result.node != null) {
          if (node == null) {
            node = new ActionExpression
          }
          (node as ActionExpression).setProperty(result5.node)
        }
      }
      
      if (result.node != null) {
        val result6 = d.dv_
        d = result6.derivation
        result = result6
        info.join(result6, false)
      }
      
      if (result.node != null) {
        // op=ActionOperator 
        val result7 = d.dvActionOperator
        d = result7.derivation
        result = result7
        info.join(result7, false)
        if (result.node != null) {
          if (node == null) {
            node = new ActionExpression
          }
          (node as ActionExpression).setOp(result7.node)
        }
      }
      
      if (result.node != null) {
        val result8 = d.dv_
        d = result8.derivation
        result = result8
        info.join(result8, false)
      }
      
      if (result.node != null) {
        val result9 =  d.__terminal('current')
        d = result9.derivation
        result = result9
        info.join(result9, false)
      }
      
      if (result.node != null) {
        val result10 = d.dv_
        d = result10.derivation
        result = result10
        info.join(result10, false)
      }
      if (result.node == null) {
        node = backup0
        d = backup1
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    if (result.node != null) {
      val result11 =  d.__terminal('}')
      d = result11.derivation
      result = result11
      info.join(result11, false)
    }
    
    if (result.node != null) {
      val result12 = d.dv_
      d = result12.derivation
      result = result12
      info.join(result12, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new ActionExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class ActionOperatorRule {

  /**
   * ActionOperator <- multi?='+=' / single?='='; 
   */
  package static def Result<? extends ActionOperator> matchActionOperator(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var ActionOperator node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // multi?='+=' / single?='='
    val backup0 = node?.copy()
    val backup1 = d
    
    // multi?='+=' 
    val result0 =  d.__terminal('+=')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new ActionOperator
      }
      node.setMulti(result0.node != null)
    }
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      // single?='='
      val result1 =  d.__terminal('=')
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new ActionOperator
        }
        node.setSingle(result1.node != null)
      }
      if (result.node == null) {
        node = backup2
        d = backup3
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new ActionOperator()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<ActionOperator>(node, d, result.info)
    }
    return new Result<ActionOperator>(null, derivation, result.info)
  }
  
  
}
package class AndPredicateExpressionRule {

  /**
   * AndPredicateExpression[Expression] <- '&' _ expr=AssignableExpression; 
   */
  package static def Result<? extends Expression> matchAndPredicateExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('&')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // expr=AssignableExpression
      val result2 = d.dvAssignableExpression
      d = result2.derivation
      result = result2
      info.join(result2, false)
      if (result.node != null) {
        if (node == null) {
          node = new AndPredicateExpression
        }
        (node as AndPredicateExpression).setExpr(result2.node)
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new AndPredicateExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class NotPredicateExpressionRule {

  /**
   * NotPredicateExpression[Expression] <- '!' _ expr=AssignableExpression; 
   */
  package static def Result<? extends Expression> matchNotPredicateExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('!')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // expr=AssignableExpression
      val result2 = d.dvAssignableExpression
      d = result2.derivation
      result = result2
      info.join(result2, false)
      if (result.node != null) {
        if (node == null) {
          node = new NotPredicateExpression
        }
        (node as NotPredicateExpression).setExpr(result2.node)
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new NotPredicateExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class OneOrMoreExpressionRule {

  /**
   * OneOrMoreExpression[Expression] <- expr=AssignableExpression '+' _; 
   */
  package static def Result<? extends Expression> matchOneOrMoreExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // expr=AssignableExpression 
    val result0 = d.dvAssignableExpression
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new OneOrMoreExpression
      }
      (node as OneOrMoreExpression).setExpr(result0.node)
    }
    
    if (result.node != null) {
      val result1 =  d.__terminal('+')
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      val result2 = d.dv_
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new OneOrMoreExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class ZeroOrMoreExpressionRule {

  /**
   * ZeroOrMoreExpression[Expression] <- expr=AssignableExpression '*' _; 
   */
  package static def Result<? extends Expression> matchZeroOrMoreExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // expr=AssignableExpression 
    val result0 = d.dvAssignableExpression
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new ZeroOrMoreExpression
      }
      (node as ZeroOrMoreExpression).setExpr(result0.node)
    }
    
    if (result.node != null) {
      val result1 =  d.__terminal('*')
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      val result2 = d.dv_
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new ZeroOrMoreExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class OptionalExpressionRule {

  /**
   * OptionalExpression[Expression] <- expr=AssignableExpression '?' _; 
   */
  package static def Result<? extends Expression> matchOptionalExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // expr=AssignableExpression 
    val result0 = d.dvAssignableExpression
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new OptionalExpression
      }
      (node as OptionalExpression).setExpr(result0.node)
    }
    
    if (result.node != null) {
      val result1 =  d.__terminal('?')
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      val result2 = d.dv_
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new OptionalExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class AssignableExpressionRule {

  /**
   * AssignableExpression[Expression] <- ( property=ID _ op=AssignmentOperator _ expr=AssignableExpressionExpressions / AssignableExpressionExpressions ) _ ; 
   */
  package static def Result<? extends Expression> matchAssignableExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // property=ID _ op=AssignmentOperator _ expr=AssignableExpressionExpressions\u000a  / AssignableExpressionExpressions\u000a  
    val backup0 = node?.copy()
    val backup1 = d
    
    // property=ID 
    val result0 = d.dvID
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new AssignableExpression
      }
      (node as AssignableExpression).setProperty(result0.node)
    }
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // op=AssignmentOperator 
      val result2 = d.dvAssignmentOperator
      d = result2.derivation
      result = result2
      info.join(result2, false)
      if (result.node != null) {
        if (node == null) {
          node = new AssignableExpression
        }
        (node as AssignableExpression).setOp(result2.node)
      }
    }
    
    if (result.node != null) {
      val result3 = d.dv_
      d = result3.derivation
      result = result3
      info.join(result3, false)
    }
    
    if (result.node != null) {
      // expr=AssignableExpressionExpressions\u000a  
      val result4 = d.dvAssignableExpressionExpressions
      d = result4.derivation
      result = result4
      info.join(result4, false)
      if (result.node != null) {
        if (node == null) {
          node = new AssignableExpression
        }
        (node as AssignableExpression).setExpr(result4.node)
      }
    }
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result5 = d.dvAssignableExpressionExpressions
      d = result5.derivation
      if (node == null) {
        node = result5.node
      }
      result = result5
      info.join(result5, false)
      if (result.node == null) {
        node = backup2
        d = backup3
      }
    }
    
    if (result.node != null) {
      val result6 = d.dv_
      d = result6.derivation
      result = result6
      info.join(result6, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new AssignableExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class AssignableExpressionExpressionsRule {

  /**
   * AssignableExpressionExpressions[Expression] <- GroupExpression / RangeExpression / TerminalExpression / AnyCharExpression / RuleReferenceExpression ; 
   */
  package static def Result<? extends Expression> matchAssignableExpressionExpressions(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // GroupExpression\u000a                                              / RangeExpression\u000a                                              / TerminalExpression\u000a                                              / AnyCharExpression\u000a                                              / RuleReferenceExpression\u000a
    val backup0 = node?.copy()
    val backup1 = d
    
    val result0 = d.dvGroupExpression
    d = result0.derivation
    if (node == null) {
      node = result0.node
    }
    result = result0
    info.join(result0, false)
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result1 = d.dvRangeExpression
      d = result1.derivation
      if (node == null) {
        node = result1.node
      }
      result = result1
      info.join(result1, false)
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result2 = d.dvTerminalExpression
        d = result2.derivation
        if (node == null) {
          node = result2.node
        }
        result = result2
        info.join(result2, false)
        if (result.node == null) {
          node = backup4
          d = backup5
          val backup6 = node?.copy()
          val backup7 = d
          
          val result3 = d.dvAnyCharExpression
          d = result3.derivation
          if (node == null) {
            node = result3.node
          }
          result = result3
          info.join(result3, false)
          if (result.node == null) {
            node = backup6
            d = backup7
            val backup8 = node?.copy()
            val backup9 = d
            
            val result4 = d.dvRuleReferenceExpression
            d = result4.derivation
            if (node == null) {
              node = result4.node
            }
            result = result4
            info.join(result4, false)
            if (result.node == null) {
              node = backup8
              d = backup9
            }
          }
        }
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new AssignableExpressionExpressions()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class AssignmentOperatorRule {

  /**
   * AssignmentOperator <- (single?='=' / multi?='+=' / bool?='?=') _; 
   */
  package static def Result<? extends AssignmentOperator> matchAssignmentOperator(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var AssignmentOperator node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // single?='=' / multi?='+=' / bool?='?='
    val backup0 = node?.copy()
    val backup1 = d
    
    // single?='=' 
    val result0 =  d.__terminal('=')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new AssignmentOperator
      }
      node.setSingle(result0.node != null)
    }
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      // multi?='+=' 
      val result1 =  d.__terminal('+=')
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new AssignmentOperator
        }
        node.setMulti(result1.node != null)
      }
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        // bool?='?='
        val result2 =  d.__terminal('?=')
        d = result2.derivation
        result = result2
        info.join(result2, false)
        if (result.node != null) {
          if (node == null) {
            node = new AssignmentOperator
          }
          node.setBool(result2.node != null)
        }
        if (result.node == null) {
          node = backup4
          d = backup5
        }
      }
    }
    
    if (result.node != null) {
      val result3 = d.dv_
      d = result3.derivation
      result = result3
      info.join(result3, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new AssignmentOperator()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<AssignmentOperator>(node, d, result.info)
    }
    return new Result<AssignmentOperator>(null, derivation, result.info)
  }
  
  
}
package class GroupExpressionRule {

  /**
   * GroupExpression[Expression] <- '(' _ expr=ChoiceExpression ')' _; 
   */
  package static def Result<? extends Expression> matchGroupExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('(')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    if (result.node != null) {
      // expr=ChoiceExpression 
      val result2 = d.dvChoiceExpression
      d = result2.derivation
      result = result2
      info.join(result2, false)
      if (result.node != null) {
        if (node == null) {
          node = new GroupExpression
        }
        (node as GroupExpression).setExpr(result2.node)
      }
    }
    
    if (result.node != null) {
      val result3 =  d.__terminal(')')
      d = result3.derivation
      result = result3
      info.join(result3, false)
    }
    
    if (result.node != null) {
      val result4 = d.dv_
      d = result4.derivation
      result = result4
      info.join(result4, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new GroupExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class RangeExpressionRule {

  /**
   * RangeExpression[Expression] <- '[' dash='-'? (!']' ranges+=(MinMaxRange / CharRange))* ']' _; 
   */
  package static def Result<? extends Expression> matchRangeExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('[')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // dash='-'? 
      val backup0 = node?.copy()
      val backup1 = d
      
      // dash='-'
      val result1 =  d.__terminal('-')
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new RangeExpression
        }
        (node as RangeExpression).setDash(result1.node)
      }
      if (result.node == null) {
        node = backup0
        d = backup1
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    if (result.node != null) {
      // (!']' ranges+=(MinMaxRange / CharRange))* 
      var backup2 = node?.copy()
      var backup3 = d
      
      do {
        val backup4 = node?.copy()
        val backup5 = d
        val result2 =  d.__terminal(']')
        d = result2.derivation
        result = result2
        info.join(result2, true)
        node = backup4
        d = backup5
        if (result.node != null) {
          result = BREAK
          info.join(result, true)
        } else {
          result = CONTINUE
          info.join(result, true)
        }
        
        if (result.node != null) {
          // ranges+=(MinMaxRange / CharRange)
          val result5 = d.sub0MatchRangeExpression(parser)
          d = result5.derivation
          result = result5
          info.join(result5, false)
          if (result.node != null) {
            if (node == null) {
              node = new RangeExpression
            }
            (node as RangeExpression).add(result5.node)
          }
        }
        if (result.node != null) {
          backup2 = node?.copy()
          backup3 = d
        }
      } while (result.node != null)
      node = backup2
      d = backup3
      result = CONTINUE
      info.join(result, false)
    }
    
    if (result.node != null) {
      val result6 =  d.__terminal(']')
      d = result6.derivation
      result = result6
      info.join(result6, false)
    }
    
    if (result.node != null) {
      val result7 = d.dv_
      d = result7.derivation
      result = result7
      info.join(result7, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new RangeExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  private static def Result<? extends Node> sub0MatchRangeExpression(Derivation derivation, Parser parser) {
      var Result<? extends Node> result = null
      var Node node = null
      var d = derivation
      val ParseInfo info = new ParseInfo(derivation.index)
      
      // MinMaxRange / CharRange
      val backup6 = node?.copy()
      val backup7 = d
      
      val result3 = d.dvMinMaxRange
      d = result3.derivation
      result = result3
      info.join(result3, false)
      if (result.node == null) {
        node = backup6
        d = backup7
        val backup8 = node?.copy()
        val backup9 = d
        
        val result4 = d.dvCharRange
        d = result4.derivation
        result = result4
        info.join(result4, false)
        if (result.node == null) {
          node = backup8
          d = backup9
        }
      }
      
      result.info = info
      return result
  }
  
}
package class MinMaxRangeRule {

  /**
   * MinMaxRange <- !'-' min=. '-' !'-' max=.; 
   */
  package static def Result<? extends MinMaxRange> matchMinMaxRange(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var MinMaxRange node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val backup0 = node?.copy()
    val backup1 = d
    val result0 =  d.__terminal('-')
    d = result0.derivation
    result = result0
    info.join(result0, true)
    node = backup0
    d = backup1
    if (result.node != null) {
      result = BREAK
      info.join(result, true)
    } else {
      result = CONTINUE
      info.join(result, true)
    }
    
    if (result.node != null) {
      // min=. 
      // .
      val result1 =  d.__any()
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new MinMaxRange
        }
        node.setMin(result1.node)
      }
    }
    
    if (result.node != null) {
      val result2 =  d.__terminal('-')
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    if (result.node != null) {
      val backup2 = node?.copy()
      val backup3 = d
      val result3 =  d.__terminal('-')
      d = result3.derivation
      result = result3
      info.join(result3, true)
      node = backup2
      d = backup3
      if (result.node != null) {
        result = BREAK
        info.join(result, true)
      } else {
        result = CONTINUE
        info.join(result, true)
      }
    }
    
    if (result.node != null) {
      // max=.
      // .
      val result4 =  d.__any()
      d = result4.derivation
      result = result4
      info.join(result4, false)
      if (result.node != null) {
        if (node == null) {
          node = new MinMaxRange
        }
        node.setMax(result4.node)
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new MinMaxRange()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<MinMaxRange>(node, d, result.info)
    }
    return new Result<MinMaxRange>(null, derivation, result.info)
  }
  
  
}
package class CharRangeRule {

  /**
   * CharRange <- '\\\\' char=']' / '\\\\' char='\\\\' / !'-' char=. ; 
   */
  package static def Result<? extends CharRange> matchCharRange(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var CharRange node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // '\\\\' char=']'\u000a            / '\\\\' char='\\\\'\u000a            / !'-' char=.\u000a
    val backup0 = node?.copy()
    val backup1 = d
    
    val result0 =  d.__terminal('\\')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // char=']'\u000a            
      val result1 =  d.__terminal(']')
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new CharRange
        }
        node.setChar(result1.node)
      }
    }
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result2 =  d.__terminal('\\')
      d = result2.derivation
      result = result2
      info.join(result2, false)
      
      if (result.node != null) {
        // char='\\\\'\u000a            
        val result3 =  d.__terminal('\\')
        d = result3.derivation
        result = result3
        info.join(result3, false)
        if (result.node != null) {
          if (node == null) {
            node = new CharRange
          }
          node.setChar(result3.node)
        }
      }
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val backup6 = node?.copy()
        val backup7 = d
        val result4 =  d.__terminal('-')
        d = result4.derivation
        result = result4
        info.join(result4, true)
        node = backup6
        d = backup7
        if (result.node != null) {
          result = BREAK
          info.join(result, true)
        } else {
          result = CONTINUE
          info.join(result, true)
        }
        
        if (result.node != null) {
          // char=.\u000a
          // .
          val result5 =  d.__any()
          d = result5.derivation
          result = result5
          info.join(result5, false)
          if (result.node != null) {
            if (node == null) {
              node = new CharRange
            }
            node.setChar(result5.node)
          }
        }
        if (result.node == null) {
          node = backup4
          d = backup5
        }
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new CharRange()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<CharRange>(node, d, result.info)
    }
    return new Result<CharRange>(null, derivation, result.info)
  }
  
  
}
package class AnyCharExpressionRule {

  /**
   * AnyCharExpression[Expression] <- char='.'; 
   */
  package static def Result<? extends Expression> matchAnyCharExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // char='.'
    val result0 =  d.__terminal('.')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new AnyCharExpression
      }
      (node as AnyCharExpression).setChar(result0.node)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new AnyCharExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class RuleReferenceExpressionRule {

  /**
   * RuleReferenceExpression[Expression] <- name=ID _; 
   */
  package static def Result<? extends Expression> matchRuleReferenceExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // name=ID 
    val result0 = d.dvID
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node != null) {
      if (node == null) {
        node = new RuleReferenceExpression
      }
      (node as RuleReferenceExpression).setName(result0.node)
    }
    
    if (result.node != null) {
      val result1 = d.dv_
      d = result1.derivation
      result = result1
      info.join(result1, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new RuleReferenceExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class TerminalExpressionRule {

  /**
   * TerminalExpression[Expression] <- '\\'' value=InTerminalChar? '\\'' _; 
   */
  package static def Result<? extends Expression> matchTerminalExpression(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Expression node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('\'')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // value=InTerminalChar? 
      val backup0 = node?.copy()
      val backup1 = d
      
      // value=InTerminalChar
      val result1 = d.dvInTerminalChar
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node != null) {
        if (node == null) {
          node = new TerminalExpression
        }
        (node as TerminalExpression).setValue(result1.node)
      }
      if (result.node == null) {
        node = backup0
        d = backup1
        result = CONTINUE
        info.join(result, false)
      }
    }
    
    if (result.node != null) {
      val result2 =  d.__terminal('\'')
      d = result2.derivation
      result = result2
      info.join(result2, false)
    }
    
    if (result.node != null) {
      val result3 = d.dv_
      d = result3.derivation
      result = result3
      info.join(result3, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new TerminalExpression()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Expression>(node, d, result.info)
    }
    return new Result<Expression>(null, derivation, result.info)
  }
  
  
}
package class InTerminalCharRule {

  /**
   * InTerminalChar <- ('\\\\' '\\'' / '\\\\' '\\\\' / !'\\'' .)+; // -- Primitives --------------------------------------------------------------- 
   */
  package static def Result<? extends InTerminalChar> matchInTerminalChar(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var InTerminalChar node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // ('\\\\' '\\'' / '\\\\' '\\\\' / !'\\'' .)+
    var backup0 = node?.copy()
    var backup1 = d
    var loop0 = false
    
    do {
      // '\\\\' '\\'' / '\\\\' '\\\\' / !'\\'' .
      val backup2 = node?.copy()
      val backup3 = d
      
      val result0 =  d.__terminal('\\')
      d = result0.derivation
      result = result0
      info.join(result0, false)
      
      if (result.node != null) {
        val result1 =  d.__terminal('\'')
        d = result1.derivation
        result = result1
        info.join(result1, false)
      }
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result2 =  d.__terminal('\\')
        d = result2.derivation
        result = result2
        info.join(result2, false)
        
        if (result.node != null) {
          val result3 =  d.__terminal('\\')
          d = result3.derivation
          result = result3
          info.join(result3, false)
        }
        if (result.node == null) {
          node = backup4
          d = backup5
          val backup6 = node?.copy()
          val backup7 = d
          
          val backup8 = node?.copy()
          val backup9 = d
          val result4 =  d.__terminal('\'')
          d = result4.derivation
          result = result4
          info.join(result4, true)
          node = backup8
          d = backup9
          if (result.node != null) {
            result = BREAK
            info.join(result, true)
          } else {
            result = CONTINUE
            info.join(result, true)
          }
          
          if (result.node != null) {
            // .
            val result5 =  d.__any()
            d = result5.derivation
            result = result5
            info.join(result5, false)
          }
          if (result.node == null) {
            node = backup6
            d = backup7
          }
        }
      }
      
      if (result.node != null) {
        loop0 = true
        backup0 = node?.copy()
        backup1 = d
      }
    } while(result.node != null)
    if (!loop0) {
      node = backup0
      d = backup1
    } else {
      result = CONTINUE
      info.join(result, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new InTerminalChar()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<InTerminalChar>(node, d, result.info)
    }
    return new Result<InTerminalChar>(null, derivation, result.info)
  }
  
  
}
package class IDRule {

  /**
   * ID <- [a-zA-Z_] [a-zA-Z0-9_]*; 
   */
  package static def Result<? extends ID> matchID(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var ID node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // [a-zA-Z_] 
    val result0 = d.__oneOfThese(
      ('a'..'z') + ('A'..'Z') + '_'
      )
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // [a-zA-Z0-9_]*
      var backup0 = node?.copy()
      var backup1 = d
      
      do {
        // [a-zA-Z0-9_]
        val result1 = d.__oneOfThese(
          ('a'..'z') + ('A'..'Z') + ('0'..'9') + '_'
          )
        d = result1.derivation
        result = result1
        info.join(result1, false)
        if (result.node != null) {
          backup0 = node?.copy()
          backup1 = d
        }
      } while (result.node != null)
      node = backup0
      d = backup1
      result = CONTINUE
      info.join(result, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new ID()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<ID>(node, d, result.info)
    }
    return new Result<ID>(null, derivation, result.info)
  }
  
  
}
package class EOIRule {

  /**
   * EOI <- !(.); // -- Whitespaces and Comments ------------------------------------------------- 
   */
  package static def Result<? extends EOI> matchEOI(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var EOI node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val backup0 = node?.copy()
    val backup1 = d
    // .
    val result0 =  d.__any()
    d = result0.derivation
    result = result0
    info.join(result0, true)
    node = backup0
    d = backup1
    if (result.node != null) {
      result = BREAK
      info.join(result, true)
    } else {
      result = CONTINUE
      info.join(result, true)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new EOI()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<EOI>(node, d, result.info)
    }
    return new Result<EOI>(null, derivation, result.info)
  }
  
  
}
package class CommentRule {

  /**
   * Comment <- '//' (!('\\r'? '\\n') .)* _; 
   */
  package static def Result<? extends Comment> matchComment(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var Comment node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    val result0 =  d.__terminal('//')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    
    if (result.node != null) {
      // (!('\\r'? '\\n') .)* 
      var backup0 = node?.copy()
      var backup1 = d
      
      do {
        val backup2 = node?.copy()
        val backup3 = d
        // '\\r'? 
        val backup4 = node?.copy()
        val backup5 = d
        
        val result1 =  d.__terminal('\r')
        d = result1.derivation
        result = result1
        info.join(result1, true)
        if (result.node == null) {
          node = backup4
          d = backup5
          result = CONTINUE
          info.join(result, true)
        }
        
        if (result.node != null) {
          val result2 =  d.__terminal('\n')
          d = result2.derivation
          result = result2
          info.join(result2, true)
        }
        node = backup2
        d = backup3
        if (result.node != null) {
          result = BREAK
          info.join(result, true)
        } else {
          result = CONTINUE
          info.join(result, true)
        }
        
        if (result.node != null) {
          // .
          val result3 =  d.__any()
          d = result3.derivation
          result = result3
          info.join(result3, false)
        }
        if (result.node != null) {
          backup0 = node?.copy()
          backup1 = d
        }
      } while (result.node != null)
      node = backup0
      d = backup1
      result = CONTINUE
      info.join(result, false)
    }
    
    if (result.node != null) {
      val result4 = d.dv_
      d = result4.derivation
      result = result4
      info.join(result4, false)
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new Comment()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<Comment>(node, d, result.info)
    }
    return new Result<Comment>(null, derivation, result.info)
  }
  
  
}
package class WSRule {

  /**
   * WS <- ' ' / '\\n' / '\\t' / '\\r'; 
   */
  package static def Result<? extends WS> matchWS(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var WS node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // ' ' / '\\n' / '\\t' / '\\r'
    val backup0 = node?.copy()
    val backup1 = d
    
    val result0 =  d.__terminal(' ')
    d = result0.derivation
    result = result0
    info.join(result0, false)
    if (result.node == null) {
      node = backup0
      d = backup1
      val backup2 = node?.copy()
      val backup3 = d
      
      val result1 =  d.__terminal('\n')
      d = result1.derivation
      result = result1
      info.join(result1, false)
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result2 =  d.__terminal('\t')
        d = result2.derivation
        result = result2
        info.join(result2, false)
        if (result.node == null) {
          node = backup4
          d = backup5
          val backup6 = node?.copy()
          val backup7 = d
          
          val result3 =  d.__terminal('\r')
          d = result3.derivation
          result = result3
          info.join(result3, false)
          if (result.node == null) {
            node = backup6
            d = backup7
          }
        }
      }
    }
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new WS()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<WS>(node, d, result.info)
    }
    return new Result<WS>(null, derivation, result.info)
  }
  
  
}
package class _Rule {

  /**
   * _ <- (Comment / WS)*; 
   */
  package static def Result<? extends _> match_(Parser parser, Derivation derivation) {
    var Result<?> result = null
    var _ node = null
    var d = derivation
    val ParseInfo info = new ParseInfo(derivation.index)
    
    // (Comment / WS)*
    var backup0 = node?.copy()
    var backup1 = d
    
    do {
      // Comment / WS
      val backup2 = node?.copy()
      val backup3 = d
      
      val result0 = d.dvComment
      d = result0.derivation
      result = result0
      info.join(result0, false)
      if (result.node == null) {
        node = backup2
        d = backup3
        val backup4 = node?.copy()
        val backup5 = d
        
        val result1 = d.dvWS
        d = result1.derivation
        result = result1
        info.join(result1, false)
        if (result.node == null) {
          node = backup4
          d = backup5
        }
      }
      if (result.node != null) {
        backup0 = node?.copy()
        backup1 = d
      }
    } while (result.node != null)
    node = backup0
    d = backup1
    result = CONTINUE
    info.join(result, false)
    
    result.info = info
    if (result.node != null) {
      if (node == null) {
        node = new _()
      }
      node.index = derivation.index
      node.parsed = new String(parser.chars, derivation.index, d.index - derivation.index);
      return new Result<_>(node, d, result.info)
    }
    return new Result<_>(null, derivation, result.info)
  }
  
  
}
  
package class Derivation {
  
  Parser parser
  
  int idx
  
  val (Derivation)=>Result<Character> dvfChar
  
  Result<? extends Djeypeg> dvDjeypeg
  Result<? extends Rule> dvRule
  Result<? extends Body> dvBody
  Result<? extends Expression> dvExpression
  Result<? extends Expression> dvChoiceExpression
  Result<? extends Expression> dvSequenceExpression
  Result<? extends Expression> dvSequenceExpressionExpressions
  Result<? extends Expression> dvActionExpression
  Result<? extends ActionOperator> dvActionOperator
  Result<? extends Expression> dvAndPredicateExpression
  Result<? extends Expression> dvNotPredicateExpression
  Result<? extends Expression> dvOneOrMoreExpression
  Result<? extends Expression> dvZeroOrMoreExpression
  Result<? extends Expression> dvOptionalExpression
  Result<? extends Expression> dvAssignableExpression
  Result<? extends Expression> dvAssignableExpressionExpressions
  Result<? extends AssignmentOperator> dvAssignmentOperator
  Result<? extends Expression> dvGroupExpression
  Result<? extends Expression> dvRangeExpression
  Result<? extends MinMaxRange> dvMinMaxRange
  Result<? extends CharRange> dvCharRange
  Result<? extends Expression> dvAnyCharExpression
  Result<? extends Expression> dvRuleReferenceExpression
  Result<? extends Expression> dvTerminalExpression
  Result<? extends InTerminalChar> dvInTerminalChar
  Result<? extends ID> dvID
  Result<? extends EOI> dvEOI
  Result<? extends Comment> dvComment
  Result<? extends WS> dvWS
  Result<? extends _> dv_
  Result<Character> dvChar
  
  new(Parser parser, int idx, (Derivation)=>Result<Character> dvfChar) {
    this.parser = parser
    this.idx = idx
    this.dvfChar = dvfChar
  }
  
  def getIndex() {
    idx
  }
  
  def getDvDjeypeg() {
    if (dvDjeypeg == null) {
      val lr = new Result<Djeypeg>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'Djeypeg'"))
      dvDjeypeg = lr
      dvDjeypeg = DjeypegRule.matchDjeypeg(parser, this)
      if (lr.leftRecursive && dvDjeypeg.node != null) {
        growDvDjeypeg()
      }
    } if (dvDjeypeg.leftRecursive != null) {
      dvDjeypeg.setLeftRecursive()
    }
    return dvDjeypeg
  }
  
  private def growDvDjeypeg() {
    while(true) {
      val temp = DjeypegRule.matchDjeypeg(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvDjeypeg.derivation.idx) return
      else dvDjeypeg = temp
    }
  }
  
  def getDvRule() {
    if (dvRule == null) {
      val lr = new Result<Rule>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'Rule'"))
      dvRule = lr
      dvRule = RuleRule.matchRule(parser, this)
      if (lr.leftRecursive && dvRule.node != null) {
        growDvRule()
      }
    } if (dvRule.leftRecursive != null) {
      dvRule.setLeftRecursive()
    }
    return dvRule
  }
  
  private def growDvRule() {
    while(true) {
      val temp = RuleRule.matchRule(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvRule.derivation.idx) return
      else dvRule = temp
    }
  }
  
  def getDvBody() {
    if (dvBody == null) {
      val lr = new Result<Body>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'Body'"))
      dvBody = lr
      dvBody = BodyRule.matchBody(parser, this)
      if (lr.leftRecursive && dvBody.node != null) {
        growDvBody()
      }
    } if (dvBody.leftRecursive != null) {
      dvBody.setLeftRecursive()
    }
    return dvBody
  }
  
  private def growDvBody() {
    while(true) {
      val temp = BodyRule.matchBody(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvBody.derivation.idx) return
      else dvBody = temp
    }
  }
  
  def getDvExpression() {
    if (dvExpression == null) {
      val lr = new Result<Expression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'Expression'"))
      dvExpression = lr
      dvExpression = ExpressionRule.matchExpression(parser, this)
      if (lr.leftRecursive && dvExpression.node != null) {
        growDvExpression()
      }
    } if (dvExpression.leftRecursive != null) {
      dvExpression.setLeftRecursive()
    }
    return dvExpression
  }
  
  private def growDvExpression() {
    while(true) {
      val temp = ExpressionRule.matchExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvExpression.derivation.idx) return
      else dvExpression = temp
    }
  }
  
  def getDvChoiceExpression() {
    if (dvChoiceExpression == null) {
      val lr = new Result<ChoiceExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'ChoiceExpression'"))
      dvChoiceExpression = lr
      dvChoiceExpression = ChoiceExpressionRule.matchChoiceExpression(parser, this)
      if (lr.leftRecursive && dvChoiceExpression.node != null) {
        growDvChoiceExpression()
      }
    } if (dvChoiceExpression.leftRecursive != null) {
      dvChoiceExpression.setLeftRecursive()
    }
    return dvChoiceExpression
  }
  
  private def growDvChoiceExpression() {
    while(true) {
      val temp = ChoiceExpressionRule.matchChoiceExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvChoiceExpression.derivation.idx) return
      else dvChoiceExpression = temp
    }
  }
  
  def getDvSequenceExpression() {
    if (dvSequenceExpression == null) {
      val lr = new Result<SequenceExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'SequenceExpression'"))
      dvSequenceExpression = lr
      dvSequenceExpression = SequenceExpressionRule.matchSequenceExpression(parser, this)
      if (lr.leftRecursive && dvSequenceExpression.node != null) {
        growDvSequenceExpression()
      }
    } if (dvSequenceExpression.leftRecursive != null) {
      dvSequenceExpression.setLeftRecursive()
    }
    return dvSequenceExpression
  }
  
  private def growDvSequenceExpression() {
    while(true) {
      val temp = SequenceExpressionRule.matchSequenceExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvSequenceExpression.derivation.idx) return
      else dvSequenceExpression = temp
    }
  }
  
  def getDvSequenceExpressionExpressions() {
    if (dvSequenceExpressionExpressions == null) {
      val lr = new Result<SequenceExpressionExpressions>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'SequenceExpressionExpressions'"))
      dvSequenceExpressionExpressions = lr
      dvSequenceExpressionExpressions = SequenceExpressionExpressionsRule.matchSequenceExpressionExpressions(parser, this)
      if (lr.leftRecursive && dvSequenceExpressionExpressions.node != null) {
        growDvSequenceExpressionExpressions()
      }
    } if (dvSequenceExpressionExpressions.leftRecursive != null) {
      dvSequenceExpressionExpressions.setLeftRecursive()
    }
    return dvSequenceExpressionExpressions
  }
  
  private def growDvSequenceExpressionExpressions() {
    while(true) {
      val temp = SequenceExpressionExpressionsRule.matchSequenceExpressionExpressions(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvSequenceExpressionExpressions.derivation.idx) return
      else dvSequenceExpressionExpressions = temp
    }
  }
  
  def getDvActionExpression() {
    if (dvActionExpression == null) {
      val lr = new Result<ActionExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'ActionExpression'"))
      dvActionExpression = lr
      dvActionExpression = ActionExpressionRule.matchActionExpression(parser, this)
      if (lr.leftRecursive && dvActionExpression.node != null) {
        growDvActionExpression()
      }
    } if (dvActionExpression.leftRecursive != null) {
      dvActionExpression.setLeftRecursive()
    }
    return dvActionExpression
  }
  
  private def growDvActionExpression() {
    while(true) {
      val temp = ActionExpressionRule.matchActionExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvActionExpression.derivation.idx) return
      else dvActionExpression = temp
    }
  }
  
  def getDvActionOperator() {
    if (dvActionOperator == null) {
      val lr = new Result<ActionOperator>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'ActionOperator'"))
      dvActionOperator = lr
      dvActionOperator = ActionOperatorRule.matchActionOperator(parser, this)
      if (lr.leftRecursive && dvActionOperator.node != null) {
        growDvActionOperator()
      }
    } if (dvActionOperator.leftRecursive != null) {
      dvActionOperator.setLeftRecursive()
    }
    return dvActionOperator
  }
  
  private def growDvActionOperator() {
    while(true) {
      val temp = ActionOperatorRule.matchActionOperator(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvActionOperator.derivation.idx) return
      else dvActionOperator = temp
    }
  }
  
  def getDvAndPredicateExpression() {
    if (dvAndPredicateExpression == null) {
      val lr = new Result<AndPredicateExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'AndPredicateExpression'"))
      dvAndPredicateExpression = lr
      dvAndPredicateExpression = AndPredicateExpressionRule.matchAndPredicateExpression(parser, this)
      if (lr.leftRecursive && dvAndPredicateExpression.node != null) {
        growDvAndPredicateExpression()
      }
    } if (dvAndPredicateExpression.leftRecursive != null) {
      dvAndPredicateExpression.setLeftRecursive()
    }
    return dvAndPredicateExpression
  }
  
  private def growDvAndPredicateExpression() {
    while(true) {
      val temp = AndPredicateExpressionRule.matchAndPredicateExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvAndPredicateExpression.derivation.idx) return
      else dvAndPredicateExpression = temp
    }
  }
  
  def getDvNotPredicateExpression() {
    if (dvNotPredicateExpression == null) {
      val lr = new Result<NotPredicateExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'NotPredicateExpression'"))
      dvNotPredicateExpression = lr
      dvNotPredicateExpression = NotPredicateExpressionRule.matchNotPredicateExpression(parser, this)
      if (lr.leftRecursive && dvNotPredicateExpression.node != null) {
        growDvNotPredicateExpression()
      }
    } if (dvNotPredicateExpression.leftRecursive != null) {
      dvNotPredicateExpression.setLeftRecursive()
    }
    return dvNotPredicateExpression
  }
  
  private def growDvNotPredicateExpression() {
    while(true) {
      val temp = NotPredicateExpressionRule.matchNotPredicateExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvNotPredicateExpression.derivation.idx) return
      else dvNotPredicateExpression = temp
    }
  }
  
  def getDvOneOrMoreExpression() {
    if (dvOneOrMoreExpression == null) {
      val lr = new Result<OneOrMoreExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'OneOrMoreExpression'"))
      dvOneOrMoreExpression = lr
      dvOneOrMoreExpression = OneOrMoreExpressionRule.matchOneOrMoreExpression(parser, this)
      if (lr.leftRecursive && dvOneOrMoreExpression.node != null) {
        growDvOneOrMoreExpression()
      }
    } if (dvOneOrMoreExpression.leftRecursive != null) {
      dvOneOrMoreExpression.setLeftRecursive()
    }
    return dvOneOrMoreExpression
  }
  
  private def growDvOneOrMoreExpression() {
    while(true) {
      val temp = OneOrMoreExpressionRule.matchOneOrMoreExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvOneOrMoreExpression.derivation.idx) return
      else dvOneOrMoreExpression = temp
    }
  }
  
  def getDvZeroOrMoreExpression() {
    if (dvZeroOrMoreExpression == null) {
      val lr = new Result<ZeroOrMoreExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'ZeroOrMoreExpression'"))
      dvZeroOrMoreExpression = lr
      dvZeroOrMoreExpression = ZeroOrMoreExpressionRule.matchZeroOrMoreExpression(parser, this)
      if (lr.leftRecursive && dvZeroOrMoreExpression.node != null) {
        growDvZeroOrMoreExpression()
      }
    } if (dvZeroOrMoreExpression.leftRecursive != null) {
      dvZeroOrMoreExpression.setLeftRecursive()
    }
    return dvZeroOrMoreExpression
  }
  
  private def growDvZeroOrMoreExpression() {
    while(true) {
      val temp = ZeroOrMoreExpressionRule.matchZeroOrMoreExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvZeroOrMoreExpression.derivation.idx) return
      else dvZeroOrMoreExpression = temp
    }
  }
  
  def getDvOptionalExpression() {
    if (dvOptionalExpression == null) {
      val lr = new Result<OptionalExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'OptionalExpression'"))
      dvOptionalExpression = lr
      dvOptionalExpression = OptionalExpressionRule.matchOptionalExpression(parser, this)
      if (lr.leftRecursive && dvOptionalExpression.node != null) {
        growDvOptionalExpression()
      }
    } if (dvOptionalExpression.leftRecursive != null) {
      dvOptionalExpression.setLeftRecursive()
    }
    return dvOptionalExpression
  }
  
  private def growDvOptionalExpression() {
    while(true) {
      val temp = OptionalExpressionRule.matchOptionalExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvOptionalExpression.derivation.idx) return
      else dvOptionalExpression = temp
    }
  }
  
  def getDvAssignableExpression() {
    if (dvAssignableExpression == null) {
      val lr = new Result<AssignableExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'AssignableExpression'"))
      dvAssignableExpression = lr
      dvAssignableExpression = AssignableExpressionRule.matchAssignableExpression(parser, this)
      if (lr.leftRecursive && dvAssignableExpression.node != null) {
        growDvAssignableExpression()
      }
    } if (dvAssignableExpression.leftRecursive != null) {
      dvAssignableExpression.setLeftRecursive()
    }
    return dvAssignableExpression
  }
  
  private def growDvAssignableExpression() {
    while(true) {
      val temp = AssignableExpressionRule.matchAssignableExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvAssignableExpression.derivation.idx) return
      else dvAssignableExpression = temp
    }
  }
  
  def getDvAssignableExpressionExpressions() {
    if (dvAssignableExpressionExpressions == null) {
      val lr = new Result<AssignableExpressionExpressions>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'AssignableExpressionExpressions'"))
      dvAssignableExpressionExpressions = lr
      dvAssignableExpressionExpressions = AssignableExpressionExpressionsRule.matchAssignableExpressionExpressions(parser, this)
      if (lr.leftRecursive && dvAssignableExpressionExpressions.node != null) {
        growDvAssignableExpressionExpressions()
      }
    } if (dvAssignableExpressionExpressions.leftRecursive != null) {
      dvAssignableExpressionExpressions.setLeftRecursive()
    }
    return dvAssignableExpressionExpressions
  }
  
  private def growDvAssignableExpressionExpressions() {
    while(true) {
      val temp = AssignableExpressionExpressionsRule.matchAssignableExpressionExpressions(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvAssignableExpressionExpressions.derivation.idx) return
      else dvAssignableExpressionExpressions = temp
    }
  }
  
  def getDvAssignmentOperator() {
    if (dvAssignmentOperator == null) {
      val lr = new Result<AssignmentOperator>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'AssignmentOperator'"))
      dvAssignmentOperator = lr
      dvAssignmentOperator = AssignmentOperatorRule.matchAssignmentOperator(parser, this)
      if (lr.leftRecursive && dvAssignmentOperator.node != null) {
        growDvAssignmentOperator()
      }
    } if (dvAssignmentOperator.leftRecursive != null) {
      dvAssignmentOperator.setLeftRecursive()
    }
    return dvAssignmentOperator
  }
  
  private def growDvAssignmentOperator() {
    while(true) {
      val temp = AssignmentOperatorRule.matchAssignmentOperator(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvAssignmentOperator.derivation.idx) return
      else dvAssignmentOperator = temp
    }
  }
  
  def getDvGroupExpression() {
    if (dvGroupExpression == null) {
      val lr = new Result<GroupExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'GroupExpression'"))
      dvGroupExpression = lr
      dvGroupExpression = GroupExpressionRule.matchGroupExpression(parser, this)
      if (lr.leftRecursive && dvGroupExpression.node != null) {
        growDvGroupExpression()
      }
    } if (dvGroupExpression.leftRecursive != null) {
      dvGroupExpression.setLeftRecursive()
    }
    return dvGroupExpression
  }
  
  private def growDvGroupExpression() {
    while(true) {
      val temp = GroupExpressionRule.matchGroupExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvGroupExpression.derivation.idx) return
      else dvGroupExpression = temp
    }
  }
  
  def getDvRangeExpression() {
    if (dvRangeExpression == null) {
      val lr = new Result<RangeExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'RangeExpression'"))
      dvRangeExpression = lr
      dvRangeExpression = RangeExpressionRule.matchRangeExpression(parser, this)
      if (lr.leftRecursive && dvRangeExpression.node != null) {
        growDvRangeExpression()
      }
    } if (dvRangeExpression.leftRecursive != null) {
      dvRangeExpression.setLeftRecursive()
    }
    return dvRangeExpression
  }
  
  private def growDvRangeExpression() {
    while(true) {
      val temp = RangeExpressionRule.matchRangeExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvRangeExpression.derivation.idx) return
      else dvRangeExpression = temp
    }
  }
  
  def getDvMinMaxRange() {
    if (dvMinMaxRange == null) {
      val lr = new Result<MinMaxRange>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'MinMaxRange'"))
      dvMinMaxRange = lr
      dvMinMaxRange = MinMaxRangeRule.matchMinMaxRange(parser, this)
      if (lr.leftRecursive && dvMinMaxRange.node != null) {
        growDvMinMaxRange()
      }
    } if (dvMinMaxRange.leftRecursive != null) {
      dvMinMaxRange.setLeftRecursive()
    }
    return dvMinMaxRange
  }
  
  private def growDvMinMaxRange() {
    while(true) {
      val temp = MinMaxRangeRule.matchMinMaxRange(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvMinMaxRange.derivation.idx) return
      else dvMinMaxRange = temp
    }
  }
  
  def getDvCharRange() {
    if (dvCharRange == null) {
      val lr = new Result<CharRange>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'CharRange'"))
      dvCharRange = lr
      dvCharRange = CharRangeRule.matchCharRange(parser, this)
      if (lr.leftRecursive && dvCharRange.node != null) {
        growDvCharRange()
      }
    } if (dvCharRange.leftRecursive != null) {
      dvCharRange.setLeftRecursive()
    }
    return dvCharRange
  }
  
  private def growDvCharRange() {
    while(true) {
      val temp = CharRangeRule.matchCharRange(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvCharRange.derivation.idx) return
      else dvCharRange = temp
    }
  }
  
  def getDvAnyCharExpression() {
    if (dvAnyCharExpression == null) {
      val lr = new Result<AnyCharExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'AnyCharExpression'"))
      dvAnyCharExpression = lr
      dvAnyCharExpression = AnyCharExpressionRule.matchAnyCharExpression(parser, this)
      if (lr.leftRecursive && dvAnyCharExpression.node != null) {
        growDvAnyCharExpression()
      }
    } if (dvAnyCharExpression.leftRecursive != null) {
      dvAnyCharExpression.setLeftRecursive()
    }
    return dvAnyCharExpression
  }
  
  private def growDvAnyCharExpression() {
    while(true) {
      val temp = AnyCharExpressionRule.matchAnyCharExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvAnyCharExpression.derivation.idx) return
      else dvAnyCharExpression = temp
    }
  }
  
  def getDvRuleReferenceExpression() {
    if (dvRuleReferenceExpression == null) {
      val lr = new Result<RuleReferenceExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'RuleReferenceExpression'"))
      dvRuleReferenceExpression = lr
      dvRuleReferenceExpression = RuleReferenceExpressionRule.matchRuleReferenceExpression(parser, this)
      if (lr.leftRecursive && dvRuleReferenceExpression.node != null) {
        growDvRuleReferenceExpression()
      }
    } if (dvRuleReferenceExpression.leftRecursive != null) {
      dvRuleReferenceExpression.setLeftRecursive()
    }
    return dvRuleReferenceExpression
  }
  
  private def growDvRuleReferenceExpression() {
    while(true) {
      val temp = RuleReferenceExpressionRule.matchRuleReferenceExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvRuleReferenceExpression.derivation.idx) return
      else dvRuleReferenceExpression = temp
    }
  }
  
  def getDvTerminalExpression() {
    if (dvTerminalExpression == null) {
      val lr = new Result<TerminalExpression>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'TerminalExpression'"))
      dvTerminalExpression = lr
      dvTerminalExpression = TerminalExpressionRule.matchTerminalExpression(parser, this)
      if (lr.leftRecursive && dvTerminalExpression.node != null) {
        growDvTerminalExpression()
      }
    } if (dvTerminalExpression.leftRecursive != null) {
      dvTerminalExpression.setLeftRecursive()
    }
    return dvTerminalExpression
  }
  
  private def growDvTerminalExpression() {
    while(true) {
      val temp = TerminalExpressionRule.matchTerminalExpression(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvTerminalExpression.derivation.idx) return
      else dvTerminalExpression = temp
    }
  }
  
  def getDvInTerminalChar() {
    if (dvInTerminalChar == null) {
      val lr = new Result<InTerminalChar>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'InTerminalChar'"))
      dvInTerminalChar = lr
      dvInTerminalChar = InTerminalCharRule.matchInTerminalChar(parser, this)
      if (lr.leftRecursive && dvInTerminalChar.node != null) {
        growDvInTerminalChar()
      }
    } if (dvInTerminalChar.leftRecursive != null) {
      dvInTerminalChar.setLeftRecursive()
    }
    return dvInTerminalChar
  }
  
  private def growDvInTerminalChar() {
    while(true) {
      val temp = InTerminalCharRule.matchInTerminalChar(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvInTerminalChar.derivation.idx) return
      else dvInTerminalChar = temp
    }
  }
  
  def getDvID() {
    if (dvID == null) {
      val lr = new Result<ID>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'ID'"))
      dvID = lr
      dvID = IDRule.matchID(parser, this)
      if (lr.leftRecursive && dvID.node != null) {
        growDvID()
      }
    } if (dvID.leftRecursive != null) {
      dvID.setLeftRecursive()
    }
    return dvID
  }
  
  private def growDvID() {
    while(true) {
      val temp = IDRule.matchID(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvID.derivation.idx) return
      else dvID = temp
    }
  }
  
  def getDvEOI() {
    if (dvEOI == null) {
      val lr = new Result<EOI>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'EOI'"))
      dvEOI = lr
      dvEOI = EOIRule.matchEOI(parser, this)
      if (lr.leftRecursive && dvEOI.node != null) {
        growDvEOI()
      }
    } if (dvEOI.leftRecursive != null) {
      dvEOI.setLeftRecursive()
    }
    return dvEOI
  }
  
  private def growDvEOI() {
    while(true) {
      val temp = EOIRule.matchEOI(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvEOI.derivation.idx) return
      else dvEOI = temp
    }
  }
  
  def getDvComment() {
    if (dvComment == null) {
      val lr = new Result<Comment>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'Comment'"))
      dvComment = lr
      dvComment = CommentRule.matchComment(parser, this)
      if (lr.leftRecursive && dvComment.node != null) {
        growDvComment()
      }
    } if (dvComment.leftRecursive != null) {
      dvComment.setLeftRecursive()
    }
    return dvComment
  }
  
  private def growDvComment() {
    while(true) {
      val temp = CommentRule.matchComment(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvComment.derivation.idx) return
      else dvComment = temp
    }
  }
  
  def getDvWS() {
    if (dvWS == null) {
      val lr = new Result<WS>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in 'WS'"))
      dvWS = lr
      dvWS = WSRule.matchWS(parser, this)
      if (lr.leftRecursive && dvWS.node != null) {
        growDvWS()
      }
    } if (dvWS.leftRecursive != null) {
      dvWS.setLeftRecursive()
    }
    return dvWS
  }
  
  private def growDvWS() {
    while(true) {
      val temp = WSRule.matchWS(parser, this)
      if (temp.node == null || temp.derivation.idx <= dvWS.derivation.idx) return
      else dvWS = temp
    }
  }
  
  def getDv_() {
    if (dv_ == null) {
      val lr = new Result<_>(false, this, new ParseInfo(index, "Detected non-terminating left-recursion in '_'"))
      dv_ = lr
      dv_ = _Rule.match_(parser, this)
      if (lr.leftRecursive && dv_.node != null) {
        growDv_()
      }
    } if (dv_.leftRecursive != null) {
      dv_.setLeftRecursive()
    }
    return dv_
  }
  
  private def growDv_() {
    while(true) {
      val temp = _Rule.match_(parser, this)
      if (temp.node == null || temp.derivation.idx <= dv_.derivation.idx) return
      else dv_ = temp
    }
  }
  
  
  def getDvChar() {
    if (dvChar == null) {
      dvChar = dvfChar.apply(this)
    }
    return dvChar
  }
  
  override toString() {
    new String(parser.chars, index, Math.min(100, parser.chars.length - index))
  }

}

class ParseException extends RuntimeException {
  
  new(String message) {
    super(message)
  }
  
  new(Pair<Integer, Integer> location, String... message) {
    super("[" + location.key + "," + location.value + "] Expected " 
      + if (message != null) message.join(' or ').replaceAll('\n', '\\\\n').replaceAll('\r', '\\\\r') else '')
  }
  
  override getMessage() { 'ParseException' + super.message }
  override toString() { message }
  
}

package class CharacterRange {

  String chars

  static def operator_upTo(String lower, String upper) {
    return new CharacterRange(lower.charAt(0), upper.charAt(0))
  }
  
  static def operator_plus(CharacterRange r1, CharacterRange r2) {
    new CharacterRange(r1.chars + r2.chars)
  }

  static def operator_plus(CharacterRange r, String s) {
    new CharacterRange(r.chars  + s)
  }

  private new(char lower, char upper) {
    if (lower > upper) {
      throw new IllegalArgumentException('lower is great than upper bound')
    }

    val sb = new StringBuilder(upper - lower)
    var c = lower
    while (c <= upper) {
      sb.append(c)
      c = ((c as int) + 1) as char
    }
    chars = sb.toString()
  }
  
  package new(String chars) {
    this.chars = chars
  }

  def contains(Character c) {
    chars.indexOf(c) != -1
  }
  
  override toString() {
    chars
  }

}

package class Result<T> {
  
  T node
  
  Boolean leftRecursion = null
  
  Derivation derivation
  
  ParseInfo info
  
  new(T node, Derivation derivation, ParseInfo info) {
    this.node = node
    this.derivation = derivation
    this.info = info
  }
  
  new(boolean leftRecursion, Derivation derivation, ParseInfo info) {
    this(null, derivation, info)
    this.leftRecursion = leftRecursion
  }
  
  def getNode() { node }
  def getDerivation() { derivation }
  def getInfo() { info }
  def setInfo(ParseInfo info) { this.info = info }
  def isLeftRecursive() { leftRecursion }
  def setLeftRecursive() { leftRecursion = true }
  
  override toString() {
    'Result[' + (if (node != null) 'MATCH' else 'NO MATCH') + ']'
  }
  
}

package class SpecialResult extends Result<Object> {
  new(Object o) { super(o, null, null) }
}

package class ParseInfo {
  
  int position
  
  Set<String> messages
  
  new(int position) {
    this(position, null as Iterable<String>) 
  }
  
  new(int position, String message) {
    this(position, newHashSet(message)) 
  }
  
  new(int position, Iterable<String> messages) {
    this.position = position
    this.messages = messages?.toSet
  }
  
  def getPosition() { position }
  def getMessages() { messages }
  
  def join(Result<?> r, boolean inPredicate) {
    if (!inPredicate && r != null && r.info != null) {
      if (position > r.info.position || r.info.messages == null) {
        // Do nothing
      } else if (position < r.info.position || messages == null) {
        position = r.info.position
        messages = r.info.messages
      } else {
        messages += r.info.messages
      }
    }
  }
  
}
