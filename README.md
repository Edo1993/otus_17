# otus_17
# Сбор и анализ логов

Настраиваем центральный сервер для сбора логов в вагранте поднимаем 2 машины web и log. На web поднимаем nginx на log настраиваем центральный лог сервер на любой системе на выбор:
- journald
- rsyslog
- elk
Настраиваем аудит следящий за изменением конфигов nginx:
 - все критичные логи с web должны собираться и локально и удаленно
 - все логи с nginx должны уходить на удаленный сервер (локально только критичные)
 - логи аудита должны также уходить на удаленную систему
 
 


