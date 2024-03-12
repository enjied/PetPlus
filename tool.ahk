/**
 * 读写ini中Pet setction中的配置
 * @param key 要写入的配置
 * @param value 要写入的值
 * @param ConfigPath 文件位置
 */
PetWrite(key, value, ConfigPath) {
    IniWrite value, ConfigPath, "Pet", key
}

