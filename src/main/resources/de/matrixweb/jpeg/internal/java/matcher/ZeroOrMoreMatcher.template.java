class ZeroOrMoreMatcher implements GrammarNodeMatcher {

  public boolean matches(final RuleMatchingContext context, final String rule,
      final Input input) {
    final List<ParsingNode> parsingNodes = new ArrayList<ParsingNode>();
    final Input newInput = new Input(input.getChars());
    ParsingNode result = context.getParser().parse(rule, newInput);
    while (result != null) {
      parsingNodes.add(result);
      newInput.setChars(newInput.getChars());
      result = context.getParser().parse(rule, newInput);
    }
    if (parsingNodes.size() > 0) {
      context.addParsingNode(new ParsingNode(rule, parsingNodes
          .toArray(new ParsingNode[parsingNodes.size()])));
    }
    input.setChars(newInput.getChars());
    return true;
  }

}
