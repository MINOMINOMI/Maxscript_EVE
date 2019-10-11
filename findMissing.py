import os


def _make_file_name_array_(__prefix__):
    __array_fileNames__ = []
    for i in range(1, 23):
        __less_then_10_ = i < 10
        for j in range(1, 8):
            if __less_then_10_:
                __file_name__ = __prefix__ + '0' + str(i) + '-' + str(j)
                __array_fileNames__.append(__file_name__)
            else:
                __file_name__ = __prefix__ + str(i) + '-' + str(j)
                __array_fileNames__.append(__file_name__)

    for i in range(1, 13):
        __less_then_10_ = i < 10
        if __less_then_10_:
            __file_name__ = __prefix__ + 'U' + '0' + str(i)
            __array_fileNames__.append(__file_name__)
        else:
            __file_name__ = __prefix__ + 'U' + str(i)
            __array_fileNames__.append(__file_name__)
    # print(__array_fileNames__)
    return __array_fileNames__


__ok_file_list__ = _make_file_name_array_(__prefix__='Shift_up')
__input_data__ = input('paste dir:')
path = __input_data__
file_list = os.listdir(path)
__range_max__ = len(__ok_file_list__)
for i in range(1, __range_max__):
    __isOK__ = (__ok_file_list__[i] == file_list[i])
    if __isOK__:
        print("ok")
    else:
        print(__ok_file_list__[i])
cnt_file_list = len(file_list)
print("file_list: {}".format(file_list))
print(cnt_file_list)
