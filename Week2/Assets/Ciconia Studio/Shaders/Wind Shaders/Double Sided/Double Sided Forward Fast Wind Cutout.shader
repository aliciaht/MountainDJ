Shader "Ciconia Studio/Effects/Wind/Forward/Fast/2Sided/Cutout" {
    Properties {
        [Space(15)][Header(Main Properties)]
        [Space(20)]_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (Cutout A)", 2D) = "white" {}
        _Desaturate ("Desaturate", Range(0, 1)) = 0
        [Space(35)]_EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _EmissionMap ("Emission map", 2D) = "white" {}
        _EmissiveIntensity ("Emissive Intensity", Range(0, 2)) = 1

        [Space(45)][Header(Wind Properties)]
        [Space(20)][MaterialToggle] _InvertMask ("Invert Mask", Float ) = 1
        _MaskExclusion ("Mask Exclusion", 2D) = "black" {}

        [Space(45)][MaterialToggle] _VisualizeWave ("Visualize Wave", Float ) = 0
        [MaterialToggle] _UseWorldCoordinate ("Use World Coordinate", Float ) = 0
        [Space(25)]_WaveTiling ("Wave Tiling", Float ) = 1
        _WaveTexture ("Wave Texture", 2D) = "white" {}
        _WaveTextureAmount ("Texture Amount", Range(0, 1.5)) = 0.5
        [Space(25)]_Deformation ("Deformation", Float ) = 1
        _Rotation ("Rotation", Float ) = 0
        _Speed ("Speed", Float ) = 0.1
        [Space(10)][MaterialToggle] _InvertWaveDirection ("Invert Wave Direction", Float ) = 0

        [Space(45)][Header(Transparent Properties)]
        [Space(20)][MaterialToggle] _DisableAlbedoAlphaChannel ("Disable Albedo Alpha Channel", Float ) = 1
        [MaterialToggle] _InvertAlbedoAlpha ("Invert Albedo Alpha", Float ) = 0
        [Space(15)][MaterialToggle] _InvertAdditionalmap ("Invert Additional map", Float ) = 0
        _AdditionalCutoutmap ("Additional Cutout map", 2D) = "black" {}
        [Space(15)]_AlphaAmount ("Alpha Amount", Range(-0.5, 1)) = 0.2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MaskExclusion; uniform float4 _MaskExclusion_ST;
            uniform fixed _VisualizeWave;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform fixed _InvertMask;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform float _Desaturate;
            uniform float4 _EmissionColor;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _EmissiveIntensity;
            uniform float _Rotation;
            uniform float _WaveTiling;
            uniform float _Deformation;
            uniform float _WaveTextureAmount;
            uniform fixed _UseWorldCoordinate;
            uniform fixed _InvertAlbedoAlpha;
            uniform float _AlphaAmount;
            uniform sampler2D _AdditionalCutoutmap; uniform float4 _AdditionalCutoutmap_ST;
            uniform fixed _InvertAdditionalmap;
            uniform fixed _DisableAlbedoAlphaChannel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( o.uv0, float2(mul(unity_ObjectToWorld, v.vertex).b,mul(unity_ObjectToWorld, v.vertex).r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (o.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2Dlod(_WaveTexture,float4(TRANSFORM_TEX(node_3374, _WaveTexture),0.0,0));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float WaveMask = (node_5837*node_437);
                float3 VertexOffset = (v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1);
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_5988 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_5988), node_5988, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
                clip(Cutout - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - 0;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float4 node_3039 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( i.uv0, float2(i.posWorld.b,i.posWorld.r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (i.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2D(_WaveTexture,TRANSFORM_TEX(node_3374, _WaveTexture));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2D(_MaskExclusion,TRANSFORM_TEX(i.uv0, _MaskExclusion));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - node_437))))), _VisualizeWave );
                float3 diffuseColor = Albedo;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 Emissivemap = ((_EmissionColor.rgb*_EmissionMap_var.rgb)*_EmissiveIntensity);
                float3 emissive = Emissivemap;
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MaskExclusion; uniform float4 _MaskExclusion_ST;
            uniform fixed _VisualizeWave;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform fixed _InvertMask;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform float _Desaturate;
            uniform float4 _EmissionColor;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _EmissiveIntensity;
            uniform float _Rotation;
            uniform float _WaveTiling;
            uniform float _Deformation;
            uniform float _WaveTextureAmount;
            uniform fixed _UseWorldCoordinate;
            uniform fixed _InvertAlbedoAlpha;
            uniform float _AlphaAmount;
            uniform sampler2D _AdditionalCutoutmap; uniform float4 _AdditionalCutoutmap_ST;
            uniform fixed _InvertAdditionalmap;
            uniform fixed _DisableAlbedoAlphaChannel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( o.uv0, float2(mul(unity_ObjectToWorld, v.vertex).b,mul(unity_ObjectToWorld, v.vertex).r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (o.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2Dlod(_WaveTexture,float4(TRANSFORM_TEX(node_3374, _WaveTexture),0.0,0));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float WaveMask = (node_5837*node_437);
                float3 VertexOffset = (v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1);
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_5988 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_5988), node_5988, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
                clip(Cutout - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 node_3039 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( i.uv0, float2(i.posWorld.b,i.posWorld.r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (i.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2D(_WaveTexture,TRANSFORM_TEX(node_3374, _WaveTexture));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2D(_MaskExclusion,TRANSFORM_TEX(i.uv0, _MaskExclusion));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - node_437))))), _VisualizeWave );
                float3 diffuseColor = Albedo;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MaskExclusion; uniform float4 _MaskExclusion_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform fixed _InvertMask;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform float _Rotation;
            uniform float _WaveTiling;
            uniform float _Deformation;
            uniform float _WaveTextureAmount;
            uniform fixed _UseWorldCoordinate;
            uniform fixed _InvertAlbedoAlpha;
            uniform float _AlphaAmount;
            uniform sampler2D _AdditionalCutoutmap; uniform float4 _AdditionalCutoutmap_ST;
            uniform fixed _InvertAdditionalmap;
            uniform fixed _DisableAlbedoAlphaChannel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float4 posWorld : TEXCOORD4;
                float3 normalDir : TEXCOORD5;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( o.uv0, float2(mul(unity_ObjectToWorld, v.vertex).b,mul(unity_ObjectToWorld, v.vertex).r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (o.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2Dlod(_WaveTexture,float4(TRANSFORM_TEX(node_3374, _WaveTexture),0.0,0));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float WaveMask = (node_5837*node_437);
                float3 VertexOffset = (v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1);
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_5988 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_5988), node_5988, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
                clip(Cutout - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _MaskExclusion; uniform float4 _MaskExclusion_ST;
            uniform fixed _VisualizeWave;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform fixed _InvertMask;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform float _Desaturate;
            uniform float4 _EmissionColor;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _EmissiveIntensity;
            uniform float _Rotation;
            uniform float _WaveTiling;
            uniform float _Deformation;
            uniform float _WaveTextureAmount;
            uniform fixed _UseWorldCoordinate;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( o.uv0, float2(mul(unity_ObjectToWorld, v.vertex).b,mul(unity_ObjectToWorld, v.vertex).r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (o.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2Dlod(_WaveTexture,float4(TRANSFORM_TEX(node_3374, _WaveTexture),0.0,0));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float WaveMask = (node_5837*node_437);
                float3 VertexOffset = (v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1);
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 Emissivemap = ((_EmissionColor.rgb*_EmissionMap_var.rgb)*_EmissiveIntensity);
                o.Emission = Emissivemap;
                
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 node_3039 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float node_3205_ang = ((_Rotation*3.141592654)/180.0);
                float node_3205_spd = 1.0;
                float node_3205_cos = cos(node_3205_spd*node_3205_ang);
                float node_3205_sin = sin(node_3205_spd*node_3205_ang);
                float2 node_3205_piv = float2(0.5,0.5);
                float2 node_3205 = (mul((lerp( i.uv0, float2(i.posWorld.b,i.posWorld.r), _UseWorldCoordinate )*_WaveTiling)-node_3205_piv,float2x2( node_3205_cos, -node_3205_sin, node_3205_sin, node_3205_cos))+node_3205_piv);
                float4 node_782 = _Time;
                float node_2883 = (node_782.g*_Speed);
                float2 node_9315 = (i.uv0/4.0);
                float2 node_3374 = (node_3205+lerp( (node_9315+node_2883*float2(1,0)), (node_9315+node_2883*float2(-1,0)), _InvertWaveDirection ));
                float4 _WaveTexture_var = tex2D(_WaveTexture,TRANSFORM_TEX(node_3374, _WaveTexture));
                float node_5837 = saturate((lerp(-1,0.5,_WaveTextureAmount)+_WaveTexture_var.r));
                float4 _MaskExclusion_var = tex2D(_MaskExclusion,TRANSFORM_TEX(i.uv0, _MaskExclusion));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float node_437 = MaskExclusion;
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - node_437))))), _VisualizeWave );
                float3 diffColor = Albedo;
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
