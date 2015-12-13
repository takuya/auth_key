# AuthKeys

Saving and Editing passwords more easily.
Using ~/.auth_keys file , this is space seperated file.

## Usage

AuthKeys uses CSV/TSV passwod list.
File format is TSV(space sperated) for easy to edit.

## example of ~/.auth_keys
    softbank    080xxxxxxxxx              12345678
    mobilepoint example@i.softbank.jp     passs
    starbucks   example@gmail.com         passssss
    au          example@au                passssss
    wi2         example@au                passssss
    7spot       example@gmail.com         passssss

## Example 
    #/usr/bin/env ruby 
    require 'auth_keys'
    AuthKeys["site_name"]

~/.auth_keys is to store id/pass pair.

| key(site_name) | login_id | password |
|----------------|----------|----------|
|mixi| username@example.com | my_pass  |

# execute from CLI  (bin/auth_keys)

Space sperateted is very easy for editing and reading, but not enough secure.
So auth_keys comannd is available, for easy to encrypt and to decrypt ~/.auth_keys from CLI.

    $ auth_keys -e  #encrypt ~/.auth_keys  after edit
    $ auth_keys -d  #decrypt ~/.auth_keys  before edit
    $ auth_keys -l  #list key names  ~/.auth_keys 
    $ auth_keys -k key  #retrieve id/pass pair from  ~/.auth_keys 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auth_keys_chain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auth_keys_chain

## Contributing

1. Fork it ( https://github.com/takuya/auth_keys/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


