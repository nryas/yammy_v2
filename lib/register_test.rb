#$:.unshift File.dirname(__FILE__)
require './MenuRegister'
include MenuRegister

# converter = ManuRegister
converter = MenuRegister::XlsxImporter.new("./hoge.xlsx")
converter.convert

filter = MenuRegister::MenuFilter.new
filter.filter
