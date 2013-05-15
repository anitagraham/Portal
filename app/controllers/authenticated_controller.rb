#  for all controllers which need authentication
class AuthenticatedController < ApplicationController
  
  before_filter :authenticate!
  
end
