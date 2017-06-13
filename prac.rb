require 'uri'
require 'base64'
require 'openssl'

cont='BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiJTQwNDc0MjlkNWFlZmQ5Mjc5YjYzNTAxMTBmMzcxYmM3BjsAVEkiCnRva2VuBjsARkkiG2s5ZXp1dmE2WXVRbFQ5NWdUaWRsbmcGOwBGSSIRbG9nZ2VkX2luX2lkBjsARmkK--4395f36588cc649c691d7e4d6c148ef4a8a9ef9a'
un_cont=URI.unescape(cont)
data,digest =un_cont.split('--')
puts Marshal.load(::Base64.decode64(data))
secret_t = '1111111111111111111111111111111'
print(OpenSSL::HMAC.hexdigest(OpenSSL::Digest.const_get('SHA1').new,secret_t,data))





