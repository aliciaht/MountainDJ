using UnityEngine;
using System.Collections;

namespace ShaderForge {

	[System.Serializable]
	public class SFP_SwitchProperty : SF_ShaderProperty {

		public new SFP_SwitchProperty Initialize( SF_Node node ) {
			base.nameType = "Toggle";
			base.Initialize( node );
			return this;
		}

		public override string GetInitializationLine() {
			string defaultValue = base.node.texture.dataUniform.x.ToString();
			return GetTagString() + "[MaterialToggle] " + GetVariable() + " (\"" + nameDisplay + "\", Float ) = " + defaultValue;
		}

		public override string GetCGType() => "fixed";

		// TODO: Unity UV offsets
		//public override string GetFragmentPrepare() {
		//	return "fixed4 " + GetVariable() + " = " + node.Evaluate() + ";";
		//}


	}
}