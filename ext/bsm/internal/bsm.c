#include "c_api.h"

#include <ruby.h>
#include <ruby/encoding.h>
#include <string.h>

static VALUE mBsm;
static VALUE cGenerator;
static VALUE eInvalidInput;

struct generator_wrapper
{
  bsm2_processor* proc;
};

static void generator_free(void* ptr);

static const rb_data_type_t generator_data_type = {
  "Bsm/GeneratorInternal",
  {NULL, generator_free, NULL},
  NULL,
  NULL,
  RUBY_TYPED_FREE_IMMEDIATELY,
};

static void generator_free(void* ptr)
{
  struct generator_wrapper* w = (struct generator_wrapper*)ptr;
  if (w)
  {
    if (w->proc)
    {
      bsm2_free(w->proc);
    }
    xfree(w);
  }
}

static VALUE generator_alloc(VALUE klass)
{
  struct generator_wrapper* w;
  VALUE obj = TypedData_Make_Struct(
    klass, struct generator_wrapper, &(generator_data_type), w);
  w->proc = bsm2_new();
  if (!w->proc)
  {
    rb_raise(eInvalidInput, "bsm2_new failed");
  }
  return obj;
}

static VALUE generator_generate_raw(VALUE self, VALUE input)
{
  struct generator_wrapper* w;
  TypedData_Get_Struct(self, struct generator_wrapper, &generator_data_type, w);

  input = rb_String(input);

  /* Iterate over lines, feeding each to bsm2_convert_line, concatenating
   * the returned bytes into one binary String. */
  VALUE result = rb_str_new_literal("");
  rb_enc_associate(result, rb_ascii8bit_encoding());

  char* cstr = StringValuePtr(input);
  long total = RSTRING_LEN(input);
  long line_start = 0;

  for (long i = 0; i <= total; i++)
  {
    if (i == total || cstr[i] == '\n')
    {
      long line_len = i - line_start;
      const char* line = cstr + line_start;

      size_t out_len = 0;
      bsm2_error* err = NULL;
      char* out = bsm2_convert_line(w->proc, line, (size_t)line_len,
                                    &out_len, &err);
      if (!out)
      {
        if (err)
        {
          VALUE msg = rb_str_new_cstr(bsm2_error_message(err));
          bsm2_error_free(err);
          rb_raise(eInvalidInput, "%" PRIsVALUE, msg);
        }
        rb_raise(eInvalidInput, "bsm2_convert_line failed");
      }

      if (out_len)
      {
        rb_str_cat(result, out, (long)out_len);
      }
      free(out);

      line_start = i + 1;
    }
  }

  return result;
}

void Init_internal(void)
{
  mBsm = rb_define_module("Bsm");
  eInvalidInput =
    rb_define_class_under(mBsm, "InvalidInput", rb_eStandardError);
  cGenerator =
    rb_define_class_under(mBsm, "GeneratorInternal", rb_cObject);

  rb_define_alloc_func(cGenerator, generator_alloc);
  rb_define_method(cGenerator, "generate_raw", generator_generate_raw, 1);
}
