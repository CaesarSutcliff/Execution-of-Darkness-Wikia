namespace Execution_of_Darkness_Wikia.Models
{
    public class CharacterRelationship
    {
        public int Id { get; set; }
        public int CharacterId { get; set; }
        public int RelatedCharacterId { get; set; }
        public string RelationshipType { get; set; }
        public string Summary { get; set; }

        public virtual CharacterProfile Character { get; set; }
        public virtual CharacterProfile RelatedCharacter { get; set; }
    }
}
