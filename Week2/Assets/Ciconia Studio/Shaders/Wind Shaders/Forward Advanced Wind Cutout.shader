Shader "Ciconia Studio/Effects/Wind/Forward/Advanced/Cutout" {
    Properties {
        [Space(15)][Header(Main Properties)]
        [Space(20)]_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (Cutout A)", 2D) = "white" {}
        _Desaturate ("Desaturate", Range(0, 1)) = 0
        [Space(35)]_SpecColor ("Specular Color", Color) = (1,1,1,1)
        _SpecGlossMap ("Specular map(GlossA)", 2D) = "white" {}
        _SpecularIntensity ("Specular Intensity", Range(0, 2)) = 0.2
        _FresnelStrength ("Fresnel Strength", Range(0, 8)) = 0
        [Space(15)]_Glossiness ("Glossiness", Range(0, 2)) = 0.5
        [Space(10)]_AmbientLight ("Ambient Light", Range(0, 8)) = 0
        [Space(35)]_BumpMap ("Normal map", 2D) = "bump" {}
        _NormalIntensity ("Normal Intensity", Range(0, 2)) = 1
        [Space(35)]_OcclusionMap ("Ambient Occlusion map", 2D) = "white" {}
        _AoIntensity ("Ao Intensity", Range(0, 2)) = 1
        [Space(35)]_EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _EmissionMap ("Emission map", 2D) = "white" {}
        _EmissiveIntensity ("Emissive Intensity", Range(0, 2)) = 1

        [Space(45)][Header(Wind Properties)]
        [Space(20)][MaterialToggle] _InvertMask ("Invert Mask", Float ) = 1
        _MaskExclusion ("Mask Exclusion", 2D) = "black" {}
        [Space(35)]_WindOffsetMask ("Wind Offset Mask", 2D) = "white" {}
        _WindDirection ("Wind Direction", Vector) = (0,0.02,0,0)
        _Turbulence ("Turbulence", Float ) = 5

        [Space(45)][MaterialToggle] _VisualizeWave ("Visualize Wave", Float ) = 0
        [MaterialToggle] _UseWorldCoordinate ("Use World Coordinate", Float ) = 0
        [Space(25)]_WaveTiling ("Wave Tiling", Float ) = 1
        _WaveTexture ("Wave Texture", 2D) = "white" {}
        _WaveTextureAmount ("Texture Amount", Range(0, 1.5)) = 0.5
        [Space(35)]_WaveMask ("Wave Mask", 2D) = "white" {}
        [Space(15)]_Deformation ("Deformation", Float ) = 1
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
            uniform float4 _WindDirection;
            uniform float _Turbulence;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform sampler2D _WaveMask; uniform float4 _WaveMask_ST;
            uniform sampler2D _WindOffsetMask; uniform float4 _WindOffsetMask_ST;
            uniform sampler2D _SpecGlossMap; uniform float4 _SpecGlossMap_ST;
            uniform float _SpecularIntensity;
            uniform float _Glossiness;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _NormalIntensity;
            uniform float _Desaturate;
            uniform float _AoIntensity;
            uniform sampler2D _OcclusionMap; uniform float4 _OcclusionMap_ST;
            uniform float _AmbientLight;
            uniform float4 _EmissionColor;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float _EmissiveIntensity;
            uniform float _FresnelStrength;
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
                float4 vertexColor : COLOR;
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
                float4 vertexColor : COLOR;
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
                o.vertexColor = v.vertexColor;
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
                float4 _WaveMask_var = tex2Dlod(_WaveMask,float4(TRANSFORM_TEX(o.uv0, _WaveMask),0.0,0));
                float3 WaveMask = (node_5837*_WaveMask_var.rgb);
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float4 _WindOffsetMask_var = tex2Dlod(_WindOffsetMask,float4(TRANSFORM_TEX(o.uv0, _WindOffsetMask),0.0,0));
                float4 node_6117 = _Time;
                float3 VertexOffset = ((v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1)+(MaskExclusion*(_WindOffsetMask_var.rgb*(_WindDirection.rgb*(sin(lerp(0.0,_Turbulence,node_6117.g))*0.5+0.5)))*o.vertexColor.rgb));
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 Normalmap = lerp(float3(0,0,1),_BumpMap_var.rgb,_NormalIntensity);
                float3 normalLocal = Normalmap;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_3968 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_3968), node_3968, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
                clip(Cutout - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _SpecGlossMap_var = tex2D(_SpecGlossMap,TRANSFORM_TEX(i.uv0, _SpecGlossMap));
                float Glossiness = (_SpecGlossMap_var.a*_Glossiness);
                float gloss = Glossiness;
                float perceptualRoughness = 1.0 - Glossiness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
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
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float Fresnel = (((0.95*pow(1.0-max(0,dot(normalDirection, viewDirection)),1.0))+0.05)*_FresnelStrength);
                float node_4966 = Fresnel;
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 Specular = (_SpecColor.rgb*_SpecGlossMap_var.rgb*_SpecularIntensity);
                float3 specularColor = Specular;
                float specularMonochrome;
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
                float4 _WaveMask_var = tex2D(_WaveMask,TRANSFORM_TEX(i.uv0, _WaveMask));
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - _WaveMask_var.rgb))))), _VisualizeWave );
                float3 diffuseColor = Albedo; // Need this for specular when using metallic
                diffuseColor = EnergyConservationBetweenDiffuseAndSpecular(diffuseColor, specularColor, specularMonochrome);
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular + float3(node_4966,node_4966,node_4966));
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                float AmbientLight = _AmbientLight;
                float node_9823 = AmbientLight;
                indirectDiffuse += float3(node_9823,node_9823,node_9823); // Diffuse Ambient Light
                indirectDiffuse += gi.indirect.diffuse;
                float4 _OcclusionMap_var = tex2D(_OcclusionMap,TRANSFORM_TEX(i.uv0, _OcclusionMap));
                float Aomap = saturate((1.0-(1.0-_OcclusionMap_var.r)*(1.0-lerp(1,0,_AoIntensity))));
                indirectDiffuse *= Aomap; // Diffuse AO
                diffuseColor *= 1-specularMonochrome;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 Emissivemap = ((_EmissionColor.rgb*_EmissionMap_var.rgb)*_EmissiveIntensity);
                float3 emissive = Emissivemap;
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
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
            uniform float4 _WindDirection;
            uniform float _Turbulence;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform sampler2D _WaveMask; uniform float4 _WaveMask_ST;
            uniform sampler2D _WindOffsetMask; uniform float4 _WindOffsetMask_ST;
            uniform sampler2D _SpecGlossMap; uniform float4 _SpecGlossMap_ST;
            uniform float _SpecularIntensity;
            uniform float _Glossiness;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _NormalIntensity;
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
                float4 vertexColor : COLOR;
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
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
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
                float4 _WaveMask_var = tex2Dlod(_WaveMask,float4(TRANSFORM_TEX(o.uv0, _WaveMask),0.0,0));
                float3 WaveMask = (node_5837*_WaveMask_var.rgb);
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float4 _WindOffsetMask_var = tex2Dlod(_WindOffsetMask,float4(TRANSFORM_TEX(o.uv0, _WindOffsetMask),0.0,0));
                float4 node_6117 = _Time;
                float3 VertexOffset = ((v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1)+(MaskExclusion*(_WindOffsetMask_var.rgb*(_WindDirection.rgb*(sin(lerp(0.0,_Turbulence,node_6117.g))*0.5+0.5)))*o.vertexColor.rgb));
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 Normalmap = lerp(float3(0,0,1),_BumpMap_var.rgb,_NormalIntensity);
                float3 normalLocal = Normalmap;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_3968 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_3968), node_3968, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
                clip(Cutout - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _SpecGlossMap_var = tex2D(_SpecGlossMap,TRANSFORM_TEX(i.uv0, _SpecGlossMap));
                float Glossiness = (_SpecGlossMap_var.a*_Glossiness);
                float gloss = Glossiness;
                float perceptualRoughness = 1.0 - Glossiness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 Specular = (_SpecColor.rgb*_SpecGlossMap_var.rgb*_SpecularIntensity);
                float3 specularColor = Specular;
                float specularMonochrome;
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
                float4 _WaveMask_var = tex2D(_WaveMask,TRANSFORM_TEX(i.uv0, _WaveMask));
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - _WaveMask_var.rgb))))), _VisualizeWave );
                float3 diffuseColor = Albedo; // Need this for specular when using metallic
                diffuseColor = EnergyConservationBetweenDiffuseAndSpecular(diffuseColor, specularColor, specularMonochrome);
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                diffuseColor *= 1-specularMonochrome;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
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
            Cull Back
            
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
            uniform float4 _WindDirection;
            uniform float _Turbulence;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform sampler2D _WaveMask; uniform float4 _WaveMask_ST;
            uniform sampler2D _WindOffsetMask; uniform float4 _WindOffsetMask_ST;
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
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float4 posWorld : TEXCOORD4;
                float3 normalDir : TEXCOORD5;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
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
                float4 _WaveMask_var = tex2Dlod(_WaveMask,float4(TRANSFORM_TEX(o.uv0, _WaveMask),0.0,0));
                float3 WaveMask = (node_5837*_WaveMask_var.rgb);
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float4 _WindOffsetMask_var = tex2Dlod(_WindOffsetMask,float4(TRANSFORM_TEX(o.uv0, _WindOffsetMask),0.0,0));
                float4 node_6117 = _Time;
                float3 VertexOffset = ((v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1)+(MaskExclusion*(_WindOffsetMask_var.rgb*(_WindDirection.rgb*(sin(lerp(0.0,_Turbulence,node_6117.g))*0.5+0.5)))*o.vertexColor.rgb));
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 Diffuse = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float AlbedoA = Diffuse.a;
                float node_3968 = AlbedoA;
                float4 _AdditionalCutoutmap_var = tex2D(_AdditionalCutoutmap,TRANSFORM_TEX(i.uv0, _AdditionalCutoutmap));
                float Cutout = saturate(((lerp( lerp( (1.0 - node_3968), node_3968, _InvertAlbedoAlpha ), 1.0, _DisableAlbedoAlphaChannel )-_AlphaAmount)*(lerp( (1.0 - _AdditionalCutoutmap_var.r), _AdditionalCutoutmap_var.r, _InvertAdditionalmap )+1.0)));
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
            uniform float4 _WindDirection;
            uniform float _Turbulence;
            uniform fixed _InvertWaveDirection;
            uniform sampler2D _WaveTexture; uniform float4 _WaveTexture_ST;
            uniform float _Speed;
            uniform sampler2D _WaveMask; uniform float4 _WaveMask_ST;
            uniform sampler2D _WindOffsetMask; uniform float4 _WindOffsetMask_ST;
            uniform sampler2D _SpecGlossMap; uniform float4 _SpecGlossMap_ST;
            uniform float _SpecularIntensity;
            uniform float _Glossiness;
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
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
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
                float4 _WaveMask_var = tex2Dlod(_WaveMask,float4(TRANSFORM_TEX(o.uv0, _WaveMask),0.0,0));
                float3 WaveMask = (node_5837*_WaveMask_var.rgb);
                float4 _MaskExclusion_var = tex2Dlod(_MaskExclusion,float4(TRANSFORM_TEX(o.uv0, _MaskExclusion),0.0,0));
                float MaskExclusion = lerp( (1.0 - _MaskExclusion_var.r), _MaskExclusion_var.r, _InvertMask );
                float4 _WindOffsetMask_var = tex2Dlod(_WindOffsetMask,float4(TRANSFORM_TEX(o.uv0, _WindOffsetMask),0.0,0));
                float4 node_6117 = _Time;
                float3 VertexOffset = ((v.normal*(WaveMask*(MaskExclusion*_Deformation))*0.1)+(MaskExclusion*(_WindOffsetMask_var.rgb*(_WindDirection.rgb*(sin(lerp(0.0,_Turbulence,node_6117.g))*0.5+0.5)))*o.vertexColor.rgb));
                v.vertex.xyz += VertexOffset;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                i.normalDir = normalize(i.normalDir);
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
                float4 _WaveMask_var = tex2D(_WaveMask,TRANSFORM_TEX(i.uv0, _WaveMask));
                float3 Albedo = lerp( (_Color.rgb*lerp(Diffuse.rgb,dot(Diffuse.rgb,float3(0.3,0.59,0.11)),_Desaturate)), lerp(float3(0,1,1),lerp(node_3039.rgb,dot(node_3039.rgb,float3(0.3,0.59,0.11)),_Desaturate),saturate((1.0-(1.0-(1.0 - node_5837))*(1.0-(1.0 - _WaveMask_var.rgb))))), _VisualizeWave );
                float3 diffColor = Albedo;
                float4 _SpecGlossMap_var = tex2D(_SpecGlossMap,TRANSFORM_TEX(i.uv0, _SpecGlossMap));
                float3 Specular = (_SpecColor.rgb*_SpecGlossMap_var.rgb*_SpecularIntensity);
                float3 specColor = Specular;
                float specularMonochrome = max(max(specColor.r, specColor.g),specColor.b);
                diffColor *= (1.0-specularMonochrome);
                float Glossiness = (_SpecGlossMap_var.a*_Glossiness);
                float roughness = 1.0 - Glossiness;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
