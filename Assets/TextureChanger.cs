using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TextureChanger : MonoBehaviour
{
	#region variables
	public Shader textureReplacementShader;
	public Texture2D startTexture = null;

	SpriteRenderer spriteRenderer;

	#endregion

	#region initialization

	private void Awake()
	{
		spriteRenderer = GetComponent<SpriteRenderer>();

		#if UNITY_EDITOR
		if(!spriteRenderer)
		{
			Debug.LogError("Could not find sprite renderer at " + this.name);
			return;
		}

		if(!textureReplacementShader)
		{
			Debug.LogError("Could not find shader");
			return;
		}
		#endif

		spriteRenderer.material = new Material(textureReplacementShader);
	}

	void Start()
	{
		if(startTexture)
			ChangeTexture(startTexture);	
	}

	#endregion

	#region logic

	#endregion

	#region public interface

	public void ChangeTexture(Texture2D texture)
	{
		spriteRenderer.material.SetTexture("_MainTex2", texture);
	}

	#endregion

	#region private interface

	#endregion

	#region events

	#endregion
}
