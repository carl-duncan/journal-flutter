use magic_crypt::{new_magic_crypt, MagicCryptTrait};

wit_bindgen_rust::export!("encrypter.wit");
struct Encrypter;
impl encrypter::Encrypter for Encrypter {
    fn encrypt(message: String, key: String) -> String {
        let mc = new_magic_crypt!(key, 256);
        let base64 = mc.encrypt_str_to_base64(message);
        base64
    }

    fn decrypt(message: String, key: String) -> String {
        let mc = new_magic_crypt!(key, 256);
        let base64 = mc.decrypt_base64_to_string(message);
        if base64.is_err() {
            return "error".to_string();
        }
        base64.unwrap()
    }
}