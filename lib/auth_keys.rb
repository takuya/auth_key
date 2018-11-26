
require 'openssl'
class AuthKeys
    class << self
        def KEY_PATH ; ENV["KEY_PATH"] ||  "~/.auth_keys" end
        def MASTER_KEY ;  ENV["MASTER_KEY"] ||  "~/.ssh/id_rsa" end
        def encrypt_data(data,pass)
            cipher = OpenSSL::Cipher.new("AES-256-CBC")
            salt = OpenSSL::Random.random_bytes(8)
            cipher.encrypt
            cipher.pkcs5_keyivgen(pass, salt, 100 )
            data = cipher.update(data) + cipher.final
            ## salted
            data = "Salted__" + salt + data
        end
        def encrypt()
            data = self.read
            return  if is_encrypted?(data)

            data = self.encrypt_data(data,self.master_key_data)
            save(data)
        end
        def decrypt()
            data = self.read
            return unless is_encrypted?(data)
            data = data.force_encoding("ASCII-8BIT")
            data = self.decrypt_data(data,self.master_key_data)
            self.save(data)
        end
        def decrypt_data(data,pass)
            data = data.force_encoding("ASCII-8BIT")
            salt = data[8,8]
            data = data[16, data.size]
            cipher = OpenSSL::Cipher.new("AES-256-CBC")
            cipher.decrypt
            cipher.pkcs5_keyivgen(pass, salt, 100 )
            cipher.update(data) + cipher.final
        end
        def rsautil
            OpenSSL::PKey::RSA.new(self.master_key_data)
        end
        def encrypt_data_by_pubkey(data)
            self.rsautil.public_encrypt(data)
        end
        def decrypt_data_by_privkey(data)
            self.rsautil.private_decrypt(data)
        end

        def is_salted?(str)
            /Salted__/ === str[0,8]
        end
        def is_encrypted?(str)
            return true if self.is_salted?(str)
            # check encrypt by trying to treat as  UTF-8 String
            begin
                str.split("")
                return false
            rescue => e
                return true
            end
        end
        def master_key_data
            path = File.expand_path(self.MASTER_KEY)
            raise unless File.exists?(path)
            open(path).read
        end
        def save(content)
            path = File.expand_path(self.KEY_PATH)
            raise "#{path} not found." unless File.exists?(path)
            open(path, "w"){|f|
                f.write content
            }
        end

        def load()
            content = self.read
            content = self.decrypt_data(content,self.master_key_data) if is_encrypted?(content)
            array = content
                        .split("\n")
                        .reject{|e| e.strip =~/^#/}
                        .map(&:split).map{|e| [e[0],[   e[1],e[2]  ] ] }
            password_table = Hash[array]
        end
        def read()
            path = File.expand_path(self.KEY_PATH)
            raise unless File.exists?(path)
            content = open(path).read
        end
        def get(key)
            hash = self.load
            if key.class == Regexp then
                key = self.keys.find{|e| e=~key}
                return nil unless key
            end
            hash.key?(key) ? hash[key] : nil ;
        end
        def [](key)
            self.get(key)
        end
        def keys
            self.load.keys
        end
    end
end


if $0 == __FILE__ then
    require 'pp'
    pp AuthKeys.load
    pp AuthKeys.keys
    pp AuthKeys["softbank"]
    pp AuthKeys.encrypt
end
