String normalizeReceiptText(String text){
  String result = text.toUpperCase();

  result = result.replaceAll("PIZZA HUP", "");
  result = result.replaceAll("COUNTER", "");
  result = result.replaceAll("OUNTER", "");
  result = result.replaceAll("TICKET", "");
  result = result.replaceAll("#", "");
  result = result.replaceAll(" NO", "");
  result = result.replaceAll("ENTERED BY", "");
  result = result.replaceAll("SUBTOTAL", "");
  result = result.replaceAll("SALES", "");
  result = result.replaceAll("TOURISM", "");
  result = result.replaceAll("TAX", "");
  result = result.replaceAll("BALANCE", "");
  result = result.replaceAll(" DUE", "");
  result = result.replaceAll("\n", "");
  result = result.trim();

  return result;
}