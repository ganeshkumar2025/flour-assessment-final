using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace SalesRepManager.API.Helper
{
    public class JsonDateOnlyConverter : JsonConverter<DateTime>
    {
        private const string Format = "yyyy-MM-dd";

        public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var dateStr = reader.GetString();
            if (string.IsNullOrWhiteSpace(dateStr))
            {
                return default;
            }

            return DateTime.ParseExact(dateStr, Format, CultureInfo.InvariantCulture);
        }

        public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(Format));
        }
    }
}
