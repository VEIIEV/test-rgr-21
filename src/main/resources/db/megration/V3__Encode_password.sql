create extension if not exists pgcrypto;
--gen_salt(bf-алг шифрования,8- прочность ) = генерация соли (доп знач присоединяемая к паролю при шифрование)
update usr set password = crypt(password, gen_salt('bf',8))