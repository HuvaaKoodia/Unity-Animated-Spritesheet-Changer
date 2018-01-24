using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ChangeTextureOnInput : MonoBehaviour
{
	#region variables

	public TextureChanger textureChanger;
	public Texture2D changeToTexture;

	bool changed = false;

	#endregion

	#region initialization

	#endregion

	#region logic

	private void Update()
	{
		if(Input.GetKeyDown(KeyCode.Space))
		{
			changed = !changed;
			textureChanger.ChangeTexture(changed ? changeToTexture : textureChanger.startTexture);
		}
	}

	#endregion

	#region public interface

	#endregion

	#region private interface

	#endregion

	#region events

	#endregion
}
