//Modified version of the Unity Sprites/Default shader. Uses MainTex uv coordinates with MainTex2 color data. 

Shader "Custom/Sprites/DefaultTextureReplacement" {
     Properties
     {
         [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        [HideInInspector] _RendererColor ("RendererColor", Color) = (1,1,1,1)
        [HideInInspector] _Flip ("Flip", Vector) = (1,1,1,1)
        [PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
        [PerRendererData] _EnableExternalAlpha ("Enable External Alpha", Float) = 0

         _MainTex2 ("_MainTex2", 2D) = "white" {} 
     }
 
     SubShader
     {
         Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Cull Off
        Lighting Off
        ZWrite Off
        Blend One OneMinusSrcAlpha

        Pass
        {
        CGPROGRAM
            #pragma vertex SpriteVert
            #pragma fragment SpriteFrag2
            #pragma target 2.0
            #pragma multi_compile_instancing
            #pragma multi_compile _ PIXELSNAP_ON
            #pragma multi_compile _ ETC1_EXTERNAL_ALPHA
            #include "UnitySprites.cginc"

            sampler2D _MainTex2;

			fixed4 SampleSpriteTexture2 (float2 uv)
			{
			    fixed4 color = tex2D (_MainTex2, uv);

				#if ETC1_EXTERNAL_ALPHA
				    fixed4 alpha = tex2D (_AlphaTex, uv);
				    color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
				#endif

			    return color;
			}

            fixed4 SpriteFrag2(v2f IN) : SV_Target
			{
			    fixed4 c = SampleSpriteTexture2 (IN.texcoord) * IN.color;
			    c.rgb *= c.a;
			    return c;
			}

        ENDCG
        }
     }
	 Fallback "Transparent/VertexLit"
 }