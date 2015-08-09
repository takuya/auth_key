
require 'openssl'
class AuthKeys
    KEY_PATH = "~/.auth_keys"
    MASTER_KEY = "~/.ssh/id_rsa"
    class << self
        def encrypt_data(data,pass)
            cipher = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
            salt = OpenSSL::Random.random_bytes(8)
            cipher.encrypt
            cipher.pkcs5_keyivgen(pass, salt)
            data = cipher.update(data) + cipher.final
            ## salted
            data = "Salted__" + salt + data
        end
        def encrypt()
            data = self.read
            return  if is_encrypted?(data)
            data = encrypt_data(data, self.master_key)
            save(data)
        end
        def master_key
            path = File.expand_path(MASTER_KEY)
            raise unless File.exists?(path)
            open(path).read
        end
        def decrypt_data(data,pass)
            data = data.force_encoding("ASCII-8BIT")
            salt = data[8,8]
            data = data[16, data.size]
            cipher = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
            cipher.decrypt
            cipher.pkcs5_keyivgen(pass, salt)
            cipher.update(data) + cipher.final
        end

        def decrypt()
            data = self.read
            data = data.force_encoding("ASCII-8BIT")
            return unless is_encrypted?(data)
            data = self.decrypt_data(data,self.master_key)
            self.save(data)
        end
        def is_encrypted?(str)
            /Salted__/ === str[0,8] 
        end
        def save(content)
            path = File.expand_path(KEY_PATH)
            raise "#{path} not found." unless File.exists?(path)
            open(path, "w"){|f| 
                f.write content
            }
        end

        def load()
            content = self.read
            content = self.decrypt_data(content,self.master_key) if is_encrypted?(content)
            array = content 
                        .split("\n")
                        .reject{|e| e.strip =~/^#/}
                        .map(&:split).map{|e| [e[0],[   e[1],e[2]  ] ] }
            password_table = Hash[array]
        end
        def read()
            path = File.expand_path(KEY_PATH)
            raise unless File.exists?(path)
            content = open(path).read
        end
        def get(key)
            hash = self.load
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

